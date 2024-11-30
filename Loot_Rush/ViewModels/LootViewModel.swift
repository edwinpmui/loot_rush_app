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
    @Published var target: Picture? = nil
    
    func setTarget(pic: Picture) {
        target = pic
    }
    
    func generatePiece() -> Bool {
        row = Int.random(in: 0..<target!.rows)
        col = Int.random(in: 0..<target!.cols)
        let isNew = !target!.collected[row][col]
        if isNew {
            target!.collected[row][col] = true
            target!.numCollected += 1
        }
        return isNew
    }
}
