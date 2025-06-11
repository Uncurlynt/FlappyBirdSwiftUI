//
//  Pipe.swift
//  FlappyBird
//
//  Created by Артемий Андреев  on 09.06.2025.
//

import SwiftUI

struct Pipe: Identifiable {
    let id = UUID()
    var x: CGFloat
    var gapY: CGFloat
    var passed = false

    static let width: CGFloat = 52
    static let gapHeight: CGFloat = 150
    static let speed: CGFloat = 2.5

    mutating func update() { x -= Self.speed }

    static func randomGapY() -> CGFloat {
        CGFloat.random(in: -150...150)
    }
}
