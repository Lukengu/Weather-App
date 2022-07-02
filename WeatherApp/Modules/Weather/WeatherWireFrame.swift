//
//  WeatherWireframe.swift
//  WeatherApp
//
//  Created by FGX on 2022/06/30.
//

import Foundation
import UIKit
class WeatherWireFrame: WeatherWireFrameProtocol {
    static func createWeatherModule() -> WeatherView {
        let view: WeatherView & PresenterToViewWeatherProtocol = WeatherView()
        var interactor: PresenterToInteractorWeatherProtocol = WeatherInteractor()
        var presenter: ViewToPresenterWeatherProtocol & InteractorToPresenterWeatherProtocol = WeatherPresenter()
        var router: PresenterToRouterWeatherProtocol = WeatherRouter()
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        interactor.presenter = presenter
        presenter.router = router
        router.view = view
        return view
    }
}
