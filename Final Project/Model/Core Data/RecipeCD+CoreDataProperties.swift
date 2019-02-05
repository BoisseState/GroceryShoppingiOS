//
//  RecipeCD+CoreDataProperties.swift
//  
//
//  Created by Joe Boisse on 12/9/18.
//
//

import Foundation
import CoreData


extension RecipeCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RecipeCD> {
        return NSFetchRequest<RecipeCD>(entityName: "RecipeCD")
    }

    @NSManaged public var imageData: NSData?
    @NSManaged public var ingredients: NSObject?
    @NSManaged public var name: String?
    @NSManaged public var publisher: String?
    @NSManaged public var url: String?
    @NSManaged public var menuItem: NSSet?

}

// MARK: Generated accessors for menuItem
extension RecipeCD {

    @objc(addMenuItemObject:)
    @NSManaged public func addToMenuItem(_ value: ScheduledCD)

    @objc(removeMenuItemObject:)
    @NSManaged public func removeFromMenuItem(_ value: ScheduledCD)

    @objc(addMenuItem:)
    @NSManaged public func addToMenuItem(_ values: NSSet)

    @objc(removeMenuItem:)
    @NSManaged public func removeFromMenuItem(_ values: NSSet)

}
