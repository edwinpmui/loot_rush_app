//
//  ContentView.swift
//  Loot_Rush
//
//  Created by David Fu on 11/29/24.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    @State private var navigationPath = NavigationPath()
    @StateObject var viewModel = LootRushViewModel()
    @StateObject var lootViewModel = LootViewModel()

    var body: some View {
        NavigationStack(path: $navigationPath) {
            VStack {
                Spacer()
                
                VStack(spacing: 20) {
                    Text("Loot Rush")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.yellow)
                        .padding(.bottom, 50)
                    
                    NavigationLink(destination: RushView()) {
                        Text("Rush")
                            .font(.headline)
                            .padding()
                            .frame(maxWidth: 200)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .shadow(radius: 5)
                    }

                    NavigationLink(destination: CollectionView()) {
                        Text("Collection")
                            .font(.headline)
                            .padding()
                            .frame(maxWidth: 200)
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .shadow(radius: 5)
                    }
                }

                Spacer()

                Text("""
                     **Welcome to Loot Rush!**

                     - Click **Rush** to go onto the map and start hunting for pieces.
                     - Click **Collection** to view your current collection of pictures and pieces.
                     - May RNGesus be in your favor!
                     """)
                    .font(.body)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding()
                    .background(Color(UIColor.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal)

                Spacer()
            }
            .padding()
        }
        .environmentObject(lootViewModel)
    }
}

#Preview {
    HomeView()
}
