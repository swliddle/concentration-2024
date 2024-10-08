//
//  Pie.swift
//  Concentration Game 2024
//
//  Created by Stephen Liddle on 10/8/24.
//

import SwiftUI

struct Pie: Shape {
    var startAngle: Angle
    var endAngle: Angle
    let clockwise = true

    var animatableData: AnimatablePair<Double, Double> {
        get {
            AnimatablePair(startAngle.radians, endAngle.radians)
        }
        set {
            startAngle = Angle.radians(newValue.first)
            endAngle = Angle.radians(newValue.second)
        }
    }

    func path(in rect: CGRect) -> Path {
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius: Double = min(rect.height, rect.width) / 2
        let startPoint = CGPoint(
            x: center.x + radius * cos(startAngle.radians),
            y: center.y + radius * sin(startAngle.radians)
        )
        var p = Path()

        p.move(to: center)
        p.addLine(to: startPoint)
        p.addArc(
            center: center,
            radius: radius,
            startAngle: startAngle,
            endAngle: endAngle,
            clockwise: clockwise
        )

        return p
    }
}

#Preview {
    Pie(startAngle: Angle(degrees: 360-90), endAngle: Angle(degrees: 105-90))
        .foregroundStyle(.orange)
        .opacity(0.4)
        .padding()
}
