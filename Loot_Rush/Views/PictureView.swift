//
//  PictureView.swift
//  Loot_Rush
//
//  Created by David Fu on 11/29/24.
//

import SwiftUI

struct PictureView: View {
    var picture: Picture
    
    var body: some View {
        VStack {
            ZStack {
                // Display the picture as the background
                Image(picture.pictureName)
                    .resizable()
                    .scaledToFit()
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
                                .fill(Color.black.opacity(0.5)) // Black grid overlay with some transparency
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
                    .padding(.top)
            }
        }
        .navigationTitle(picture.name) // Set the navigation title to the picture name
        .padding()
    }
}

#Preview {
    PictureView(picture: PictureViewModel().pictures[0])
}
