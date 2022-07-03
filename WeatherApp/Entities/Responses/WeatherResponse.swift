//
//  WeatherResponse.swift
//  WeatherApp
//
//  Created by FGX on 2022/06/30.
//

import Foundation

struct WeatherResponse: Decodable {
    var weather: [WeatherInfo]
    var main: Main
    var name: String
    var coord: Coord
}
struct WeatherInfo: Decodable {
    var id: Int
    var main: String
    var description: String
    var icon: String
}
struct Main: Decodable {
    var temp: Double
    var feelsLike: Double
    var tempMin: Double
    var tempMax: Double
    var pressure: Int
    var humidity: Double
}
struct Coord : Decodable {
    var lon: Double
    var lat: Double
   
}
