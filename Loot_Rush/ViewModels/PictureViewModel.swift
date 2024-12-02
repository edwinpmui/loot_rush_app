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
        Picture(name: "Mountain", length: 900, width: 900, pictureName: "Mountain.jpg"),
        Picture(name: "Watercolor", length: 900, width: 900, pictureName: "Watercolor.jpg"),
        Picture(name: "City-Life", length: 1260, width: 1260, pictureName: "City-Life.jpg"),
        Picture(name: "Ancient-China", length: 1600, width: 1600, pictureName: "Ancient-China.jpg")
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
    func generatePiece() {
        let index = Int.random(in: 0..<4)
        setTarget(pic: pictures[index])
        guard let target = target else { return }
        row = Int.random(in: 0..<target.rows)
        col = Int.random(in: 0..<target.cols)
        isNew = !target.collected[row][col]
        if isNew {
            target.collected[row][col] = true
            target.numCollected += 1
        }
    }
}
