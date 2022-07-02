//
//  FavouriteInteractor.swift
//  WeatherApp
//
//  Created by FGX on 2022/07/01.
//

import Foundation
import UIKit
import CoreData

class FavouriteInteractor: PresenterToInteractorFavouriteProtocol{
    var presenter: InteractorToPresenterFavouriteProtocol?
    
    func getSavedPlaces() {
        DispatchQueue.main.async { [self] in
            guard let appDelegate = UIApplication.shared.delegate  as? AppDelegate else { return }
            let managedContext = appDelegate.persistentContainer.viewContext
            let fetchRequest:NSFetchRequest<Place>
            fetchRequest = Place.fetchRequest()
            do{
                let places = try managedContext.fetch(fetchRequest)
                presenter?.onPlaceRetrieved(places: places)
            } catch {}
        }
    }
}

