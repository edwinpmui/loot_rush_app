//
//  LootView.swift
//  Loot_Rush
//
//  Created by David Fu on 11/29/24.
//

import SwiftUI
import UIKit
import SwiftData

struct LootView: View {
    @Environment(\.modelContext) private var modelContext
    @EnvironmentObject var picViewModel: PictureViewModel
    @State private var moveUp = false
    
    @State private var displayText = "Click on the mystery box to claim your piece!"
    @State private var resultText = ""
    @State private var pieceStyle: Color = Color.primary
    @State private var boxDisabled: Bool = false
    @State private var pieceDisabled: Bool = true
    
    @State var picture: Picture
    
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
                
                NavigationLink(destination: PictureView(picture: picture).navigationBarBackButtonHidden(true)) {
                    Image(systemName: "puzzlepiece.extension")
                        .font(.largeTitle)
                        .frame(alignment: .center)
                        .foregroundStyle(pieceStyle)
                        .offset(y: moveUp ? 0 : 200) // Animation moves the piece up
                        .animation(.easeInOut(duration: 3), value: moveUp)
                }
                .disabled(pieceDisabled)
                .zIndex(1)
                .offset(y: -200)
            }
            Spacer()
        }
        .padding()
    }
    
    func generatePiece() {
        moveUp = true
        boxDisabled = true
        displayText = "And your \(picture.name) piece is..."
        picViewModel.setTarget(pic: picture)
        print("\(picture.name)")
        resultText = "(Drumroll)"
        picViewModel.generatePiece()
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

//#Preview {
//    do {
//        let config = ModelConfiguration(isStoredInMemoryOnly: true)
//        let container = try ModelContainer(for: Picture.self, configurations: config)
//        return LootView()
//             .modelContainer(container)
//             .environmentObject(PictureViewModel())
//    } catch {
//        fatalError("Failed to create model container.")
//    }
//}
