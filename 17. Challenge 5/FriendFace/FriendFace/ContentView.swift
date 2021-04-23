//
//  ContentView.swift
//  FriendFace
//
//  Created by Vinicius Maino on 27/03/21.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var users = Users()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(users.items) { user in
                    NavigationLink(destination: DetailView(users: self.users, user: user)) {
                        UserRowView(user: user)
                    }
                }
            }
            .navigationBarTitle(Text("FriendFace"))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
