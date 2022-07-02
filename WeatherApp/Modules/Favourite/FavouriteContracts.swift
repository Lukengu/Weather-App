//
//  FavouriteContracts.swift
//  WeatherApp
//
//  Created by FGX on 2022/07/01.
//
import Foundation
import CoreLocation
import UIKit

// MARK: View Input (View -> Presenter)
protocol ViewToPresenterFavouriteProtocol {
    var view: PresenterToViewFavouriteProtocol? { get set }
    var interactor: PresenterToInteractorFavouriteProtocol? { get set }
    var router: PresenterToRouterFavouriteProtocol? { get set }
    func viewDidLoad()
    func explore(place:Place)
    func openPlacesInMap()
}
// MARK: View Output (Presenter -> View)
protocol PresenterToViewFavouriteProtocol {
    var presenter: ViewToPresenterFavouriteProtocol? { get set }
    func displayPlaces(places:[Place])
    
}
// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorFavouriteProtocol {
    var presenter: InteractorToPresenterFavouriteProtocol? { get set }
    func getSavedPlaces()
}
// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterFavouriteProtocol {
    func onPlaceRetrieved(places: [Place])
}
// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterFavouriteProtocol {
    var view: UIViewController? { get set }
    func presentPlace(_ place :Place)
    func showMap()
}

protocol FavouriteWireFrameProtocol {
    static func createFavouriteModule() -> FavouriteView
}
