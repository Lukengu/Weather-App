//
//  FavouriteWireFrame.swift
//  WeatherApp
//
//  Created by FGX on 2022/07/01.
//

import Foundation
class FavouriteWireFrame: FavouriteWireFrameProtocol {
    static func createFavouriteModule() -> FavouriteView {
        let view: FavouriteView & PresenterToViewFavouriteProtocol = FavouriteView(style: .grouped)
        var interactor: PresenterToInteractorFavouriteProtocol = FavouriteInteractor()
        var presenter: ViewToPresenterFavouriteProtocol & InteractorToPresenterFavouriteProtocol = FavouritePresenter()
        var router: PresenterToRouterFavouriteProtocol = FavouriteRouter()
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        interactor.presenter = presenter
        presenter.router = router
        router.view = view
        
        return view
    }
}
