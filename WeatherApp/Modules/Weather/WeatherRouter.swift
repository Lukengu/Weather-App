//
//  WeatherRouter.swift
//  WeatherApp
//
//  Created by FGX on 2022/06/29.
//

import Foundation
import UIKit

class WeatherRouter : PresenterToRouterWeatherProtocol {
    var view: UIViewController?
    func showFavourite() {
        let favouriteView = FavouriteWireFrame.createFavouriteModule()
        view?.navigationController?.pushViewController(favouriteView, animated: true)
    }
}
