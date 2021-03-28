//
//  ExplicitAnimation.swift
//  Animations
//
//  Created by Vinicius Maino.
//

import SwiftUI

struct ExplicitAnimation: View {
    @State private var animationAmount = 0.0

    var body: some View {
        Button("Tap Me") {
            withAnimation(.interpolatingSpring(stiffness: 5, damping: 1)) {
                self.animationAmount += 360
            }
        }
        .padding(50)
        .background(Color.red)
        .foregroundColor(.white)
        .clipShape(Circle())
         
    }
}
