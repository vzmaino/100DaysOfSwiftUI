//
//  Lesson2.swift
//  Accessibility
//
//  Created by Vinicius Maino on 02/04/21.
//

import SwiftUI

struct Lesson2: View {
    var body: some View {
//        Image(decorative: "character")
//            .accessibility(hidden: true)
        
//        VStack {
//            Text("Your score is")
//            Text("1000")
//                .font(.title)
//        }
//        .accessibilityElement(children: .combine)
//    }
        
        VStack {
            Text("Your score is")
            Text("1000")
                .font(.title)
        }
        .accessibilityElement(children: .ignore)
        .accessibility(label: Text("Your score is 1000"))
    }
}

struct Lesson2_Previews: PreviewProvider {
    static var previews: some View {
        Lesson2()
    }
}
