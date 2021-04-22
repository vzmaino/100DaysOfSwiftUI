//
//  Lesson3.swift
//  CoreDataProject
//
//  Created by Vinicius Maino on 25/03/21.
//

import SwiftUI

struct Lesson3: View {
    @Environment(\.managedObjectContext) var moc
    
    var body: some View {
        Button("Save") {
            if self.moc.hasChanges {
                try? self.moc.save()
            }
        }
    }
}

struct Lesson3_Previews: PreviewProvider {
    static var previews: some View {
        Lesson3()
    }
}
