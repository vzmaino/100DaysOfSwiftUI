//
//  DetailView.swift
//  FriendFace
//
//  Created by Vinicius Maino on 27/03/21.
//

import SwiftUI

struct DetailView: View {
    @ObservedObject var users: Users
        
    var user: User
    
    let colors = [Color.red, Color.green, Color.blue, Color.purple, Color.yellow]
    
    var body: some View {
        List {
            Section(header: Text("Info")) {
                Text("Company: \(user.company)")
                Text("Email: \(user.email)")
                Text("Address: \(user.address)")
            }
            
            Section(header: Text("About")) {
                Text(user.about)
            }
            
            Section(header: Text("Registration Date")) {
                Text("\(user.formattedRegistered)")
            }
            
            Section(header: Text("Tags")) {
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(user.tags, id: \.self) { tag in
                            Text(tag)
                                .foregroundColor(Color.white)
                                .padding(.horizontal, 15)
                                .padding(.vertical, 5)
                                .background(
                                    Capsule()
                                        .fill(colors[Int.random(in: 0...4)])
                                )
                                .padding(.vertical, 10)
                        }
                    }
                }
            }
            
            Section(header: Text("Friends")) {
                ForEach(user.friends) { friend in
                    NavigationLink(destination: FriendDetailView(friend: self.users.findUser(byName: friend.name)!)) {
                        UserRowView(user: self.users.findUser(byName: friend.name)!)
                    }
                }
            }
            
        }
        .listStyle(GroupedListStyle())
        .navigationBarTitle(Text("\(user.name), \(user.age) years"), displayMode: .inline)
        .navigationBarItems(trailing:
            Circle()
                .foregroundColor(user.isActive ? Color.green : Color.red)
                .frame(width: 20, height: 20)
        )
    }
}
