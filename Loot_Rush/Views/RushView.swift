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
    @Query private var pictures: [Picture]
    
    @State private var nearPin = false
    @State private var canPickRoute = true

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

//            Button("Choose New Route") {
//                viewModel.generateRandomRoutes()
//                canPickRoute = false
//                await delayRouteGeneration()
//            }
//            .padding()
//            .disabled(!canPickRoute)
            
            Button(action: {
                Task {
                    viewModel.generateRandomRoutes()
                    canPickRoute = false
                    await delayRouteGeneration()
                }
            }, label: {
                Text("Choose New Route")
            })
            .padding()
            .disabled(!canPickRoute)

            Button("Collect") {
                viewModel.checkIfWithinRadius()
                nearPin = viewModel.shouldNavigateToLootView
            }
            .padding()
            
            NavigationLink(destination: LootView(picture: pictures.randomElement()!)) {
                Text("Go to piece")
            }
            .disabled(!nearPin)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                NavigationLink(destination: HomeView().navigationBarBackButtonHidden(true)) {
                    HStack {
                        Image(systemName: "arrow.backward")
                        Text("Home")
                    }
                }
            }
        }
        .onAppear {
            viewModel.loadRush()
            if !viewModel.locationsGenerated {
                viewModel.generateRandomRoutes()
                viewModel.locationsGenerated = true
            }
        }
    }
    
    func delayRouteGeneration() async {
        try? await Task.sleep(nanoseconds: 5_000_000_000)
        canPickRoute = true
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
