//
//  Current+CoreDataProperties.swift
//  Weathery
//
//  Created by Anon Account on 09.07.2021.
//
//

import Foundation
import CoreData


extension Current {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Current> {
        return NSFetchRequest<Current>(entityName: "Current")
    }

    @NSManaged public var cloudcover: Int16
    @NSManaged public var feelslike: Int16
    @NSManaged public var humidity: Int16
    @NSManaged public var isDay: String?
    @NSManaged public var observationTime: String?
    @NSManaged public var precip: Int16
    @NSManaged public var pressure: Int16
    @NSManaged public var temperature: Int16
    @NSManaged public var uvIndex: Int16
    @NSManaged public var visibility: Int16
    @NSManaged public var weatherCode: Int16
    @NSManaged public var weatherDescriptions: NSObject?
    @NSManaged public var weatherIcons: NSObject?
    @NSManaged public var windDegree: Int16
    @NSManaged public var windDir: String?
    @NSManaged public var windSpeed: Int16
    @NSManaged public var weather: Weather?

}

extension Current : Identifiable {

}
