//
//  RushView.swift
//  Loot_Rush
//
//  Created by David Fu on 11/29/24.
//

import SwiftUI
import MapKit
import SwiftData

struct RushView: View {
    @Environment(\.modelContext) private var modelContext
    @EnvironmentObject private var viewModel: RushViewModel
    @Environment(\.dismiss) private var dismiss

    @State private var showAlert = false
    @State private var selectedWaypoint: Waypoint?

    var body: some View {
        NavigationView {
            VStack {
                Map(coordinateRegion: $viewModel.region,
                    showsUserLocation: true,
                    annotationItems: viewModel.selectedRoute?.waypoints ?? []) { waypoint in
                    MapPin(coordinate: waypoint.coordinate, tint: .red)
                }
                .frame(height: 300)

                Picker("Select a Route", selection: $viewModel.selectedRoute) {
                    ForEach(viewModel.routes) { route in
                        Text(route.name).tag(route as Route?)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()

                Button("Choose New Route") {
                    viewModel.generateRandomRoutes()
                }
                .padding()

                if let selectedRoute = viewModel.selectedRoute {
                    ForEach(selectedRoute.waypoints, id: \.self) { waypoint in
                        if viewModel.isWithinRadius(of: waypoint.coordinate) {
                            Button("Waypoint") {
                                selectedWaypoint = waypoint
                                showAlert = true
                            }
                            .alert(isPresented: $showAlert) {
                                Alert(
                                    title: Text("Waypoint Reached"),
                                    message: Text("You have reached a waypoint. Do you want to view the loot?"),
                                    primaryButton: .default(Text("Yes")) {
                                        // Navigate to LootView
                                        if let selectedWaypoint = selectedWaypoint {
                                            NavigationLink(destination: LootView()) {
                                                EmptyView()
                                            }.hidden()
                                        }
                                    },
                                    secondaryButton: .cancel()
                                )
                            }
                        }
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        HStack {
                            Image(systemName: "arrow.backward")
                            Text("Home")
                        }
                    }
                }
            }
            .onAppear {
                viewModel.loadRush()
            }
        }
    }
}
#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Picture.self, configurations: config)
        return RushView()
             .modelContainer(container)
             .environmentObject(RushViewModel())
             .environmentObject(PictureViewModel())
    } catch {
        fatalError("Failed to create model container.")
    }
}
