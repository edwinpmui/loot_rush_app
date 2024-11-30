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
}
