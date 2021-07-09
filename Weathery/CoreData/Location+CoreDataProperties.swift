//
//  Location+CoreDataProperties.swift
//  Weathery
//
//  Created by Anon Account on 09.07.2021.
//
//

import Foundation
import CoreData


extension Location {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Location> {
        return NSFetchRequest<Location>(entityName: "Location")
    }

    @NSManaged public var name: String?
    @NSManaged public var country: String?
    @NSManaged public var region: String?
    @NSManaged public var lat: String?
    @NSManaged public var lon: String?
    @NSManaged public var timezoneID: String?
    @NSManaged public var localtime: String?
    @NSManaged public var localtimeEpoch: Int16
    @NSManaged public var utcOffset: String?
    @NSManaged public var weather: Weather?

}

extension Location : Identifiable {

}
