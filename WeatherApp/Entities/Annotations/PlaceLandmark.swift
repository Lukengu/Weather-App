//
//  PlaceLandmark.swift
//  WeatherApp
//
//  Created by FGX on 2022/07/02.
//

import Foundation
import MapKit
class PlaceLandMark : NSObject, MKAnnotation {
    let coordinate: CLLocationCoordinate2D
    let title: String?
    
    init(place: Place) {
        self.title = place.name
        let coordinate = CLLocationCoordinate2D(latitude: place.lat, longitude: place.lng)
        self.coordinate = coordinate
    }

}
