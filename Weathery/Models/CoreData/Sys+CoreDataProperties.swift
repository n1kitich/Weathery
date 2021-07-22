//
//  Sys+CoreDataProperties.swift
//  Weathery
//
//  Created by Anon Account on 21.07.2021.
//
//

import Foundation
import CoreData


extension Sys {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Sys> {
        return NSFetchRequest<Sys>(entityName: "Sys")
    }

    @NSManaged public var country: String?
    @NSManaged public var id: Int32
    @NSManaged public var sunrise: Int32
    @NSManaged public var sunset: Int32
    @NSManaged public var type: Int16
    @NSManaged public var current: Current?

}

extension Sys : Identifiable {

}
