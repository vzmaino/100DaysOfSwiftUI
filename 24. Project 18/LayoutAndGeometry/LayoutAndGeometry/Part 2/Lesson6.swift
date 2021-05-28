//
//  Lesson6.swift
//  LayoutAndGeometry
//
//  Created by Vinicius Maino on 07/04/21.
//

import SwiftUI

struct Lesson6: View {
    let colors: [Color] = [.red, .green, .blue, .orange, .pink, .purple, .yellow]

//   var body: some View {
//       GeometryReader { fullView in
//           ScrollView(.vertical) {
//               ForEach(0..<50) { index in
//                   GeometryReader { geo in
//                       Text("Row #\(index)")
//                            .font(.title)
//                            .frame(width: fullView.size.width)
//                            .rotation3DEffect(.degrees(Double(geo.frame(in: .global).minY - fullView.size.height / 2) / 5), axis: (x: 0, y: 1, z: 0))
//                            .background(self.colors[index % 7])
//                   }
//                   .frame(height: 40)
//               }
//           }
//       }
//   }
    
    var body: some View {
    GeometryReader { fullView in
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(0..<50) { index in
                    GeometryReader { geo in
                        Rectangle()
                            .fill(self.colors[index % 7])
                            .frame(height: 150)
                            .rotation3DEffect(.degrees(-Double(geo.frame(in: .global).midX - fullView.size.width / 2) / 10), axis: (x: 0, y: 1, z: 0))
                    }
                    .frame(width: 150)
                }
            }
            .padding(.horizontal, (fullView.size.width - 150) / 2)
        }
    }
    //.edgesIgnoringSafeArea(.all)
    }
}

struct Lesson6_Previews: PreviewProvider {
    static var previews: some View {
        Lesson6()
    }
}
