//
//  FileUtility.swift
//  WeatherApp
//
//  Created by Khushboo Jain on 2023-05-11.
//

import Foundation

class FileUtility {
    static func loadFileContentsFrom(fileName: String) throws -> Data {
         
        guard let file = Bundle.main.url(forResource: "TestResponse", withExtension: "json")
        else {
            throw ErrorType.fileNotFound
        }
        return try Data(contentsOf: file)
    }
}
