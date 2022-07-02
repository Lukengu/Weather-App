//
//  ForecastResponse.swift
//  WeatherApp
//
//  Created by FGX on 2022/06/30.
//

import Foundation
struct ForecastResponse: Decodable{
    var list: [Lists]
}
struct Lists: Decodable{
    var dt: Double
    var main: ForecastMain
    var weather: [ForecastWeather]
}
struct ForecastMain: Decodable{
    var temp : Double
}
struct ForecastWeather: Decodable{
    var main : String
}

