//
//  PictureModel.swift
//  Loot_Rush
//
//  Created by David Fu on 11/29/24.
//

import Foundation
import SwiftData

@Model
class Picture {
    let name: String
    var numCollected: Int
    var collected: [[Bool]]
    
}
