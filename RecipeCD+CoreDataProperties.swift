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
    @NSManaged public var scheduledDates: NSObject?
    @NSManaged public var historyDates: NSObject?

}
