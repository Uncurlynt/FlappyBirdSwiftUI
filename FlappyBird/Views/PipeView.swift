//
//  PipeView.swift
//  FlappyBird
//
//  Created by Артемий Андреев  on 09.06.2025.
//

import SwiftUI

struct PipeView: View {
    let pipe: Pipe
    private var screenHeight: CGFloat { UIScreen.main.bounds.height }

    var body: some View {
        // Вычисляем высоты
        let topHeight = screenHeight / 2 + (pipe.gapY - Pipe.gapHeight / 2)
        let bottomHeight = screenHeight / 2 - (pipe.gapY + Pipe.gapHeight / 2)

        ZStack {
            // Верхняя труба (перевёрнутая)
            Image("pipe-green")
                .resizable(capInsets: EdgeInsets(), resizingMode: .stretch)
                .frame(width: Pipe.width, height: topHeight)
                .rotationEffect(.degrees(180))
                .offset(x: pipe.x,
                        y: -(screenHeight / 2) + topHeight / 2)

            // Нижняя труба
            Image("pipe-green")
                .resizable(capInsets: EdgeInsets(), resizingMode: .stretch)
                .frame(width: Pipe.width, height: bottomHeight)
                .offset(x: pipe.x,
                        y: (screenHeight / 2) - bottomHeight / 2)
        }
    }
}
