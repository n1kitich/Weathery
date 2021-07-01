//
//  Weather+CoreDataProperties.swift
//  Weathery
//
//  Created by Anon Account on 01.07.2021.
//
//

import Foundation
import CoreData


extension Weather {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Weather> {
        return NSFetchRequest<Weather>(entityName: "Weather")
    }

    @NSManaged public var temperature: String?
    @NSManaged public var wind: String?
    @NSManaged public var descript: String?
    @NSManaged public var forecast: NSOrderedSet?

}

// MARK: Generated accessors for forecast
extension Weather {

    @objc(insertObject:inForecastAtIndex:)
    @NSManaged public func insertIntoForecast(_ value: Forecast, at idx: Int)

    @objc(removeObjectFromForecastAtIndex:)
    @NSManaged public func removeFromForecast(at idx: Int)

    @objc(insertForecast:atIndexes:)
    @NSManaged public func insertIntoForecast(_ values: [Forecast], at indexes: NSIndexSet)

    @objc(removeForecastAtIndexes:)
    @NSManaged public func removeFromForecast(at indexes: NSIndexSet)

    @objc(replaceObjectInForecastAtIndex:withObject:)
    @NSManaged public func replaceForecast(at idx: Int, with value: Forecast)

    @objc(replaceForecastAtIndexes:withForecast:)
    @NSManaged public func replaceForecast(at indexes: NSIndexSet, with values: [Forecast])

    @objc(addForecastObject:)
    @NSManaged public func addToForecast(_ value: Forecast)

    @objc(removeForecastObject:)
    @NSManaged public func removeFromForecast(_ value: Forecast)

    @objc(addForecast:)
    @NSManaged public func addToForecast(_ values: NSOrderedSet)

    @objc(removeForecast:)
    @NSManaged public func removeFromForecast(_ values: NSOrderedSet)

}

extension Weather : Identifiable {

}
