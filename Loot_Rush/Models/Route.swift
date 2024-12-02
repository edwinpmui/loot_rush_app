//
//  Route.swift
//  Loot_Rush
//
//  Created by user268667 on 12/2/24.
//

import CoreLocation
import Foundation

struct Route: Identifiable, Hashable {
    static func == (lhs: Route, rhs: Route) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(name)
    }
    
    let id = UUID()
    let name: String
    let waypoints: [Location]
}

struct Location: Identifiable, Hashable {
    static func == (lhs: Location, rhs: Location) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    var coordinate: CLLocationCoordinate2D
    let id = UUID()
}
