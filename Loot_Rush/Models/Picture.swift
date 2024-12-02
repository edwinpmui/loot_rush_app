//
//  PictureModel.swift
//  Loot_Rush
//
//  Created by David Fu on 11/29/24.
//

import Foundation
import SwiftData

class Picture: Identifiable, ObservableObject {
    let id = UUID()
    let name: String
    @Published var numCollected: Int = 0
    let rows: Int = 10
    let cols: Int = 10
    let totalPieces: Int = 100
    @Published var collected: [[Bool]]
    let pictureName: String
    
    let length: CGFloat  // Full picture length
    let width: CGFloat   // Full picture width
    
    var pieceLength: CGFloat { length / CGFloat(rows) }  // Size of each grid piece
    var pieceWidth: CGFloat { width / CGFloat(cols) }
    
    init(name: String, length: CGFloat, width: CGFloat, pictureName: String) {
        self.name = name
        self.length = length
        self.width = width
        self.pictureName = pictureName
        self.collected = Array(repeating: Array(repeating: false, count: cols), count: rows)
    }
}
