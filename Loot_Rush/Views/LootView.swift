//
//  LootView.swift
//  Loot_Rush
//
//  Created by David Fu on 11/29/24.
//

import SwiftUI
import UIKit

struct LootView: View {
    @EnvironmentObject var picViewModel: PictureViewModel
    @State private var moveUp = false
    
    @State private var displayText = "Click on the mystery box to claim your piece!"
    @State private var resultText = ""
    @State private var pieceStyle: Color = Color.primary
    @State private var boxDisabled: Bool = false
    @State private var pieceDisabled: Bool = true
    
    @State private var selectedPicture: Picture? = nil
    
    var body: some View {
        VStack {
            Text(displayText)
                .padding()
                .frame(alignment: .top)
            Text(resultText)
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
                
                NavigationLink(destination: PictureView(picture: selectedPicture ?? picViewModel.pictures.first!)) {
                    Image(systemName: "puzzlepiece.extension")
                        .font(.largeTitle)
                        .offset(x: 0, y: -25)
                        .offset(y: moveUp ? -200 : 0)
                        .animation(.easeInOut(duration: 3), value: moveUp)
                        .foregroundStyle(pieceStyle)
                }
                .buttonStyle(PlainButtonStyle())
                .disabled(pieceDisabled)
            }
            
            Spacer()
        }
        .padding()
    }
    
    func generatePiece() {
        moveUp = true
        boxDisabled = true
        displayText = "And your \(picViewModel.target?.name ?? "picture") piece is..."
        resultText = "(Drumroll)"
        picViewModel.collectRandomPiece()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            showPiece()
        }
    }
    
    func showPiece() {
        if picViewModel.isNew {
            resultText = "new! Congratulations!"
            pieceStyle = Color.green
        } else {
            resultText = "not new. Better luck next time!"
            pieceStyle = Color.red
        }
        pieceDisabled = false
    }
}

#Preview {
    LootView()
        .environmentObject(PictureViewModel())
}
