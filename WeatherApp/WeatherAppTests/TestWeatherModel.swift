//
//  TestWeatherModel.swift
//  WeatherAppTests
//
//  Created by Khushboo Jain on 2023-05-11.
//

import XCTest
@testable import WeatherApp
final class TestWeatherModel: XCTestCase {

    var sut: WeatherModel!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
        sut = WeatherModel(max: 25.0, min: 12.0, prec: 23, date: Date(timeIntervalSince1970: 1683809909.675139))
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        try super.tearDownWithError()
    }

    func testVerifyNotNill() throws {
        XCTAssertNotNil(sut)
    }
    
    func testVerifyStoredPropertiesNotNil() throws {
        XCTAssertNotNil(sut.max)
        XCTAssertNotNil(sut.min)
        XCTAssertNotNil(sut.prec)
        XCTAssertNotNil(sut.date)
    }

    func testVerifyComputedPropertiesNotNil() throws {
        XCTAssertNotNil(sut.maxTempString)
        XCTAssertNotNil(sut.minTempString)
        XCTAssertNotNil(sut.precipitationString)
        XCTAssertNotNil(sut.dateString)
    }
    
    func testVerifyComputedPropertiesValue() throws {
        XCTAssertEqual(sut.maxTempString, "25.0°C")
        XCTAssertEqual(sut.minTempString, "12.0°C")
        XCTAssertEqual(sut.precipitationString, "23%")
        XCTAssertEqual(sut.dateString, "May 11 2023")
    }

}
