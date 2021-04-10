//
//  ContentView.swift
//  HabitTrackingApp
//
//  Created by Vinicius Maino on 23/03/21.
//

import SwiftUI

struct ActivityItem: Codable, Identifiable {
    let id = UUID()
    let title: String
    let description: String
    var count = 0
}

class Activities: ObservableObject {
    @Published var items = [ActivityItem]() {
        didSet {
            
            let encoder = JSONEncoder()
            
            if let encoded = try? encoder.encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    init() {
        if let items = UserDefaults.standard.data(forKey: "Items") {
            let decoder = JSONDecoder()
            
            if let decoded = try? decoder.decode([ActivityItem].self, from: items) {
                self.items = decoded
                return
            }
        }
        
        self.items = []
    }
}

struct ContentView: View {
    
    @ObservedObject var activities = Activities()
    @State private var showingAddActivity = false
    
    var body: some View {
        
        NavigationView {
            List {
                ForEach(activities.items) { item in
                    NavigationLink(destination: DetailView(activities: self.activities, activity: item)) {
                        Text(item.title)
                            .font(.headline)
                        Spacer()
                        Text("\(item.count)")
                    }
                }
                .onDelete(perform: removeItems)
            }
            .navigationBarTitle("HabitTracking")
            .navigationBarItems(trailing:
                Button(action: {
                    self.showingAddActivity = true
                }) {
                    Image(systemName: "plus")
                }
            )
        }
        .sheet(isPresented: $showingAddActivity) {
            AddView(activities: self.activities)
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        activities.items.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
