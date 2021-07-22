//
//  Main+CoreDataProperties.swift
//  Weathery
//
//  Created by Anon Account on 21.07.2021.
//
//

import Foundation
import CoreData


extension Main {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Main> {
        return NSFetchRequest<Main>(entityName: "Main")
    }

    @NSManaged public var feelsLike: Double
    @NSManaged public var humidity: Int16
    @NSManaged public var pressure: Int16
    @NSManaged public var temoMax: Double
    @NSManaged public var temp: Double
    @NSManaged public var tempMin: Double
    @NSManaged public var current: Current?

}

extension Main : Identifiable {

}
