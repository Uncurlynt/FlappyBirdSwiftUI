//
//  Bird.swift
//  FlappyBird
//
//  Created by Артемий Андреев  on 09.06.2025.
//

import SwiftUI

struct Bird {
    var y: CGFloat = 0
    var velocity: CGFloat = 0

    static let size = CGSize(width: 34, height: 24)
    static var radius: CGFloat { size.height / 2 }

    static let gravity: CGFloat = 0.6
    static let flapVelocity: CGFloat = -12

    mutating func update() {
        velocity += Self.gravity
        y += velocity
    }

    mutating func flap() {
        velocity = Self.flapVelocity
    }
}
