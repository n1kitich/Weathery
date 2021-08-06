//
//  DataFormatter.swift
//  Weathery
//
//  Created by Anon Account on 22.07.2021.
//

import Foundation

extension Int {
    func getDateStringFromUnix() -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(self))
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateFormat = "MMM d, h:mm a"

        return dateFormatter.string(from: date)
    }
}

extension Double {
    mutating func roundedToInt() -> Int {
        let roundedDouble = self.rounded()
        let integer = Int(roundedDouble)
        return integer
    }
}
