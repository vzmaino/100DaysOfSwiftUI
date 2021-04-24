//
//  FriendFaceCoreDataApp.swift
//  FriendFaceCoreData
//
//  Created by Vinicius Maino on 28/03/21.
//

import SwiftUI

@main
struct FriendFaceCoreDataApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
