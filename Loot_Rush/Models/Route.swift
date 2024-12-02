//
//  Route.swift
//  Loot_Rush
//
//  Created by user268667 on 12/2/24.
//

import CoreLocation
import Foundation

struct Route: Identifiable {
    let id = UUID()
    let name: String
    let waypoints: [CLLocationCoordinate2D]
}
