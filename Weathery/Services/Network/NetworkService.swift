//
//  NetworkService.swift
//  Weathery
//
//  Created by Anon Account on 27.06.2021.
//

import Foundation

class NetworkService {
    
    func request(urlString: String, accessKey: String, query: String, completion: @escaping (Data?, Error?) -> Void) {
        let urlStr = urlString + "?access_key=" + accessKey + "&query=" + query
        guard let url = URL(string: urlStr ) else { return }
        let request = URLRequest(url: url)

        let urlSession = createDataTask(with: request, completion: completion)
        urlSession.resume()
    }
    
    private func createDataTask(with request: URLRequest, completion: @escaping (Data?, Error?) -> Void) -> URLSessionDataTask {
        return URLSession.shared.dataTask(with: request, completionHandler: {
            (data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    completion(data, error)
                }
                if let data = data {
                    completion(data, error)
                }
            }
        })
    }
    
}


