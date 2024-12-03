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
        row = Int.random(in: 0..<target!.rows)
        col = Int.random(in: 0..<target!.cols)
        isNew = !target!.collected[row][col]
        if isNew {
            target!.collected[row][col] = true
            target!.numCollected += 1
        }
    }
}
