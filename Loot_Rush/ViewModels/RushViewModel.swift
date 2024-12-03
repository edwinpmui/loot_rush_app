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
    @Published var location: CLLocation?
    @Published var authorizationStatus: CLAuthorizationStatus?
    @Published var shouldNavigateToLootView: Bool = false

    private let locationManager = CLLocationManager()
    private var isRequestingLocation = false
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            requestLocation()
        case .denied, .restricted:
            break
        default:
            break
        }
    }
    
    func loadRush() {
        switch locationManager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            requestLocation()
        default:
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    func requestLocation() {
        locationManager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        isRequestingLocation = false
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        if let location = locations.first {
            self.location = location
            generateRandomRoutes()
            checkIfWithinRadius()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to get user location: \(error.localizedDescription)")
    }
    
    func generateRandomRoutes() {
        guard let userLocation = location else { return }
        
        func randomCoordinate(from coordinate: CLLocationCoordinate2D, within radius: Double) -> Location {
            let randomAngle = Double.random(in: 0..<360) * .pi / 180
            let randomDistance = Double.random(in: 0..<radius)
            let deltaLatitude = randomDistance * cos(randomAngle) / 111000
            let deltaLongitude = randomDistance * sin(randomAngle) / (111000 * cos(coordinate.latitude * .pi / 180))
            let location = Location(coordinate: CLLocationCoordinate2D(latitude: coordinate.latitude + deltaLatitude, longitude: coordinate.longitude + deltaLongitude))
            return location
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
        guard let userLocation = location else { return false }
        let waypointLocation = CLLocation(latitude: waypoint.latitude, longitude: waypoint.longitude)
        let distance = userLocation.distance(from: waypointLocation)
        return distance <= 100 // Radius in meters
    }

    func checkIfWithinRadius() {
        guard let selectedRoute = selectedRoute else { return }
        for waypoint in selectedRoute.waypoints {
            if isWithinRadius(of: waypoint.coordinate) {
                shouldNavigateToLootView = true
                return
            }
        }
        shouldNavigateToLootView = false
    }
}
