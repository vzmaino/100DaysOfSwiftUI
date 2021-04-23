//
//  FriendDetailView.swift
//  FriendFace
//
//  Created by Vinicius Maino on 27/03/21.
//

import SwiftUI

struct FriendDetailView: View {
    var friend: User
    let colors = [Color.red, Color.green, Color.blue, Color.purple, Color.yellow]
    
    var body: some View {
        List {
            Section(header: Text("Info")) {
                Text("Company: \(friend.company)")
                Text("Email: \(friend.email)")
                Text("Address: \(friend.address)")
            }
            
            Section(header: Text("About")) {
                Text(friend.about)
            }
            
            Section(header: Text("Registration Date")) {
                Text("\(friend.formattedRegistered)")
            }
            
            Section(header: Text("Tags")) {
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(friend.tags, id: \.self) { tag in
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
        }
        .listStyle(GroupedListStyle())
        .navigationBarTitle(Text("\(friend.name), \(friend.age) years"), displayMode: .inline)
        .navigationBarItems(trailing:
            Circle()
                .foregroundColor(friend.isActive ? Color.green : Color.red)
                .frame(width: 20, height: 20)
        )
    }
}

//struct FriendDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        FriendDetailView()
//    }
//}
