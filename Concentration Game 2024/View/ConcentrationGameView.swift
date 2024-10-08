//
//  ConcentrationGameView.swift
//  Concentration Game 2024
//
//  Created by Stephen Liddle on 10/8/24.
//

import SwiftUI

struct ConcentrationGameView: View {

    let emojiGame: EmojiConcentrationGame

    var body: some View {
        GeometryReader { geometry in
            VStack {
                LazyVGrid(columns: columns(for: geometry.size)) {
                    ForEach(emojiGame.dealtCards) { card in
                        CardView(card: card)
                            .transition(AnyTransition.offset(randomOffscreenLocation))
                            .onTapGesture {
                                emojiGame.choose(card)
                            }
                    }
                }
                Spacer()
                HStack {
                    Button("New Game") {
                        emojiGame.newGame()
                    }
                    Spacer()
                    Text("Score: \(emojiGame.score)")
                }
            }
            .padding()
        }
        .onAppear {
            emojiGame.dealCards()
        }

    }

    private var randomOffscreenLocation: CGSize {
        let radius = max(UIScreen.main.bounds.width, UIScreen.main.bounds.height) * 1.5
        let factor: Double = Int.random(in: 0...1) > 0 ? 1 : -1


        return CGSize(width: factor * radius, height: factor * radius)
    }

    // MARK: - Drawing constants

    private struct Game {
        static let desiredCardWidth = 125.0
    }

    private func columns(for size: CGSize) -> [GridItem] {
        Array.init(
            repeating: GridItem(.flexible()),
            count: Int(size.width / Game.desiredCardWidth)
        )
    }
}

#Preview {
    ConcentrationGameView(emojiGame: EmojiConcentrationGame())
}
