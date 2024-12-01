//
//  PictureModel.swift
//  Loot_Rush
//
//  Created by David Fu on 11/29/24.
//

import Foundation
import SwiftData

class Picture {
    let name: String
    var numCollected: Int
    let rows: Int
    let cols: Int
    let length: Int
    let width: Int
    let totalPieces: Int
    var collected: [[Bool]]
    let pictureName: String
    
    init(name: String, rows: Int, cols: Int, length: Int, width: Int, pictureName: String) {
        self.name = name
        self.numCollected = 0
        self.rows = rows
        self.cols = cols
        self.length = length
        self.width = width
        self.totalPieces = rows * cols
        self.collected = Array(repeating: Array(repeating: false, count: cols), count: rows)
        self.pictureName = pictureName
    }
}
