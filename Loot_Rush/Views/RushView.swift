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
    
    var body: some View {
    NavigationView {
        VStack {
            Map(coordinateRegion: $viewModel.region,
                showsUserLocation: true,
                annotationItems: viewModel.selectedRoute?.waypoints ?? []) { waypoint in
                if viewModel.isWithinRadius(of: waypoint.coordinate) {
                    NavigationLink(destination: LootView()) {
                        MapPin(coordinate: waypoint.coordinate)
                    }
                } else {
                    MapPin(coordinate: waypoint.coordinate)
                }
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
                        NavigationLink(destination: LootView()) {
                            Text("Waypoint")
                        }
                    } else {
                        Text("Waypoint")
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
