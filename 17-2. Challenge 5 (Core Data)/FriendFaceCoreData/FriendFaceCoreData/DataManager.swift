//
//  DataManager.swift
//  FriendFaceCoreData
//
//  Created by Vinicius Maino on 28/03/21.
//

import Foundation
import CoreData

struct DataManager {
    
    func fetchData (moc: NSManagedObjectContext) {
        let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print("No data found: \(error?.localizedDescription ?? "Unknowned error")")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                
                //solves error: Expected to decode Double but found a string/data instead
                decoder.dateDecodingStrategy = .iso8601
                
                let users = try decoder.decode([User].self, from: data)
                DispatchQueue.main.async {
                    print(users.count)
                    var tmpUsers = [CDUser]()
                    for user in users {
                        let newUser = CDUser(context: moc)
                        newUser.id = user.id
                        newUser.isActive = user.isActive
                        newUser.name = user.name
                        newUser.age = Int16(user.age)
                        newUser.email = user.email
                        newUser.address = user.address
                        newUser.company = user.company
                        newUser.about = user.about
                        newUser.registered = user.formattedRegistered
                        
                        tmpUsers.append(newUser)
                        
                    }
                    for i in 0..<users.count {
                        for friend in users[i].friends {
                            if let newFriend = tmpUsers.first(where: { $0.id == friend.id }) {
                                tmpUsers[i].addToFriend(newFriend)
                            }
                        }
                    }
                    do {
                        try moc.save()
                        print("saved moc")
                    }
                    catch let error {
                        print("Could not save data: \(error.localizedDescription)")
                    }
                }
            } catch {
                print("error: \(error)")
            }
        }.resume()
    }
}
