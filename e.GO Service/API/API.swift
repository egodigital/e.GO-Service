//
//  API.swift
//  e.GO Service
//
//  Created by Jonas Schlabertz on 23.05.19.
//  Copyright © 2019 Jonas Schlabertz. All rights reserved.
//

import Foundation
import PromiseKit

typealias APIKey = String

enum APIError: Error {
    case emptyResponse
    case invalidResponse
    case requestError
}

extension APIError: LocalizedError {
    
    var errorDescription: String? {
        switch self {
        case .emptyResponse:
            return "Received an empty response."
        case .invalidResponse:
            return "Received an invalid response."
        case .requestError:
            return "Error while fetching data."
        }
    }
    
    var recoverySuggestion: String? {
        return "Please try again in a few seconds."
    }
    
}

class API {
    
    let key: APIKey
    
    init(key: APIKey) {
        self.key = key
    }
    
    func vehicleSignalList() -> Promise<VehicleSignalList> {
        return Promise<VehicleSignalList> { seal in
            let url = URL(string: "https://ego-vehicle-api.azurewebsites.net/api/v1/vehicle/signals?cache=0")
            
            var request = URLRequest(url: url!)
            request.httpMethod = "GET"
            
            request.addValue(self.key, forHTTPHeaderField: "X-Api-Key")
            
            let task: URLSessionDataTask
            
            let defaultSession = URLSession(configuration: .ephemeral)
            
            task = defaultSession.dataTask(with: request) { data, response, error in
                if let error = error {
                    print(error)
                    return seal.reject(APIError.requestError)
                } else if let data = data {
                    let decoder = JSONDecoder()
                    
                    print(String.init(bytes: data, encoding: .utf8) ?? "No Data")
                    
                    do {
                        let vehicleSignalList = try decoder.decode(VehicleSignalList.self, from: data)
                        
                        return seal.fulfill(vehicleSignalList)
                    } catch {
                        print(error)
                        return seal.reject(APIError.invalidResponse)
                    }
                } else {
                    return seal.reject(APIError.emptyResponse)
                }
            }
            
            task.resume()
        }
    }
    
}
