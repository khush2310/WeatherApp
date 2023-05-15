//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by Khushboo Jain on 2023-05-09.
//

import Foundation

// MARK: - WeatherData

struct WeatherData: Codable {
    let latitude, longitude: Double
    let daily: Daily

    enum CodingKeys: String, CodingKey {
        case latitude, longitude
        case daily
    }
}

// MARK: - Daily
struct Daily: Codable {
    let time: [Date]
    let temperature2MMax, temperature2MMin: [Double]
    let precipitationProbabilityMax: [Int]

    enum CodingKeys: String, CodingKey {
        case time
        case temperature2MMax = "temperature_2m_max"
        case temperature2MMin = "temperature_2m_min"
        case precipitationProbabilityMax = "precipitation_probability_max"
    }
    
    func getData(at index:Int) -> WeatherModel {
        let max = temperature2MMax[index]
        let min = temperature2MMin[index]
        let prec = precipitationProbabilityMax[index]
        let dt = time[index]
        return WeatherModel(max: max, min: min, prec: prec, date: dt)
    }
    
    func dateCount() -> Int {
        return time.count
    }
}


