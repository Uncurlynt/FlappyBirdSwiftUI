//
//  GameViewModel.swift
//  FlappyBird
//
//  Created by Артемий Андреев  on 09.06.2025.
//

import SwiftUI

final class GameViewModel: ObservableObject {
    // MARK: - Состояние игры
    enum GameState { case menu, playing, gameOver }

    @Published private(set) var gameState: GameState = .menu

    // MARK: - Игровые данные
    @Published var bird = Bird()
    @Published var pipes: [Pipe] = []
    @Published var score = 0
    @Published var isGameOver = false

    // Фиксированная X-координата петуха
    let birdX: CGFloat = -100

    // Геометрия
    private let screenW = UIScreen.main.bounds.width
    private let screenH = UIScreen.main.bounds.height
    private let groundH = BaseView.height

    // Таймер игрового цикла
    private var timer: Timer?

    // MARK: - Инициализация
    init() { startMenu() }

    // MARK: - Публичные события (от ContentView)
    func flap() {
        switch gameState {
        case .menu:
            // первый тап – старт игры
            startGame()
        case .playing:
            bird.flap()
            AudioManager.shared.play("wing")
        case .gameOver:
            startMenu()
        }
    }

    // MARK: - Меню
    private func startMenu() {
        timer?.invalidate()
        gameState  = .menu
        isGameOver = false
        score      = 0
        pipes      = []
        bird       = Bird()
        timer = Timer.scheduledTimer(withTimeInterval: 1/60, repeats: true) { t in
            let time = CGFloat(t.fireDate.timeIntervalSince1970)
            self.bird.y = sin(time * 2) * 10
        }
    }

    // MARK: - Игра
    private func startGame() {
        timer?.invalidate()
        gameState  = .playing
        isGameOver = false
        score      = 0

        // Петух делает свой первый вжих
        bird = Bird()
        bird.flap()
        AudioManager.shared.play("wing")

        pipes.removeAll()

        let spacing: CGFloat = 200
        let firstPipeOffset: CGFloat = screenW * 0.1

        for i in 0..<3 {
            let x = screenW / 2 + firstPipeOffset + CGFloat(i) * (Pipe.width + spacing)
            pipes.append(Pipe(x: x, gapY: Pipe.randomGapY()))
        }

        //50 фепесов
        timer = Timer.scheduledTimer(withTimeInterval: 0.02, repeats: true) { _ in
            self.updatePlaying()
        }
    }


    private func updatePlaying() {
        guard gameState == .playing else { return }

        bird.update()

        for i in pipes.indices { pipes[i].update() }
        if let first = pipes.first, first.x < -screenW / 2 - Pipe.width {
            pipes.removeFirst()
            let newX = (pipes.last?.x ?? 0) + Pipe.width + 200
            pipes.append(Pipe(x: newX, gapY: Pipe.randomGapY()))
        }
        checkCollisionsAndScore()
    }

    // MARK: - Коллизии и счёт
    private func checkCollisionsAndScore() {
        let maxY = screenH / 2 - groundH
        let minY: CGFloat = -screenH / 2

        // Пол / потолок
        if bird.y + Bird.radius > maxY || bird.y - Bird.radius < minY {
            triggerGameOver()
        }

        // Трубы
        for i in pipes.indices {
            let p = pipes[i]
            let left  = p.x - Pipe.width  / 2
            let right = p.x + Pipe.width  / 2
            let gapT  = p.gapY - Pipe.gapHeight / 2
            let gapB  = p.gapY + Pipe.gapHeight / 2

            if !p.passed && p.x + Pipe.width / 2 < birdX {
                score += 1
                pipes[i].passed = true
                AudioManager.shared.play("point")
            }

            if birdX + Bird.radius > left && birdX - Bird.radius < right {
                if bird.y - Bird.radius < gapT || bird.y + Bird.radius > gapB {
                    triggerGameOver()
                }
            }
        }
    }

    private func triggerGameOver() {
        guard gameState == .playing else { return }
        gameState  = .gameOver
        isGameOver = true
        timer?.invalidate()
        AudioManager.shared.play("hit")
        AudioManager.shared.play("die")
    }
}
