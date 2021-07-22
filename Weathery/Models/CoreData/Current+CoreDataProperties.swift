//
//  Current+CoreDataProperties.swift
//  Weathery
//
//  Created by Anon Account on 21.07.2021.
//
//

import Foundation
import CoreData


extension Current {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Current> {
        return NSFetchRequest<Current>(entityName: "Current")
    }

    @NSManaged public var base: String?
    @NSManaged public var cod: Int16
    @NSManaged public var dt: Int32
    @NSManaged public var id: Int32
    @NSManaged public var name: String
    @NSManaged public var timezone: Int32
    @NSManaged public var visibility: String?
    @NSManaged public var clouds: Clouds?
    @NSManaged public var coord: Coord?
    @NSManaged public var main: Main
    @NSManaged public var sys: Sys?
    @NSManaged public var weather: Weather
    @NSManaged public var wind: Wind

}

extension Current : Identifiable {

}
