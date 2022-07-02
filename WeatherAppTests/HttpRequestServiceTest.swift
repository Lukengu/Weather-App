//
//  HttpRequestServiceTest.swift
//  WeatherAppTests
//
//  Created by FGX on 2022/07/02.
//

import XCTest
@testable import WeatherApp

class HttpRequestServiceTest: XCTestCase {

    func testGet(){
        let expectation = self.expectation(description: "Api Call Completed")
        var fqResponse: FoursquareResponse?
        
        HttpRequestService.get(url: URL(string:"https://api.foursquare.com/v3/places/search?ll=41.8781,-87.6298")!,
                               type: FoursquareResponse.self, headers: ["Authorization":"fsq3RPDC1U2bF0DKQNk4q7arNtasKtsht7eopCdJa6xWgfM="]) { success, json, error in
            guard let json = json as? FoursquareResponse else {
                return
            }
            fqResponse = json
        }
        wait(for: [expectation], timeout: 30)
        XCTAssertNotNil(fqResponse)
        XCTAssertTrue(fqResponse?.results[0].name == "Intelligentsia Coffee")
    }

}
