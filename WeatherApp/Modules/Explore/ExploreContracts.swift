//
//  ExploreContracts.swift
//  WeatherApp
//
//  Created by FGX on 2022/07/02.
//
import Foundation
// MARK: View Input (View -> Presenter)
protocol ViewToPresenterExploreProtocol {
    var view: PresenterToViewExploreProtocol? { get set }
    var interactor: PresenterToInteractorExploreProtocol? { get set }
    var router: PresenterToRouterExploreProtocol? { get set }
    func viewDidLoad(_ place:Place)
   
}
// MARK: View Output (Presenter -> View)
protocol PresenterToViewExploreProtocol {
    var presenter: ViewToPresenterExploreProtocol? { get set }
    func loadData(fourSquareResponse: [FQResults])
}
// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorExploreProtocol {
    var presenter: InteractorToPresenterExploreProtocol? { get set }
    func search(with latitude:Double, and longitude:Double)
    
}
// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterExploreProtocol {
    func success(fourSquareResponse: FoursquareResponse)
    func failure(error:Error)
}
// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterExploreProtocol {
}

protocol ExploreWireFrameProtocol {
    static func createExploreModule() -> ExploreView
}
