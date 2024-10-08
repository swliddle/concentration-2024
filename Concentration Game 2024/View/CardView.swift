//
//  CardView.swift
//  Concentration Game 2024
//
//  Created by Stephen Liddle on 10/8/24.
//

import SwiftUI

struct CardView: View {
    let card: ConcentrationGame<String>.Card

    @State private var animatedBonusRemaining = 0.0

    var body: some View {
        GeometryReader { geometry in
            if !card.isMatched || card.isFaceUp {
                ZStack {
                    let animation = Animation.linear(duration: 1.0).repeatForever(
                        autoreverses: false
                    )

                    Group {
                        if card.isConsumingBonusTime {
                            Pie(
                                startAngle: angle(for: 0),
                                endAngle: angle(for: -animatedBonusRemaining)
                            )
                            .onAppear {
                                animatedBonusRemaining = card.bonusRemainingPercent
                                withAnimation(.linear(duration: card.bonusTimeRemaining)) {
                                    animatedBonusRemaining = 0
                                }
                            }
                        } else {
                            Pie(
                                startAngle: angle(for: 0),
                                endAngle: angle(for: -card.bonusRemainingPercent)
                            )
                        }
                    }
                    .opacity(0.4)
                    .padding(geometry.size.width * Card.paddingScaleFactor)
                    Text(card.content)
                        .font(systemFont(for: geometry.size))
                        .rotationEffect(Angle(degrees: card.isMatched ? 360 : 0))
                        .animation(animation, value: card.isMatched)
                }
                .cardify(isFaceUp: card.isFaceUp)
                .transition(.scale)
                .foregroundStyle(.blue)
            }
        }
        .aspectRatio(Card.aspectRatio, contentMode: .fit)
    }

    // MARK: - Helpers

    private func angle(for percentOfCircle: Double) -> Angle {
        Angle.degrees(percentOfCircle * 360 - 90)
    }

    // MARK: - Drawing constants

    private struct Card {
        static let aspectRatio = 5.0/7.0
        static let cornerRadius = 10.0
        static let fontScaleFactor = 0.75
        static let paddingScaleFactor = 0.04
    }

    private func systemFont(for size: CGSize) -> Font {
        .system(size: min(size.width, size.height) * Card.fontScaleFactor)
    }
}

#Preview {
    CardView(
        card: ConcentrationGame<String>.Card(isFaceUp: true, content: "🍑")
    )
    .padding(50)
}
