//
//  APIManager.swift
//  Incite Dash
//
//  Created by Yifan Wang on 12/28/23.
//

import Foundation

func fetchData(completion: @escaping (Result<ApiResponse, Error>) -> Void) {
    
    let apiKey = "cn6os65glkc000fvi3c0"
    let apiSecret = "ca8f2a933f124d5eb83b911b2bc1e085"
    let urlString = "https://api.disruptive-technologies.com/v2/projects/cn39e25vkss3h69meaqg/devices"
    
    guard let url = URL(string: urlString) else {
        completion(.failure(NSError(domain: "Invalid URL", code: -1, userInfo: nil)))
        return
    }

    var request = URLRequest(url: url)
    request.httpMethod = "GET"

    // Set Basic Authentication headers
    let loginString = "\(apiKey):\(apiSecret)"
    guard let loginData = loginString.data(using: .utf8)?.base64EncodedString() else {
        completion(.failure(NSError(domain: "Invalid login data", code: -1, userInfo: nil)))
        return
    }
    let basicAuthString = "Basic \(loginData)"
    request.setValue(basicAuthString, forHTTPHeaderField: "Authorization")

    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        if let error = error {
            completion(.failure(error))
            return
        }

        guard let httpResponse = response as? HTTPURLResponse else {
            completion(.failure(NSError(domain: "Invalid response", code: -1, userInfo: nil)))
            return
        }

        if (200...299).contains(httpResponse.statusCode) {
            if let data = data {
                // Parse JSON data
                do {
                    let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
                    
                    print("Fetched JSON Object: \(jsonObject)")
                    let response = try JSONDecoder().decode(ApiResponse.self, from: data)
                    
                    completion(.success(response))
                } catch {
                    completion(.failure(error))
                }
            } else {
                completion(.failure(NSError(domain: "No data received", code: -1, userInfo: nil)))
            }
        } else {
            completion(.failure(NSError(domain: "HTTP Error: \(httpResponse.statusCode)", code: httpResponse.statusCode, userInfo: nil)))
        }
    }
    task.resume()
}
