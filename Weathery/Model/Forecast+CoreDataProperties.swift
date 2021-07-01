//
//  Forecast+CoreDataProperties.swift
//  Weathery
//
//  Created by Anon Account on 01.07.2021.
//
//

import Foundation
import CoreData


extension Forecast {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Forecast> {
        return NSFetchRequest<Forecast>(entityName: "Forecast")
    }

    @NSManaged public var day: String?
    @NSManaged public var tempereture: String?
    @NSManaged public var wind: String?
    @NSManaged public var weather: Weather?

}

extension Forecast : Identifiable {

}
