//
//  WeatherModel.swift
//  Weathery
//
//  Created by Anon Account on 27.06.2021.
//

import Foundation

struct WeatherModel: Decodable {
    
    let temperature: String
    let wind: String
    let description: String
    
    let forecast: Forecast
}

struct Forecast: Decodable {
    let day: String
    let temperature: String
    let wind: String
}
