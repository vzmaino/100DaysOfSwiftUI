//
//  Mission.swift
//  Moonshoot
//
//  Created by Vinicius Maino.
//

import Foundation

struct Mission: Codable, Identifiable {
    struct CrewRole: Codable {
        let name: String
        let role: String
    }

    let id: Int
    let launchDate: Date?
    let crew: [CrewRole]
    let description: String
    
    var displayName: String {
        "Apollo \(id)"
    }
    
    var image: String {
        "apollo\(id)"
    }
    
    var formattedeLauchDate: String {
        if let launchDate = launchDate {
            let formatter = DateFormatter()
            formatter.dateStyle = .long
            return formatter.string(from: launchDate)
        } else {
            return "N/A"
        }
    }
    
    var listCrew: String {
        var list = [String]()
        
        for member in crew {
            list.append(member.name.capitalized)
        }
        
        return list.joined(separator: ", ")
    }
}
