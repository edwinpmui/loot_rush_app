//
//  ContentView.swift
//  Loot_Rush
//
//  Created by David Fu on 11/29/24.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var navigationPath = NavigationPath()
    @StateObject var rushViewModel = RushViewModel()
    @StateObject var lootViewModel = PictureViewModel()

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
            
            Button("Reset UserDefaults") {
                resetUserDefaults()
            }
        }
        .environmentObject(lootViewModel)
        .environmentObject(rushViewModel)
        .onAppear {checkFirstLaunch()}
    }
    
    func checkFirstLaunch() {
        let hasLaunchedBefore = UserDefaults.standard.bool(forKey: "hasLaunchedBefore")
        if !hasLaunchedBefore {
            modelContext.insert(Picture(name: "Mountain", length: 900, width: 900, pictureName: "Mountain.jpg"))
            modelContext.insert(Picture(name: "Watercolor", length: 900, width: 900, pictureName: "Watercolor.jpg"))
            modelContext.insert(Picture(name: "City-Life", length: 1260, width: 1260, pictureName: "City-Life.jpg"))
            modelContext.insert(Picture(name: "Ancient-China", length: 1600, width: 1600, pictureName: "Ancient-China.jpg"))
            UserDefaults.standard.set(true, forKey: "hasLaunchedBefore")
        }
    }
    
    func resetUserDefaults() {
        let defaults = UserDefaults.standard
        if let appDomain = Bundle.main.bundleIdentifier {
            defaults.removePersistentDomain(forName: appDomain)
        }
        defaults.synchronize()
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Picture.self, configurations: config)
        return HomeView()
             .modelContainer(container)
    } catch {
        fatalError("Failed to create model container.")
    }
}
