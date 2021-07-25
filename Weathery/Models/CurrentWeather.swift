//
//  WeatherModel.swift
//  Weathery
//
//  Created by Anon Account on 27.06.2021.
//

import Foundation

// MARK: - WeatherModel
struct CurrentWeather: Codable {
    let coord: CoordModel
    let weather: [WeatherModel]
    let base: String
    let main: MainModel
    let visibility: Int
    let wind: WindModel
    let clouds: CloudsModel
    let dt: Int
    let sys: SysModel
    let timezone, id: Int
    let name: String
    let cod: Int
}

// MARK: - Clouds
struct CloudsModel: Codable {
    let all: Int
}

// MARK: - Coord
struct CoordModel: Codable {
    let lon, lat: Double
}

// MARK: - Main
struct MainModel: Codable {
    let temp, feelsLike, tempMin, tempMax: Double
    let pressure, humidity: Int

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure, humidity
    }
}

// MARK: - Sys
struct SysModel: Codable {
    let type, id: Int
    let country: String
    let sunrise, sunset: Int
}

// MARK: - Weather
struct WeatherModel: Codable {
    let id: Int
    let main, weatherDescription, icon: String

    enum CodingKeys: String, CodingKey {
        case id, main
        case weatherDescription = "description"
        case icon
    }
}

// MARK: - Wind
struct WindModel: Codable {
    let speed: Double
    let deg: Int
}
