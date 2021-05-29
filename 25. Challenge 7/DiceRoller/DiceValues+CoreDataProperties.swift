import Foundation
import CoreData


extension DiceValues {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DiceValues> {
        return NSFetchRequest<DiceValues>(entityName: "DiceValues")
    }

    @NSManaged public var value: Int32
    @NSManaged public var history: DiceHistory?

}

extension DiceValues : Identifiable {

}
