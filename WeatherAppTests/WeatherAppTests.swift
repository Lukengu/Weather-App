//
//  WeatherAppTests.swift
//  WeatherAppTests
//
//  Created by FGX on 2022/06/29.
//

import XCTest
@testable import WeatherApp

class WeatherAppTests: XCTestCase {

     func testConfiguration() {
        if let weatherEndpoint = Bundle.main.infoDictionary?["WEATHER_ENDPOINT"] as? String {
            let endpoint = String(format: weatherEndpoint, "test","test","test")
            XCTAssertEqual("api.openweathermap.org/data/2.5/weather?lat=test&lon=test&appid=test",endpoint)
        }
    }

}
