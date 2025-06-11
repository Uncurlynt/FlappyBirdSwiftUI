//
//  BirdView.swift
//  FlappyBird
//
//  Created by Артемий Андреев  on 09.06.2025.
//

import SwiftUI

struct BirdView: View {
    @Environment(\.colorScheme) private var cs
    
    private var frames: [String] {
        cs == .dark
        ? ["redbird-downflap",  "redbird-midflap",  "redbird-upflap"]
        : ["yellowbird-downflap","yellowbird-midflap","yellowbird-upflap"]
    }
    
    @State private var idx = 0
    
    var body: some View {
        Group {
            if let ui = UIImage(named: frames[idx]) {
                Image(uiImage: ui).resizable()
            } else {
                Circle().fill(cs == .dark ? Color.red : Color.yellow)
            }
        }
        .frame(width: Bird.size.width, height: Bird.size.height)
        .onAppear {
            Timer.scheduledTimer(withTimeInterval: 0.12, repeats: true) { _ in
                idx = (idx + 1) % frames.count
            }
        }
    }
}
