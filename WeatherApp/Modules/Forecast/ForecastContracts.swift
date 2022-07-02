//
//  ForecastContracts.swift
//  WeatherApp
//
//  Created by FGX on 2022/06/29.
//

import Foundation
import UIKit
import CoreLocation


// MARK: View Input (View -> Presenter)
protocol ViewToPresenterForecastProtocol {
    var view: PresenterToViewForecastProtocol? { get set }
    var interactor: PresenterToInteractorForecastProtocol? { get set }
    var router: PresenterToRouterForecastProtocol? { get set }
    func viewDidLoad(with location:CLLocation?)
}

// MARK: View Output (Presenter -> View)
protocol PresenterToViewForecastProtocol {
    var presenter: ViewToPresenterForecastProtocol? { get set }
    func reloadTable(forecastResponse: [ParsedForescat])
}

// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorForecastProtocol {
    var presenter: InteractorToPresenterForecastProtocol? { get set }
    func getRemoteForecasts(location:CLLocation)
    func getLocalForecasts()
}

// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterForecastProtocol {
    func success(forecastResponse:[ParsedForescat])
    func failure(error:Error)
}
// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterForecastProtocol {
}

protocol ForecastWireFrameProtocol {
    static func createForecastModule(_ location: CLLocation?) -> ForecastView
}
