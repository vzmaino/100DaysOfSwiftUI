//
//  DetailView.swift
//  HabitTrackingApp
//
//  Created by Vinicius Maino on 23/03/21.
//

import SwiftUI

struct DetailView: View {
    
    @ObservedObject var activities: Activities
    var activity: ActivityItem
    
    @State private var count: Int = 0
    
    var body: some View {
        Form {
            Text(self.activity.title)
            
            Text(self.activity.description)
            
            Stepper("Completed times: \(count)", value: $count)
        }
        .onAppear {
            self.count = self.activity.count
        }
        .onDisappear {
            if let index = self.activities.items.firstIndex(where: { $0.id == self.activity.id }) {
                self.activities.items.remove(at: index)
                var tempActivity = self.activity
                tempActivity.count = self.count
                self.activities.items.insert(tempActivity, at: index)
            }
        }
    }
}

//struct DetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailView(activity: ActivityItem())
//    }
//}
