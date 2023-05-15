//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by Khushboo Jain on 2023-05-11.
//

import Foundation

struct WeatherModel {
    let max: Double
    let min: Double
    let prec: Int
    let date: Date
    
    var maxTempString: String {
        return String(format: "%.1f°C", max)
    }
    var minTempString: String {
        return String(format: "%.1f°C", min)
    }
    var precipitationString: String {
        return String(format: "%d%@", prec,"%")
    }
    var dateString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd yyyy"
        return formatter.string(from: date)
    }
    
}
