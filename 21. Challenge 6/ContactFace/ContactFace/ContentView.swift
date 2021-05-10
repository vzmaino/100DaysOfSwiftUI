//
//  ContentView.swift
//  ContactFace
//
//  Created by Vinicius Maino on 03/04/21.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Person.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Person.name, ascending: true)]) var persons: FetchedResults<Person>
    
    @State private var showAddContact = false
    
    var body: some View {
        return NavigationView {
            
            List {
                ForEach(persons, id: \.self) { person in
                    NavigationLink(destination: DetailView(person: person)) {
                        HStack {
                            Group {
                                if person.imageId != nil {
                                    self.loadUserImage(uuid: person.imageId!)
                                    .resizable()
                                    .scaledToFill()
                                    .clipShape(Circle())
                                } else {
                                    Image(systemName: "person.crop.circle.fill")
                                }
                            }
                            .frame(width: 32, height: 32, alignment: .center)
                            .scaledToFill()
                                    
                            Text("\(person.name ?? "Unknowned name")")
                        }
                    }
                }
            }
            .navigationBarTitle(Text("ContactFace"))
            .navigationBarItems(trailing: Button(action: {
                self.showAddContact.toggle()
            }) {
                Image(systemName: "plus")
            })
            .sheet(isPresented: $showAddContact) {
                AddContactView()
            }
        }
    }
    
    func loadUserImage(uuid: UUID) -> Image {
        if let uiImage = FileManager().loadPhoto(withName: uuid.uuidString){
            return Image(uiImage: uiImage)
        } else {
            return Image(systemName: "person.crop.circle.fill")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
