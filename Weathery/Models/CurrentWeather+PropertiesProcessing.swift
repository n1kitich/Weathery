//
//  CurrentWeather+PropertiesProcessing.swift
//  Weathery
//
//  Created by Anon Account on 27.07.2021.
//

import Foundation

extension MainModel {
    
    var tempString: String {
        return "\(temp.roundToDecimal(0))°"
    }
    
}

extension Double {
    func roundToDecimal(_ fractionDigits: Int) -> Double {
        let multiplier = pow(10, Double(fractionDigits))
        return Darwin.round(self * multiplier) / multiplier
    }
}
