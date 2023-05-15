//
//  APIManager.swift
//  WeatherApp
//
//  Created by Khushboo Jain on 2023-05-09.
//

import Foundation
import CoreLocation

enum ErrorType: Error {
    case invalidURL
    case fileNotFound
    case dataNotFound
    case NetworkError
    case ParseError
}


class APIManager {
    let weatherURL = "https://api.open-meteo.com/v1/forecast?latitude=43.70&longitude=-79.42&daily=temperature_2m_max,temperature_2m_min,precipitation_probability_max&timezone=auto"

    
    var urlSession: URLSession!
    
    init(session: URLSession? = nil) {
        if session == nil{
            urlSession = URLSession.shared
        }else {
            urlSession = session
        }
    }
    
    func makeRequest(from string: String) throws -> URLRequest {
        guard let url = URL(string: string) else { throw ErrorType.invalidURL}
        return URLRequest(url: url)
    }
    
    func parseJSON(_ weatherData: Data) throws -> Daily {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(formatter)
        let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
        return decodedData.daily
    }
    
    func performRequest(completion: @escaping (Daily? , Error?) -> Void) {
        guard let dataRequest = try? makeRequest(from: weatherURL) else { return }
        urlSession.dataTask(with: dataRequest) { data, response, error in
            if error != nil {
                completion(nil, error)
                return
            }
            guard let data = data else { return }
            do {
                let weather = try self.parseJSON(data)
                completion(weather, nil)
            }
            catch {
                completion(nil, error)
            }
        }.resume()
    }
    
    
    
    
    
}

