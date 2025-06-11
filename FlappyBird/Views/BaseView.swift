//
//  BaseView.swift
//  FlappyBird
//
//  Created by Артемий Андреев  on 09.06.2025.
//

import SwiftUI

struct BaseView: View {
    static let height: CGFloat = 112

    var body: some View {
        GeometryReader { geo in
            Image("base")
                .resizable()
                .scaledToFill()
                .frame(width: geo.size.width,
                       height: Self.height)
                .position(x: geo.size.width / 2,
                          y: geo.size.height - Self.height / 2)
        }
        .ignoresSafeArea()
    }
}
