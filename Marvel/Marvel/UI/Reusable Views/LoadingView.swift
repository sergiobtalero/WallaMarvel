//
//  LoadingView.swift
//  Marvel
//
//  Created by Sergio David Bravo Talero on 1/4/25.
//

import SwiftUI

struct LoadingView: View {
    @State private var isAnimating = false
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.gray.opacity(0.2), lineWidth: 4)
                .frame(width: 40, height: 40)
            
            Circle()
                .trim(from: 0, to: 0.25)
                .stroke(Color.accent.opacity(0.8), style: StrokeStyle(lineWidth: 4, lineCap: .round))
                .frame(width: 40, height: 40)
                .rotationEffect(Angle(degrees: isAnimating ? 360 : 0))
                .animation(
                    Animation
                        .easeInOut(duration: 1)
                        .repeatForever(autoreverses: false),
                    value: isAnimating
                )
        }
        .frame(width: 50, height: 50)
        .onAppear {
            isAnimating = true
        }
    }
}
