//
//  ContentView.swift
//  FlappyBird
//
//  Created by Артемий Андреев  on 09.06.2025.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var vm = GameViewModel()
    
    // Угол наклона петуха
    private var birdTilt: Angle {
        let raw = vm.bird.velocity * 3
        let clamped = min(max(raw, -25), 90)
        return .degrees(Double(clamped))
    }

    var body: some View {
        ZStack {
            BackgroundView()

            GeometryReader { geo in
                ZStack {
                    // Трубы рисуем только во время игры или после Game Over
                    if vm.gameState != .menu {
                        ForEach(vm.pipes) { PipeView(pipe: $0) }
                    }

                    // Петух
                    BirdView()
                        .rotationEffect(birdTilt)
                        .animation(.linear(duration: 0.08),
                                   value: vm.bird.velocity)
                        .position(
                            x: geo.size.width  / 2 + vm.birdX,
                            y: geo.size.height / 2 + vm.bird.y
                        )

                    // Спрайт «message» по центру в меню
                    if vm.gameState == .menu {
                        Image("message")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 240)
                            .position(
                                x: geo.size.width  / 2,
                                y: geo.size.height / 2 - 20
                            )
                    }

                    // «Game Over» поверх труб
                    if vm.gameState == .gameOver {
                        Image("gameover")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200)
                            .position(
                                x: geo.size.width  / 2,
                                y: geo.size.height / 2 - 50
                            )
                    }
                }
            }.ignoresSafeArea()

            // Счёт выводим, только когда игра идёт/закончилась
            if vm.gameState != .menu {
                VStack {
                    ScoreView(score: vm.score)
                    Spacer()
                }
                .padding(.top, 20)
            }
            //Земеля
            BaseView()
        }
        .onTapGesture { vm.flap() }
    }
}
