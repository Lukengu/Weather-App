//
//  MapContracts.swift
//  WeatherApp
//
//  Created by FGX on 2022/07/02.
//

import Foundation
import MapKit
// MARK: View Input (View -> Presenter)
protocol ViewToPresenterMapProtocol {
    var view: PresenterToViewMapProtocol? { get set }
    var interactor: PresenterToInteractorMapProtocol? { get set }
    var router: PresenterToRouterMapProtocol? { get set }
    func viewDidLoad(mapView: MKMapView)
   
}
// MARK: View Output (Presenter -> View)
protocol PresenterToViewMapProtocol {
    var presenter: ViewToPresenterMapProtocol? { get set }
    func loadAnnotationInMap(landMarks:[PlaceLandMark])
   
}
// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorMapProtocol {
    var presenter: InteractorToPresenterMapProtocol? { get set }
    func getPlaces()
}
// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterMapProtocol {
    func landMarksRetreive(landmarks:[PlaceLandMark])
   
}
// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterMapProtocol {
}

protocol MapWireFrameProtocol {
    static func createMapModule() -> MapView
}
