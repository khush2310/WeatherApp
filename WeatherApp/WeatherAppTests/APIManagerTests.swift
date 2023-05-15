//
//  APIManagerTests.swift
//  WeatherAppTests
//
//  Created by Khushboo Jain on 2023-05-11.
//

import XCTest
@testable import WeatherApp

final class APIManagerTests: XCTestCase {

    var sut: APIManager!
    var urlString = "https://api.open-meteo.com/v1/forecast?latitude=43.70&longitude=-79.42&daily=temperature_2m_max,temperature_2m_min,precipitation_probability_max&timezone=auto"
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        sut = APIManager(session: MockSession.shared)
        

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_making_URL_request() throws {
        let req = try? sut.makeRequest(from: urlString)
        XCTAssertEqual(req?.url?.scheme, "https")
        XCTAssertEqual(req?.url?.host(), "api.open-meteo.com")
        XCTAssertEqual(req?.url?.pathComponents, ["/", "v1", "forecast"])
    }
    
    func test_parsing_response() throws {
        let fileName = "TestResponse.json"
        let jsonData = try FileUtility.loadFileContentsFrom(fileName: fileName)
        let response = try sut.parseJSON(jsonData)
        XCTAssertEqual(response.time.count, 7)
        
        let day1 = response.getData(at: 0)
        XCTAssertEqual(day1.maxTempString, "26.4°C")
        XCTAssertEqual(day1.minTempString, "10.3°C")
        XCTAssertEqual(day1.precipitationString, "10%")
        XCTAssertEqual(day1.dateString, "May 11 2023")
        
        
    }
    
    func testRetrieveProductsValidResponse() throws {
        // we have a locally stored product list in JSON format to test against.
        let testBundle = Bundle(for: type(of: self))
        let fileName = "TestResponse.json"
        let data = try FileUtility.loadFileContentsFrom(fileName: fileName)
        let urlResponse = HTTPURLResponse(url: URL(string: urlString)!, statusCode: 200, httpVersion: nil, headerFields: nil)
        MockSession.mockResponse = (data, urlResponse, nil)
        let expectation = XCTestExpectation(description: "ready")
        sut.performRequest { weather, error in
            if error == nil {
                XCTAssertTrue(weather?.dateCount() == 7)
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 3.0)
    }
    
    func test_retrive_date_error() throws {
        // we have a locally stored product list in JSON format to test against.
        let urlResponse = HTTPURLResponse(url: URL(string: urlString)!, statusCode: 401, httpVersion: nil, headerFields: nil)
        MockSession.mockResponse = (nil, urlResponse, ErrorType.NetworkError)
        
        let expectation = XCTestExpectation(description: "ready")
        sut.performRequest { weather, error in
            if error != nil {
                XCTAssertEqual(error as! ErrorType, ErrorType.NetworkError)
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 3.0)
    }
}
