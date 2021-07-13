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

    @NSManaged public var descript: String?
    @NSManaged public var temperature: String?
    @NSManaged public var wind: String?

}

extension Weather : Identifiable {

}
