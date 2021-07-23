//
//  Coord+CoreDataProperties.swift
//  Weathery
//
//  Created by Anon Account on 23.07.2021.
//
//

import Foundation
import CoreData


extension Coord {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Coord> {
        return NSFetchRequest<Coord>(entityName: "Coord")
    }

    @NSManaged public var lon: Double
    @NSManaged public var lat: Double
    @NSManaged public var current: Current?

}

extension Coord : Identifiable {

}
