//
//  CurrentWeather+PropertiesProcessing.swift
//  Weathery
//
//  Created by Anon Account on 27.07.2021.
//

import Foundation

extension MainModel {
    var tempString: String {
        var temperature = temp
        return "\(temperature.roundedToInt())"
    }
    
    var feelsLikeString: String {
        var feel = feelsLike
        return "\(feel.roundedToInt())°"
    }
}

extension MainModel {
    var pressureString: String {
        return "\(pressure)"
    }
    
    var humidityString: String {
        return "\(humidity)"
    }
}

extension WindModel {
    var speedString: String {
        return "\(speed) m/s"
    }
}


