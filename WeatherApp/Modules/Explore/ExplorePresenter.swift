//
//  ExplorePresenter.swift
//  WeatherApp
//
//  Created by FGX on 2022/07/01.
//

import Foundation
class ExplorePresenter:  ViewToPresenterExploreProtocol {
    var view: PresenterToViewExploreProtocol?
    var interactor: PresenterToInteractorExploreProtocol?
    var router: PresenterToRouterExploreProtocol?
    func viewDidLoad(_ place: Place) {
        interactor?.search(with: place.lat, and: place.lng)
    }
}
extension ExplorePresenter: InteractorToPresenterExploreProtocol{
    func success(fourSquareResponse: FoursquareResponse) {
        view?.loadData(fourSquareResponse: fourSquareResponse.results)
    }
    func failure(error: Error) {
        print(error)
    }
}
