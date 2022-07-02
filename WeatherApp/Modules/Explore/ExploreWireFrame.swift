//
//  ExploreWireFrame.swift
//  WeatherApp
//
//  Created by FGX on 2022/07/01.
//

import Foundation
import UIKit
class ExploreWireFrame: ExploreWireFrameProtocol {
    static func createExploreModule() -> ExploreView {
        let view: ExploreView & PresenterToViewExploreProtocol = ExploreView(collectionViewLayout: UICollectionViewFlowLayout())
        var interactor: PresenterToInteractorExploreProtocol = ExploreInteractor()
        var presenter: ViewToPresenterExploreProtocol & InteractorToPresenterExploreProtocol = ExplorePresenter()
        let router: PresenterToRouterExploreProtocol = ExploreRouter()
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        interactor.presenter = presenter
        presenter.router = router
        return view
    }
}
