//
//  ForecastPresenter.swift
//  WeatherApp
//
//  Created by FGX on 2022/06/30.
//

import Foundation
import CoreLocation
class ForecastPresenter:  ViewToPresenterForecastProtocol {
    var presenter: ViewToPresenterForecastProtocol?
    var view: PresenterToViewForecastProtocol?
    var interactor: PresenterToInteractorForecastProtocol?
    var router: PresenterToRouterForecastProtocol?
    func viewDidLoad(with location: CLLocation?) {
        guard let location = location else {
            interactor?.getLocalForecasts()
            return
        }
        interactor?.getRemoteForecasts(location: location)
    }
}
extension ForecastPresenter: InteractorToPresenterForecastProtocol{
    func success(forecastResponse: [ParsedForescat]) {
        view?.reloadTable(forecastResponse: forecastResponse)
    }
    func failure(error: Error) {
        print(error)
    }
}
