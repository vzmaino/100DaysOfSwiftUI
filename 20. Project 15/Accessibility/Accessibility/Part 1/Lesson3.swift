//
//  Lesson3.swift
//  Accessibility
//
//  Created by Vinicius Maino on 02/04/21.
//

import SwiftUI

struct Lesson3: View {
    
//    @State private var estimate = 25.0
//
//    var body: some View {
//        Slider(value: $estimate, in: 0...50)
//            .padding()
//            .accessibility(value: Text("\(Int(estimate))"))
//    }
    
    @State private var rating = 3

    var body: some View {
        Stepper("Rate our service: \(rating)/5", value: $rating, in: 1...5)
            .accessibility(value: Text("\(rating) out of 5"))
    }
}

struct Lesson3_Previews: PreviewProvider {
    static var previews: some View {
        Lesson3()
    }
}
