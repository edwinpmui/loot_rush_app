//
//  CollectionView.swift
//  Loot_Rush
//
//  Created by David Fu on 11/29/24.
//

import SwiftUI

struct CollectionView: View {
    @EnvironmentObject var picViewModel: PictureViewModel

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                    ForEach(0..<picViewModel.pictures.count, id: \.self) { index in
                        PuzzleRow(index: index)
                    }
                }
                .padding()
            }
            .navigationTitle("Collection")
        }
    }
}

struct PuzzleRow: View {
    var index: Int
    @EnvironmentObject var picViewModel: PictureViewModel

    var body: some View {
        let picture = picViewModel.pictures[index]

        // Wrapping everything inside a NavigationLink
        NavigationLink(destination: PictureView(picture: picture)) {
            ZStack {
                // Check if the image is available in the asset catalog
                if let uiImage = UIImage(named: picture.pictureName) {
                    // Successfully loaded image
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 150, height: 150)
                        .clipped()
                        .blur(radius: 6)
                        .cornerRadius(10)
                } else {
                    // Fallback: Show a default image if the specified image is not found
                    Image("defaultImageName") // Replace with a known fallback image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 150, height: 150)
                        .clipped()
                        .blur(radius: 10)
                        .cornerRadius(10)
                }

                // Text Overlay with puzzle name and progress
                VStack {
                    Spacer()
                    Text(picture.name)
                        .font(.headline)
                        .foregroundColor(.white)
                        .shadow(radius: 10)

                    Text("\(picture.numCollected)/100")
                        .font(.subheadline)
                        .foregroundColor(.white)
                        .shadow(radius: 10)
                    Spacer()
                }
                .frame(width: 150, height: 150) // Ensure the text overlay fits within the frame
                .background(Color.black.opacity(0.5)) // Optional: Add a semi-transparent background for better readability
                .cornerRadius(10) // Rounded corners for the overlay
            }
            .frame(width: 150, height: 150) // Ensure square shape
            .padding(5)
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 5)
        }
        .buttonStyle(PlainButtonStyle()) // Ensures it remains clickable
    }
}

#Preview {
    CollectionView()
        .environmentObject(PictureViewModel())
}
