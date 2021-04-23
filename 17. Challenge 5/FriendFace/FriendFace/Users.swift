//
//  Users.swift
//  FriendFace
//
//  Created by Vinicius Maino on 27/03/21.
//

import Foundation

class Users: ObservableObject {
    @Published var items = [User]()
    
    init() {
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
                    self.items = users
                }
            } catch {
                print("error: \(error)")
            }
        }.resume()
    }
    
    func findUser(byName name: String) -> User? {
        if let user = items.first(where: { $0.name == name }) {
            return user
        }
        
        return items.first
    }
}
