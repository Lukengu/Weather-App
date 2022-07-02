//
//  WeatherContracts.swift
//  WeatherApp
//
//  Created by FGX on 2022/06/29.
//

import Foundation
import UIKit
import CoreLocation

// MARK: View Input (View -> Presenter)
protocol ViewToPresenterWeatherProtocol {
    var view: PresenterToViewWeatherProtocol? { get set }
    var interactor: PresenterToInteractorWeatherProtocol? { get set }
    var router: PresenterToRouterWeatherProtocol? { get set }
    func viewDidLoad()
    func presentFavourite()
    func saveToFavorite(name:String?)
}
// MARK: View Output (Presenter -> View)
protocol PresenterToViewWeatherProtocol {
    var presenter: ViewToPresenterWeatherProtocol? { get set }
    func willUpdate(with weatherResponse:WeatherResponse)
    func willLoadWeather(location: CLLocation?)
    func willUpdateFromLocal(weather: Weather)
    func showAlertMsg(title: String, message: String)
}
// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorWeatherProtocol {
    var presenter: InteractorToPresenterWeatherProtocol? { get set }
    func currentWeatherRemote(location: CLLocation)
    func currentWeatherLocal()
    func saveToFavorite(name:String?,location: CLLocation?)
}
// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterWeatherProtocol {
    func success(weatherResponse: WeatherResponse)
    func failure(error:Error)
    func localData(weather:Weather)
    func favoriteSaved()
}
// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterWeatherProtocol {
    var view:UIViewController? { get set }
    func showFavourite()
}
protocol WeatherWireFrameProtocol {
    static func createWeatherModule() -> WeatherView
}
