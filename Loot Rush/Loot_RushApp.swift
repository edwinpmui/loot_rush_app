//
//  Loot_RushApp.swift
//  Loot Rush
//
//  Created by user268667 on 11/21/24.
//

import SwiftUI

@main
struct Loot_RushApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
