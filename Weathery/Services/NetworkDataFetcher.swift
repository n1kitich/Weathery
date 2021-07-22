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
    
    func fetchData(accessKey: String, place: String, completion: @escaping (DataModel?) -> Void) {
        networkService.request(accessKey: accessKey, place: place) {
            (data, error) in
            let decoder = JSONDecoder()
            guard let data = data else { return }
            let response = try? decoder.decode(DataModel.self, from: data)
            completion(response)
        }
    }
}

