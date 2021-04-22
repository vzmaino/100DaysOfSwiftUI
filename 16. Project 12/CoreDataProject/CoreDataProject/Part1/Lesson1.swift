//
//  Lesson1.swift
//  CoreDataProject
//
//  Created by Vinicius Maino on 25/03/21.
//

import SwiftUI

struct Student: Hashable {
    let name: String
}

struct Lesson1: View {
    
    let students = [Student(name: "Harry Potter"), Student(name: "Hermione Granger")]
    
    var body: some View {
//        List {
//            ForEach([2, 4, 6, 8, 10], id: \.self) {
//                Text("\($0) is even")
//            }
//        }
        
        List(students, id: \.self) { student in
            Text(student.name)
        }
    
    }
}

struct Lesson1_Previews: PreviewProvider {
    static var previews: some View {
        Lesson1()
    }
}
