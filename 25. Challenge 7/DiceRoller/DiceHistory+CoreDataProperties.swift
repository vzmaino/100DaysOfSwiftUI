import Foundation
import CoreData


extension DiceHistory {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DiceHistory> {
        return NSFetchRequest<DiceHistory>(entityName: "DiceHistory")
    }

    @NSManaged public var date: Date?
    @NSManaged public var id: UUID?
    @NSManaged public var value: NSSet?
    
    public var resultArray: [DiceValues] {
        let set = value as? Set<DiceValues> ?? []
        return set.sorted {
            $0.value < $1.value
        }
    }

}

// MARK: Generated accessors for value
extension DiceHistory {

    @objc(addValueObject:)
    @NSManaged public func addToValue(_ value: DiceValues)

    @objc(removeValueObject:)
    @NSManaged public func removeFromValue(_ value: DiceValues)

    @objc(addValue:)
    @NSManaged public func addToValue(_ values: NSSet)

    @objc(removeValue:)
    @NSManaged public func removeFromValue(_ values: NSSet)

}

extension DiceHistory : Identifiable {

}
