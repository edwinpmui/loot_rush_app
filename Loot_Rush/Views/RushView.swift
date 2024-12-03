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
    @EnvironmentObject private var picViewModel: PictureViewModel
    @Environment(\.dismiss) private var dismiss
    @Query private var pictures: [Picture]

    var body: some View {
        VStack {
            Map(coordinateRegion: $viewModel.region,
                interactionModes: .all, showsUserLocation: true, 
                annotationItems: viewModel.selectedRoute?.waypoints ?? []) { waypoint in
                MapPin(coordinate: waypoint.coordinate)
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

            Button("Collect") {
                viewModel.checkIfWithinRadius()
            }
            .padding()
            
            Text("\(pictures.count)")
            
            NavigationLink(destination: LootView(picture: pictures.randomElement()!), isActive: $viewModel.shouldNavigateToLootView) {
                Text("Go to piece")
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
            viewModel.shouldNavigateToLootView = false
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
