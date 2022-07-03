//
//  FoursquareResponse.swift
//  WeatherApp
//
//  Created by FGX on 2022/07/02.
//

import Foundation
struct FoursquareResponse: Decodable{
    var results: [FQResults]
}
struct FQResults : Decodable {
    var categories: [FQCategory]
    var name: String
}
struct FQCategory : Decodable {
    var name: String
    var icon : Icon
}
struct Icon : Decodable {
    var prefix:String
    var suffix:String
}
