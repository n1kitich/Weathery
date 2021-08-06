//
//  Clouds+CoreDataProperties.swift
//  Weathery
//
//  Created by Anon Account on 23.07.2021.
//
//

import Foundation
import CoreData


extension Clouds {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Clouds> {
        return NSFetchRequest<Clouds>(entityName: "Clouds")
    }

    @NSManaged public var all: Int16
    @NSManaged public var current: Current?

}

extension Clouds : Identifiable {

}
