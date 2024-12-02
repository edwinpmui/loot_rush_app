//
//  RushView.swift
//  Loot_Rush
//
//  Created by David Fu on 11/29/24.
//

import SwiftUI
import MapKit
import CoreLocation

struct RushView: View {
    @State private var selectedRoute: Route?
    @State private var routes: [Route] = []
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )
    @StateObject private var locationManager = LocationManager()
    
    var body: some View {
        VStack {
            Map(coordinateRegion: $region, annotationItems: selectedRoute?.waypoints ?? []) { waypoint in
                MapPin(coordinate: waypoint)
            }
            .frame(height: 300)
            
            Picker("Select a Route", selection: $selectedRoute) {
                ForEach(routes) { route in
                    Text(route.name).tag(route as Route?)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            
            Button("Choose New Route") {
                generateRandomRoutes()
            }
            .padding()
            
            NavigationLink(destination: HomeView()) {
                    Text("Back to Home")
                }
                .padding()
            
            if let selectedRoute = selectedRoute {
                    ForEach(selectedRoute.waypoints, id: \.self) { waypoint in
                        NavigationLink(destination: LootView()) {
                            Text("Waypoint")
                        }
                    }
                }
        }
        .onAppear {
            if let location = locationManager.location {
                region.center = location.coordinate
                generateRandomRoutes()
            }
        }
    }
    
    func generateRandomRoutes() {
        guard let userLocation = locationManager.location else { return }
        
        func randomCoordinate(from coordinate: CLLocationCoordinate2D, within radius: Double) -> CLLocationCoordinate2D {
            let randomAngle = Double.random(in: 0..<360) * .pi / 180
            let randomDistance = Double.random(in: 0..<radius)
            let deltaLatitude = randomDistance * cos(randomAngle) / 111000
            let deltaLongitude = randomDistance * sin(randomAngle) / (111000 * cos(coordinate.latitude * .pi / 180))
            return CLLocationCoordinate2D(latitude: coordinate.latitude + deltaLatitude, longitude: coordinate.longitude + deltaLongitude)
        }
        
        let radius: Double = 1000 
        routes = [
            Route(name: "Route 1", waypoints: [randomCoordinate(from: userLocation.coordinate, within: radius)]),
            Route(name: "Route 2", waypoints: [randomCoordinate(from: userLocation.coordinate, within: radius)]),
            Route(name: "Route 3", waypoints: [randomCoordinate(from: userLocation.coordinate, within: radius)])
        ]
        
        selectedRoute = routes.randomElement()
    }
    
    func isWithinRadius(of waypoint: CLLocationCoordinate2D) -> Bool {
        guard let userLocation = locationManager.location else { return false }
        let waypointLocation = CLLocation(latitude: waypoint.latitude, longitude: waypoint.longitude)
        let distance = userLocation.distance(from: waypointLocation)
        return distance <= 100
    }
}

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    @Published var location: CLLocation?
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.first
    }
}


#Preview {
    RushView()
}
