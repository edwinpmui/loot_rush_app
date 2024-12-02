//
//  PictureViewModel.swift
//  Loot_Rush
//
//  Created by Chris Y on 12/1/24.
//

import Foundation
import SwiftData
import SwiftUI

class PictureViewModel: ObservableObject {
    @Published var pictures: [Picture] = [
        Picture(name: "Mountain View", length: 900, width: 900, pictureName: "mount-fuji-textural-impressionist-palette-knife-impasto-oil-painting-mona-edulesco-mona-edulesco.jpg"),
        Picture(name: "Beach Sunset", length: 900, width: 900, pictureName: "1-watercolor-painting-golden-sunset-over-ocean-modern-impressionism-art-ocean-mounir-khalfouf.jpg"),
        Picture(name: "City Life", length: 1260, width: 1260, pictureName: "fachtali_abderrahim_-_Urban_Life_Abstract_Expressionist_Silhouette_Painting_-_(MeisterDrucke-1465388).jpg"),
        Picture(name: "Ancient China", length: 1600, width: 1600, pictureName: "f_19-x-19-cm-carre-d-artistes-f2--defaut-front-0.jpg")
    ]
    
    @Published var target: Picture? = nil
    @Published var row: Int = 0
    @Published var col: Int = 0
    @Published var isNew: Bool = false
    
    // Set the target picture for puzzle-solving
    func setTarget(pic: Picture) {
        target = pic
    }

    // Randomly generates a piece, checking if it's new and marks it collected
    func generatePiece(for picture: Picture) {
        // Find all uncollected pieces
        let uncollectedPieces = picture.collected.enumerated().flatMap { rowIndex, row in
            row.enumerated().compactMap { colIndex, isCollected in
                isCollected ? nil : (rowIndex, colIndex)
            }
        }
        
        // Randomly select an uncollected piece, if available
        if let randomPiece = uncollectedPieces.randomElement() {
            let (row, col) = randomPiece
            picture.collected[row][col] = true
            picture.numCollected += 1
            objectWillChange.send()  // Notify the view to update
        }
    }

    // Method to initiate the collection of a random piece for the target
    func collectRandomPiece() {
        guard let target = target else { return }
        generatePiece(for: target)
    }
}
