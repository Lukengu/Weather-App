//
//  MapWireFrame.swift
//  WeatherApp
//
//  Created by FGX on 2022/07/02.
//

import Foundation
class MapWireFrame: MapWireFrameProtocol {
    static func createMapModule() -> MapView {
        let view: MapView & PresenterToViewMapProtocol = MapView()
        var interactor: PresenterToInteractorMapProtocol = MapInteractor()
        var presenter: ViewToPresenterMapProtocol & InteractorToPresenterMapProtocol = MapPresenter()
        let router: PresenterToRouterMapProtocol = MapRouter()
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        interactor.presenter = presenter
        presenter.router = router
      
        return view
    }
}
