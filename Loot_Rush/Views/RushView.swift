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
    @StateObject private var viewModel = RushViewModel()
    @State var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 39.95193335771201, longitude: -75.20110874816821),
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )
    
    var body: some View {
        NavigationView {
            VStack {
                Map(coordinateRegion: $region,
                    showsUserLocation: true,
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

                
                NavigationLink(destination: LootView()) {
                    Text("Loot view")
                }
                
                if let selectedRoute = viewModel.selectedRoute {
                    ForEach(selectedRoute.waypoints, id: \.self) { waypoint in
                        NavigationLink(destination: LootView()) {
                            Text("Waypoint")
                        }
                    }
                }
            }
            .onAppear {
                viewModel.loadRush()
                if let location = viewModel.location {
                    region.center = location.coordinate
                    viewModel.generateRandomRoutes()
                }
            }
        }
    }
}


#Preview {
    RushView()
}
