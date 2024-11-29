//
//  ContentView.swift
//  Loot_Rush
//
//  Created by David Fu on 11/29/24.
//

import SwiftUI

struct HomeView: View {
    @State private var navigationPath = NavigationPath()
    @StateObject var viewModel = LootRushViewModel()

    var body: some View {
        NavigationStack(path: $navigationPath) {
            VStack {
                Text("Loot Rush")
                    .font(.largeTitle)
                    .padding()

                NavigationLink(destination: RushView()) {
                    Text("Rush")
                }
                
                NavigationLink(destination: RushView()) {
                    Text("Collection")
                }

                Text("""
                     Welcome to Loot Rush!
                     Click 'Rush' to go onto the map and start hunting for pieces. 
                     Click 'Collection' to view your current collection of pictures and pieces.
                     May RNGesus be in your favor.
                     """)
                    .padding()
                    .multilineTextAlignment(.center)
            }
        }
    }
}

#Preview {
    HomeView()
}
