//
//  Lesson5.swift
//  CoreDataProject
//
//  Created by Vinicius Maino on 25/03/21.
//

import SwiftUI
import CoreData

struct Lesson5: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Ship.entity(), sortDescriptors: [], predicate: NSPredicate(format: "universe == 'Star Wars'")) var ships: FetchedResults<Ship>
    
    //Predicates examples
//    NSPredicate(format: "universe == %@", "Star Wars"))
//    NSPredicate(format: "name < %@", "F")) var ships: FetchedResults<Ship>
//    NSPredicate(format: "universe IN %@", ["Aliens", "Firefly", "Star Trek"])
//    NSPredicate(format: "name BEGINSWITH %@", "E"))
//    NSPredicate(format: "NOT name BEGINSWITH[c] %@", "e"))

    var body: some View {
        VStack {
            List(ships, id: \.self) { ship in
                Text(ship.name ?? "Unknown name")
            }

            Button("Add Examples") {
                let ship1 = Ship(context: self.moc)
                ship1.name = "Enterprise"
                ship1.universe = "Star Trek"

                let ship2 = Ship(context: self.moc)
                ship2.name = "Defiant"
                ship2.universe = "Star Trek"

                let ship3 = Ship(context: self.moc)
                ship3.name = "Millennium Falcon"
                ship3.universe = "Star Wars"

                let ship4 = Ship(context: self.moc)
                ship4.name = "Executor"
                ship4.universe = "Star Wars"

                try? self.moc.save()
            }
        }
    }
}

struct Lesson5_Previews: PreviewProvider {
    static var previews: some View {
        Lesson5()
    }
}
