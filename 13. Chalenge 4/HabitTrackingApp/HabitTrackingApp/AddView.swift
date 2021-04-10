//
//  SwiftUIView.swift
//  HabitTrackingApp
//
//  Created by Vinicius Maino on 23/03/21.
//

import SwiftUI

struct AddView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var activities: Activities
    @State private var title = ""
    @State private var description = ""
    
    var body: some View {
        
        NavigationView {
            
            Form {
                
                TextField("Activity title", text: $title)
                
                TextField("Description", text: $description)
            }
            .navigationBarTitle("Add new activity")
            .navigationBarItems(trailing: Button("Save") {
                let item = ActivityItem(title: self.title, description: self.description)
                self.activities.items.append(item)
                self.presentationMode.wrappedValue.dismiss()
            })
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(activities: Activities())
    }
}
