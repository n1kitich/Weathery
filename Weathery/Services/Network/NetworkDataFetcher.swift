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
    
    func fetchData(accessKey: String, place: String, completion: @escaping (Result<CurrentWeather, Error>) -> Void) {
        networkService.request(accessKey: accessKey, place: place) {
            (data, error) in
            guard let data = data else { return }
            let decoder = JSONDecoder()
            do {
                let response = try decoder.decode(CurrentWeather.self, from: data)
                completion(.success(response))
            } catch {
                completion(.failure(error))
            }
            
            
        }
    }
}

