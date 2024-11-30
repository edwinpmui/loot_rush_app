//
//  RushView.swift
//  Loot_Rush
//
//  Created by David Fu on 11/29/24.
//

import SwiftUI

struct RushView: View {
    var body: some View {
        Text("Hello, Rush View!")
        
        NavigationLink(destination: LootView()) {
            Text("Loot View")
        }
    }
}

#Preview {
    RushView()
}
