//
//  CDUser+CoreDataProperties.swift
//  FriendFaceCoreData
//
//  Created by Vinicius Maino on 28/03/21.
//
//

import Foundation
import CoreData


extension CDUser {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDUser> {
        return NSFetchRequest<CDUser>(entityName: "CDUser")
    }

    @NSManaged public var id: String?
    @NSManaged public var isActive: Bool
    @NSManaged public var name: String?
    @NSManaged public var age: Int16
    @NSManaged public var company: String?
    @NSManaged public var email: String?
    @NSManaged public var address: String?
    @NSManaged public var about: String?
    @NSManaged public var registered: String?
    @NSManaged public var friend: NSSet?

    public var friendsArray: [CDUser] {
        let set = friend as? Set<CDUser> ?? []

        return set.sorted { $0.name! < $1.name! }
    }
}

// MARK: Generated accessors for friend
extension CDUser {

    @objc(addFriendObject:)
    @NSManaged public func addToFriend(_ value: CDUser)

    @objc(removeFriendObject:)
    @NSManaged public func removeFromFriend(_ value: CDUser)

    @objc(addFriend:)
    @NSManaged public func addToFriend(_ values: NSSet)

    @objc(removeFriend:)
    @NSManaged public func removeFromFriend(_ values: NSSet)

}

extension CDUser : Identifiable {

}
