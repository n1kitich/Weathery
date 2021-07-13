//
//  Request+CoreDataProperties.swift
//  Weathery
//
//  Created by Anon Account on 13.07.2021.
//
//

import Foundation
import CoreData


extension Request {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Request> {
        return NSFetchRequest<Request>(entityName: "Request")
    }

    @NSManaged public var type: String?
    @NSManaged public var query: String?
    @NSManaged public var language: String?
    @NSManaged public var unit: String?
    @NSManaged public var weather: Weather?

}

extension Request : Identifiable {

}
