//
//  Current+CoreDataProperties.swift
//  Weathery
//
//  Created by Anon Account on 23.07.2021.
//
//

import Foundation
import CoreData


extension Current {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Current> {
        return NSFetchRequest<Current>(entityName: "Current")
    }

    @NSManaged public var base: String?
    @NSManaged public var visibility: Int16
    @NSManaged public var dt: Int32
    @NSManaged public var timezone: Int16
    @NSManaged public var id: Int32
    @NSManaged public var name: String?
    @NSManaged public var cod: Int16
    @NSManaged public var coord: Coord?
    @NSManaged public var weather: Weather
    @NSManaged public var main: Main
    @NSManaged public var wind: Wind?
    @NSManaged public var clouds: Clouds?
    @NSManaged public var sys: Sys?

}

extension Current : Identifiable {

}
