//
//  PictureModel.swift
//  Loot_Rush
//
//  Created by David Fu on 11/29/24.
//

import Foundation
import SwiftData

@Model
class Picture: Identifiable {
    let id = UUID()
    let name: String
    var numCollected: Int = 0
    let rows: Int = 10
    let cols: Int = 10
    let totalPieces: Int = 100
    var collected: [[Bool]]
    let pictureName: String // This is the picture's source
    
    let length: CGFloat  // Full picture length
    let width: CGFloat   // Full picture width
    
    var pieceLength: CGFloat { length / CGFloat(rows) }  // Size of each grid piece
    var pieceWidth: CGFloat { width / CGFloat(cols) }
    
    init(name: String, length: CGFloat, width: CGFloat, pictureName: String) {
        self.name = name
        self.length = length
        self.width = width
        self.pictureName = pictureName
        self.collected = Array(repeating: Array(repeating: false, count: 10), count: 10)
    }
}
