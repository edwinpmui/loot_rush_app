//
//  LootViewModel.swift
//  Loot_Rush
//
//  Created by David Fu on 11/30/24.
//

import Foundation
import SwiftData

class LootViewModel: ObservableObject {
    @Published var picture: Picture? = nil
    @Published var row: Int = 0
    @Published var col: Int = 0
    @Published var isNew: Bool = false
    @Published var target: Picture? = nil
    
    // Again, this is also temporary
    init() {
        setTarget(pic: Picture(name: "Puppy", rows: 5, cols: 4, length: 800, width: 450, pictureName: "Puppy"))
    }
    
    func setTarget(pic: Picture) {
        target = pic
    }
    
    // Returns true if piece is new, false otherwise
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
