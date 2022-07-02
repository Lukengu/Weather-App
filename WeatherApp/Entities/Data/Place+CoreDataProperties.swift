//
//  Place+CoreDataProperties.swift
//  WeatherApp
//
//  Created by FGX on 2022/07/01.
//
//

import Foundation
import CoreData


extension Place {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Place> {
        return NSFetchRequest<Place>(entityName: "Place")
    }

    @NSManaged public var lat: Double
    @NSManaged public var lng: Double
    @NSManaged public var name: String?

}
extension Place : Identifiable {
    
}
