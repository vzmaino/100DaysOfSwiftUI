//
//  CoreDataProjectApp.swift
//  CoreDataProject
//
//  Created by Vinicius Maino on 25/03/21.
//

import SwiftUI

@main
struct CoreDataProjectApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
