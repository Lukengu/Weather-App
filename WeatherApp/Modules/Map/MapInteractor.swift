//
//  MapInteractor.swift
//  WeatherApp
//
//  Created by FGX on 2022/07/02.
//

import Foundation
import UIKit
import CoreData
class MapInteractor: PresenterToInteractorMapProtocol{
    
    var presenter: InteractorToPresenterMapProtocol?
    
    func getPlaces() {
        DispatchQueue.main.async { [self] in
            guard let appDelegate = UIApplication.shared.delegate  as? AppDelegate else { return }
            let managedContext = appDelegate.persistentContainer.viewContext
            let fetchRequest:NSFetchRequest<Place>
            fetchRequest = Place.fetchRequest()
            do{
                let places = try managedContext.fetch(fetchRequest)
                var landMarks:[PlaceLandMark] = [PlaceLandMark]()
                places.forEach { place in
                    landMarks.append(PlaceLandMark(place: place))
                }
                presenter?.landMarksRetreive(landmarks: landMarks)
            } catch {}
        }
    }
   
}
