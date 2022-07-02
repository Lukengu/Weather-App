//
//  FavouritePresenter.swift
//  WeatherApp
//
//  Created by FGX on 2022/07/01.
//

import Foundation
class FavouritePresenter:  ViewToPresenterFavouriteProtocol {
   
    var view: PresenterToViewFavouriteProtocol?
    var interactor: PresenterToInteractorFavouriteProtocol?
    var router: PresenterToRouterFavouriteProtocol?
    func viewDidLoad() {
        interactor?.getSavedPlaces()
    }
    func explore(place: Place) {
        router?.presentPlace(place)
    }
    func openPlacesInMap() {
        router?.showMap()
    }
    
}
extension FavouritePresenter: InteractorToPresenterFavouriteProtocol{
    func onPlaceRetrieved(places: [Place]) {
        view?.displayPlaces(places: places)
    }
}
