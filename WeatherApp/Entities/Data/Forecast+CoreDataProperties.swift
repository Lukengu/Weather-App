//
//  Forecast+CoreDataProperties.swift
//  WeatherApp
//
//  Created by FGX on 2022/07/01.
//
//

import Foundation
import CoreData


extension Forecast {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Forecast> {
        return NSFetchRequest<Forecast>(entityName: "Forecast")
    }

    @NSManaged public var day: String?
    @NSManaged public var name: String?
    @NSManaged public var order: Int16
    @NSManaged public var temp: Double

}

extension Forecast : Identifiable {

}
