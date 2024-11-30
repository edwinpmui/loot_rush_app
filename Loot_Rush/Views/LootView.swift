//
//  LootView.swift
//  Loot_Rush
//
//  Created by David Fu on 11/29/24.
//

import SwiftUI
import UIKit

struct LootView: View {
    @EnvironmentObject var lootViewModel: LootViewModel
    @State private var moveUp = false
    
    @State private var displayText = "Click on the mystery box to claim your piece!"
    @State private var pieceStyle: Color = Color.primary
    @State private var boxDisabled: Bool = false
    @State private var pieceDisabled: Bool = true
    
    var body: some View {
        VStack {
            Text(displayText)
                .padding()
                .frame(alignment: .top)
            
            Spacer()
            
            ZStack {
                Button(action: generatePiece) {
                    Image("MysteryBox")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300, height: 300)
                }
                .disabled(boxDisabled)
                
                Image(systemName: "puzzlepiece.extension")
                    .font(.largeTitle)
                    .offset(x: 0, y: -25)
                    .offset(y: moveUp ? -200 : 0)
                    .animation(.easeInOut(duration: 3), value: moveUp)
                    .foregroundStyle(pieceStyle)
            }
            
            Spacer()
        }
        .padding()
    }
    
    func generatePiece() {
        moveUp = true
        boxDisabled = true
        displayText = "And your \(lootViewModel.target?.name ?? "picture") piece is..."
        
        if let image = UIImage(named: "Puppy") {
            let width = image.size.width
            let height = image.size.height
            print("Width: \(width), Height: \(height)")
        }
        
    }
}

#Preview {
    LootView()
        .environmentObject(LootViewModel())
}
