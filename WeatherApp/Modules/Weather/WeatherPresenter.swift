//
//  WeatherPresenter.swift
//  WeatherApp
//
//  Created by FGX on 2022/06/29.
//

import Foundation
import CoreLocation

class WeatherPresenter: ViewToPresenterWeatherProtocol {
    var view: PresenterToViewWeatherProtocol?
    var interactor: PresenterToInteractorWeatherProtocol?
    var router: PresenterToRouterWeatherProtocol?
    var locationService = LocationService.shared
    func viewDidLoad() {
        do {
            if try !Reachability().isConnectedToNetwork {
                interactor?.currentWeatherLocal()
            } else {
                locationService.delegate = self
            }
        } catch {}
        NotificationCenter.default
            .addObserver(self,
                         selector: #selector(statusManager),
                         name: .flagsChanged,
                         object: nil)
    }
    @objc func statusManager(_ notification: Notification) {
        if Network.reachability?.status  == .unreachable {
            interactor?.currentWeatherLocal()
        }
    }
    func saveToFavorite(name:String?) {
        if Network.reachability?.status  == .unreachable {
            interactor?.saveToFavorite(name:nil, location:nil)
        } else {
            interactor?.saveToFavorite(name: name, location: locationService.currentLocation)
        }
    }
    func presentFavourite() {
        router?.showFavourite()
    }
}

extension WeatherPresenter: InteractorToPresenterWeatherProtocol {
    func favoriteSaved() {
        view?.showAlertMsg(title: "Success", message: "Favorite Saved")
    }
    
    func success(weatherResponse: WeatherResponse) {
        view?.willUpdate(with: weatherResponse)
    }
    func failure(error: Error) {
        print(error)
    }
    func localData(weather: Weather) {
        view?.willUpdateFromLocal(weather: weather)
    }
}

extension WeatherPresenter: LocationServiceDelegate {
    func onLocationUpdate(location: CLLocation) {
        interactor?.currentWeatherRemote(location: location)
        view?.willLoadWeather(location: location)
    }
    func onLocationDidFailWithError(error: Error) {
        print(error.localizedDescription)
    }
}
