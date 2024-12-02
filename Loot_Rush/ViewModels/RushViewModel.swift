//
//  RushViewModel.swift
//  Loot_Rush
//
//  Created by David Fu on 11/30/24.
//

import SwiftUI
import MapKit
import CoreLocation

class RushViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var selectedRoute: Route?
    @Published var routes: [Route] = []
    @Published var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )
    @Published var location: CLLocation?
    
    private let locationManager = CLLocationManager()
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.first
        if let location = location {
            region.center = location.coordinate
            generateRandomRoutes()
        }
    }
    
    func generateRandomRoutes() {
        guard let userLocation = location else { return }
        
        func randomCoordinate(from coordinate: CLLocationCoordinate2D, within radius: Double) -> CLLocationCoordinate2D {
            let randomAngle = Double.random(in: 0..<360) * .pi / 180
            let randomDistance = Double.random(in: 0..<radius)
            let deltaLatitude = randomDistance * cos(randomAngle) / 111000
            let deltaLongitude = randomDistance * sin(randomAngle) / (111000 * cos(coordinate.latitude * .pi / 180))
            return CLLocationCoordinate2D(latitude: coordinate.latitude + deltaLatitude, longitude: coordinate.longitude + deltaLongitude)
        }
        
        let radius: Double = 1000 // 1 km radius
        routes = [
            Route(name: "Route 1", waypoints: [randomCoordinate(from: userLocation.coordinate, within: radius)]),
            Route(name: "Route 2", waypoints: [randomCoordinate(from: userLocation.coordinate, within: radius)]),
            Route(name: "Route 3", waypoints: [randomCoordinate(from: userLocation.coordinate, within: radius)])
        ]
        
        selectedRoute = routes.randomElement()
    }
    
    func isWithinRadius(of waypoint: CLLocationCoordinate2D) -> Bool {
        guard let userLocation = location else { return false }
        let waypointLocation = CLLocation(latitude: waypoint.latitude, longitude: waypoint.longitude)
        let distance = userLocation.distance(from: waypointLocation)
        return distance <= 100 // Radius in meters
    }
}
