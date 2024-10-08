//
//  EmojiConcentrationGame.swift
//  Concentration Game 2024
//
//  Created by Stephen Liddle on 10/8/24.
//

import SwiftUI

@Observable class EmojiConcentrationGame {

    static let emojis = ["🥨", "🥭", "🥑", "🌶️", "🥝", "🥥"]

    static func createGame() -> ConcentrationGame<String> {
        ConcentrationGame<String>(numberOfPairsOfCards: Int.random(in: 2...emojis.count)) { emojis[$0] }
    }

    // MARK: - Properties

    private var game = createGame()
    private var isVisible = false

    // MARK: - Model access

    var dealtCards: Array<ConcentrationGame<String>.Card> {
        isVisible ? game.cards : []
    }

    var score: Int {
        game.score
    }

    // MARK: - User intents

    func choose(_ card: ConcentrationGame<String>.Card) {
        withAnimation(.easeIn(duration: Constants.animationDuration)) {
            game.choose(card)
        }
    }

    func dealCards() {
        withAnimation(.easeInOut(duration: Constants.animationDuration)) {
            isVisible = true
        }
    }

    func newGame() {
        withAnimation(.easeInOut(duration: Constants.animationDuration)) {
            isVisible = false
            game = EmojiConcentrationGame.createGame()
        }

        dealCards()
    }

    // MARK: - Constants {

    private struct Constants {
        static let animationDuration = 0.5
    }
}
