//
//  Lesson4.swift
//  LayoutAndGeometry
//
//  Created by Vinicius Maino on 07/04/21.
//

import SwiftUI

struct Lesson4: View {
    var body: some View {
//        Text("Hello, world!")
//            .position(x: 100, y: 100)
//            .background(Color.red)
        Text("Hello, world!")
            .offset(x: 100, y: 100)
            .background(Color.red)
    }
}

struct Lesson4_Previews: PreviewProvider {
    static var previews: some View {
        Lesson4()
    }
}
