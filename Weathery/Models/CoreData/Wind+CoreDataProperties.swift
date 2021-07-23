//
//  Wind+CoreDataProperties.swift
//  Weathery
//
//  Created by Anon Account on 23.07.2021.
//
//

import Foundation
import CoreData


extension Wind {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Wind> {
        return NSFetchRequest<Wind>(entityName: "Wind")
    }

    @NSManaged public var speed: Double
    @NSManaged public var deg: Int16
    @NSManaged public var current: Current?

}

extension Wind : Identifiable {

}
