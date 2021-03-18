//
//  ContentView.swift
//  ViewModifier
//
//  Created by Vinicius Maino.
//

import SwiftUI

struct TitleModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.blue)
    }
}

extension View {
    func title() -> some View {
        self.modifier(TitleModifier())
    }
}

struct ContentView: View {
    var body: some View {
        ZStack {
            Color
                .black
                .ignoresSafeArea()
            
            VStack {
                Text("Title modifier challenge")
                    .title()
                    .padding()
                Text("#100DaysOfSwiftUI")
                    .title()
                    .padding()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
