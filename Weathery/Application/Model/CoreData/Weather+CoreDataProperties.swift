//
//  Weather+CoreDataProperties.swift
//  Weathery
//
//  Created by Anon Account on 23.07.2021.
//
//

import Foundation
import CoreData


extension Weather {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Weather> {
        return NSFetchRequest<Weather>(entityName: "Weather")
    }

    @NSManaged public var id: Int16
    @NSManaged public var main: String?
    @NSManaged public var weatherDescription: String?
    @NSManaged public var icon: String?
    @NSManaged public var current: Current?

}

extension Weather : Identifiable {

}
