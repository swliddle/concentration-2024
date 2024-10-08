//
//  Cardify.swift
//  Concentration Game 2024
//
//  Created by Stephen Liddle on 10/8/24.
//
import SwiftUI

struct Cardify: Animatable, ViewModifier {
    var isFaceUp: Bool {
        rotation < 90
    }

    var animatableData: Double {
        get { rotation }
        set { rotation = newValue }
    }

    var rotation: Double

    init(isFaceUp: Bool) {
        rotation = isFaceUp ? 0 : 180
    }

    func body(content: Content) -> some View {
        GeometryReader { geometry in
            ZStack {
                if isFaceUp {
                    RoundedRectangle(cornerRadius: cornerRadius(for: geometry.size)).fill(.white)
                    RoundedRectangle(cornerRadius: cornerRadius(for: geometry.size)).stroke()
                } else {
                    RoundedRectangle(cornerRadius: cornerRadius(for: geometry.size)).fill()
                }

                content.opacity(isFaceUp ? 1 : 0)
            }
            .rotation3DEffect(Angle(degrees: rotation), axis: (0, 1, 0))
        }
    }

    // MARK: - Drawing constants

    private func cornerRadius(for size: CGSize) -> Double {
        min(size.width, size.height) * 0.08
    }
}

extension View {
    func cardify(isFaceUp: Bool) -> some View {
        modifier(Cardify(isFaceUp: isFaceUp))
    }
}
