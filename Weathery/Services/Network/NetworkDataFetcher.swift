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
    
    func fetchData<T>(accessKey: String, query: T, completion: @escaping (Result<CurrentWeather, Error>) -> Void) {
        networkService.request(accessKey: accessKey, query: query) { (data, error) in
            if let fetchError = error {
                completion(.failure(fetchError))
            }
            if let data = data {
                let decoded = self.decodeJSON(data: data)
                completion(.success(decoded))
            }
        }
    }

    func decodeJSON(data: Data) -> CurrentWeather {
        let decoder = JSONDecoder()
        do {
            let objects = try decoder.decode(CurrentWeather.self, from: data)
            return objects
        } catch let jsonError {
            fatalError("Can`t decode data: \(jsonError.localizedDescription)")
        }
    }
}

