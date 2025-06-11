//
//  ScoreView.swift
//  FlappyBird
//
//  Created by Артемий Андреев  on 09.06.2025.
//

import SwiftUI

struct ScoreView: View {
    let score: Int

    private var digits: [Int] {
        if score == 0 { return [0] }
        var n = score
        var d: [Int] = []
        while n > 0 {
            d.append(n % 10)
            n /= 10
        }
        return d.reversed()
    }

    var body: some View {
        HStack(spacing: 2) {
            ForEach(digits, id: \.self) { d in
                Image("\(d)")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 36)
            }
        }
    }
}
