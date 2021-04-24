//
//  ContentView.swift
//  FriendFaceCoreData
//
//  Created by Vinicius Maino on 28/03/21.
//

import SwiftUI
import CoreData

struct ContentView: View {
    let dataManager = DataManager()
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: CDUser.entity(), sortDescriptors: [NSSortDescriptor(key: "name", ascending: true)]) var cdusers: FetchedResults<CDUser>
    
    var body: some View {
        NavigationView {
            List {
                ForEach(cdusers) { user in
                    NavigationLink(destination: DetailView(user: user)) {
                        UserRowView(user: user)
                    }
                }
            }
            .navigationBarTitle(Text("FriendFace"))
        }
        .onAppear(perform: loadData)
    }
    
    func loadData() {
        if cdusers.isEmpty {
            dataManager.fetchData(moc: moc)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
