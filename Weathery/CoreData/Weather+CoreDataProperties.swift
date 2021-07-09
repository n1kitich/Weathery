//
//  Weather+CoreDataProperties.swift
//  Weathery
//
//  Created by Anon Account on 09.07.2021.
//
//

import Foundation
import CoreData


extension Weather {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Weather> {
        return NSFetchRequest<Weather>(entityName: "Weather")
    }

    @NSManaged public var current: Current?
    @NSManaged public var location: Location?
    @NSManaged public var request: Request?

}

extension Weather : Identifiable {

}
