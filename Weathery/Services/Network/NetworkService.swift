//
//  NetworkService.swift
//  Weathery
//
//  Created by Anon Account on 27.06.2021.
//

import Foundation

class NetworkService {
    
    func fetchRequest(urlString: String, accessKey: String, query: String, completion: @escaping (Result<WeatherModel, Error>) -> Void) {
            
        let urlStr = urlString + "?access_key=" + accessKey + "&query=" + query

        guard let url = URL(string: urlStr ) else { return }

        URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    print("Error:", error.localizedDescription)
                    completion(.failure(error))
                }
                if let data = data {
                    do {
                        let forecast = try JSONDecoder().decode(WeatherModel.self, from: data)
                        completion(.success(forecast))
                    } catch let jsonError{
                        completion(.failure(jsonError))
                    }
                }
            }
        }.resume()
    }
}


