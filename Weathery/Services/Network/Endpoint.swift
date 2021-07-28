//
//  Endpoint.swift
//  Weathery
//
//  Created by Anon Account on 23.07.2021.
//

import Foundation

struct Endpoint<T> {
    let accessKey: String
    let query: T

    var url: URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.openweathermap.org"
        urlComponents.path = "/data/2.5/weather"
        
        if let simpleQuery = query as? String {
            urlComponents.queryItems = [
                URLQueryItem(name: "q", value: simpleQuery),
                URLQueryItem(name: "units", value: "metric"),
                URLQueryItem(name: "appid", value: accessKey)
            ]
            return urlComponents.url
        }
        if let coordinates = query as? (String, String) {
            urlComponents.queryItems = [
                URLQueryItem(name: "lat", value: coordinates.0),
                URLQueryItem(name: "lon", value: coordinates.1),
                URLQueryItem(name: "units", value: "metric"),
                URLQueryItem(name: "appid", value: accessKey)
            ]
        }
        return urlComponents.url
    }
}

