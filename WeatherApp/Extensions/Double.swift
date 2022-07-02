//
//  Double.swift
//  WeatherApp
//
//  Created by FGX on 2022/06/30.
//

import Foundation
extension Double {
    func toCelsius() -> String {
        let measurement = Measurement(value: self , unit: UnitTemperature.celsius)
        let measurementFormatter = MeasurementFormatter()
        measurementFormatter.unitStyle = .short
        measurementFormatter.numberFormatter.maximumFractionDigits = 0
        measurementFormatter.unitOptions = .temperatureWithoutUnit
        return measurementFormatter.string(from: measurement)
    }
}
