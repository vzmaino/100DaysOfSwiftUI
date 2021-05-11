//
//  ContactFaceApp.swift
//  ContactFace
//
//  Created by Vinicius Maino on 03/04/21.
//

import SwiftUI

@main
struct ContactFaceApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
