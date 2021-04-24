//
//  UserRowView.swift
//  FriendFace
//
//  Created by Vinicius Maino on 27/03/21.
//

import SwiftUI

struct UserRowView: View {
    var user: CDUser
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Circle()
                    .foregroundColor(user.isActive ? Color.green : Color.red)
                    .frame(width: 10, height: 10)
                Text("\(user.name!), \(user.age) years")
                    .font(.headline)
                    .foregroundColor(.primary)
            }
            Text(user.email!)
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
    }
}

//struct UserRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        UserRowView()
//    }
//}
