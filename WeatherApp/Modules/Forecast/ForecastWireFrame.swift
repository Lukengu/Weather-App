//
//  ForecastWireFire.swift
//  WeatherApp
//
//  Created by FGX on 2022/06/30.
//
import Foundation
import UIKit
import CoreLocation

class ForecastWireFrame: ForecastWireFrameProtocol {
    
    static func createForecastModule(_ location: CLLocation?) -> ForecastView {
        let view: ForecastView & PresenterToViewForecastProtocol = ForecastView(style: .grouped)
        var interactor: PresenterToInteractorForecastProtocol = ForecastInteractor()
        var presenter: ViewToPresenterForecastProtocol & InteractorToPresenterForecastProtocol = ForecastPresenter()
        let router: PresenterToRouterForecastProtocol = ForecastRouter()
        
        view.currrentLocation = location
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        interactor.presenter = presenter
        presenter.router = router
        return view
    }
}
