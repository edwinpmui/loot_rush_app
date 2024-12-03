//
//  PictureView.swift
//  Loot_Rush
//
//  Created by David Fu on 11/29/24.
//

import SwiftUI
import SwiftData

struct PictureView: View {
    @Environment(\.modelContext) private var modelContext
    var picture: Picture

    var body: some View {
        VStack {
            ZStack {
                // Display the picture as the background
                Image(picture.name)
                    .resizable()
                    .frame(width: 300, height: 300) // Fixed frame size
                    .clipped()
                
                // Overlay the grid with the collected pieces removed
                ForEach(0..<10, id: \.self) { row in
                    ForEach(0..<10, id: \.self) { col in
                        let index = row * 10 + col
                        // Check if the piece at this index is collected
                        if !picture.collected[row][col] {
                            // Show the grid piece if it's not collected
                            Rectangle()
                                .fill(Color.black.opacity(0.6)) // Black grid overlay with some transparency. Do 1 for final
                                .frame(width: 30, height: 30)
                                .position(
                                    x: CGFloat(col) * 30 + 15,  // Offset the x position
                                    y: CGFloat(row) * 30 + 15   // Offset the y position
                                )
                        }
                    }
                }
            }
            .frame(width: 300, height: 300) // Ensures the ZStack stays within the bounds of the image
            
            VStack {
                Text("\(picture.numCollected)/100")
                    .font(.title2)
                    .fontWeight(.bold)      // Make the text bold
                    .foregroundColor(.white) // Set text color to white for contrast
                    .padding(.vertical, 8)   // Add vertical padding for better spacing
                    .frame(maxWidth: .infinity) // Expand horizontally
                    .background(Color.blue.opacity(0.7)) // Background color with transparency
                    .cornerRadius(10)         // Rounded corners
                    .shadow(color: Color.gray.opacity(0.5), radius: 5, x: 0, y: 3) // Add a subtle shadow
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    NavigationLink(destination: CollectionView().navigationBarBackButtonHidden(true)) {
                        HStack {
                            Image(systemName: "arrow.backward")
                            Text("Collections")
                        }
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: RushView().navigationBarBackButtonHidden(true)) {
                        HStack {
                            Text("Rush View")
                            Image(systemName: "arrow.forward")
                        }
                    }
                }
            }
        }
        .navigationTitle(picture.name) // Set the navigation title to the picture name
        .padding()
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Picture.self, configurations: config)
        return PictureView(picture: PictureViewModel().pictures[0])
             .modelContainer(container)
    } catch {
        fatalError("Failed to create model container.")
    }
}
