//
//  Weather+CoreDataProperties.swift
//  WeatherApp
//
//  Created by FGX on 2022/07/01.
//
//

import Foundation
import CoreData


extension Weather {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Weather> {
        return NSFetchRequest<Weather>(entityName: "Weather")
    }

    @NSManaged public var desc: String?
    @NSManaged public var lastupdate: Date?
    @NSManaged public var max: Double
    @NSManaged public var min: Double
    @NSManaged public var name: String?
    @NSManaged public var place: String?
    @NSManaged public var temp: Double
    @NSManaged public var lat: Double
    @NSManaged public var lng: Double

}

extension Weather : Identifiable {

}
