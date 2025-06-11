//
//  AudioManager.swift
//  FlappyBird
//
//  Created by Артемий Андреев  on 09.06.2025.
//


import AVFoundation

final class AudioManager: NSObject, AVAudioPlayerDelegate {
    static let shared = AudioManager()

    private var players: [AVAudioPlayer] = []

    func play(_ name: String) {
        guard let url = ["wav"]
                .compactMap({ Bundle.main.url(forResource: name, withExtension: $0) })
                .first
        else { return }

        if let player = try? AVAudioPlayer(contentsOf: url) {
            player.delegate = self
            player.prepareToPlay()
            player.play()
            players.append(player)
        }
    }

    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if let idx = players.firstIndex(of: player) {
            players.remove(at: idx)
        }
    }
}
