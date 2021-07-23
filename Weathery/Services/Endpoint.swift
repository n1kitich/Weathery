//
//  Endpoint.swift
//  Weathery
//
//  Created by Anon Account on 23.07.2021.
//

import Foundation


struct Endpoint {
    let query: String
    let accessKey: String
    
    var url: URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.openweathermap.org"
        urlComponents.path = "/data/2.5/weather"
        urlComponents.queryItems = [
            URLQueryItem(name: "q", value: query),
            URLQueryItem(name: "units", value: "metric"),
            URLQueryItem(name: "appid", value: accessKey)
        ]
        return urlComponents.url
    }
}
