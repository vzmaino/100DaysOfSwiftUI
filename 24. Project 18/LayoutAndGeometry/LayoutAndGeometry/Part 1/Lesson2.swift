//
//  Lesson2.swift
//  LayoutAndGeometry
//
//  Created by Vinicius Maino on 07/04/21.
//

import SwiftUI

struct Lesson2: View {
    var body: some View {
//        HStack(alignment: .lastTextBaseline) {
//            Text("Live")
//                .font(.caption)
//            Text("long")
//            Text("and")
//                .font(.title)
//            Text("prosper")
//                .font(.largeTitle)
//        }
        
        VStack(alignment: .leading) {
            ForEach(0..<10) { position in
                Text("Number \(position)")
                    .alignmentGuide(.leading) { _ in CGFloat(position) * -10 }
            }
        }
        .background(Color.red)
        .frame(width: 400, height: 400)
        .background(Color.blue)
    }
}

struct Lesson2_Previews: PreviewProvider {
    static var previews: some View {
        Lesson2()
    }
}
