//
//  BackgroundView.swift
//  FlappyBird
//
//  Created by Артемий Андреев  on 09.06.2025.
//

import SwiftUI

struct BackgroundView: View {
    @Environment(\.colorScheme) private var cs
    
    var body: some View {
        Image(cs == .dark ? "background-night" : "background-day")
            .resizable()
            .scaledToFill()
            .ignoresSafeArea()
    }
}
