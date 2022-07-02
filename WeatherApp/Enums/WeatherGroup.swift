//
//  WeatherGroup.swift
//  WeatherApp
//
//  Created by FGX on 2022/06/30.
//

import Foundation
import UIKit
enum WeatherGroup:String,CaseIterable {
    case clear = "Clear"
    case rain = "Rain"
    case clouds = "Clouds"
    case sun = "Sun"
    var image:UIImage? {
        switch self {
        case .clear:
            return UIImage(named: "\(theme.rawValue)sunny")
        case .rain:
            return UIImage(named: "\(theme.rawValue)rainy")
        case .clouds:
            return UIImage(named: "\(theme.rawValue)cloudly")
        case .sun:
            return UIImage(named: "\(theme.rawValue)sunny")
        }
    }
    var color: UIColor{
        switch self {
        case .rain:
            return .rainy
        case .clouds:
            return .cloudy
        case .clear:
            return .sunny
        case .sun:
            return .sunny
        }
        
    }
}
