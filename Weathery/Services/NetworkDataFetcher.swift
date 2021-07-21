//
//  NetworkDataFetcher.swift
//  Weathery
//
//  Created by Anon Account on 15.07.2021.
//

import Foundation

class NetworkDataFetcher {
    
    let networkService: NetworkService
    
    init(networkService: NetworkService = NetworkService()) {
        self.networkService = networkService
    }
    
    func fetchData(urlString: String, accessKey: String, query: String, completion: @escaping (WeatherModel?) -> Void) {
        
        networkService.request(urlString: urlString, accessKey: accessKey, query: query) {
            (data, error) in
            let decoder = JSONDecoder()
            guard let data = data else { return }
            let response = try? decoder.decode(WeatherModel.self, from: data)
            completion(response)
        }
    }
}

