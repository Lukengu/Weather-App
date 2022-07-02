//
//  MapPresenter.swift
//  WeatherApp
//
//  Created by FGX on 2022/07/02.
//

import Foundation
import MapKit
class MapPresenter:  ViewToPresenterMapProtocol {
    var view: PresenterToViewMapProtocol?
    var interactor: PresenterToInteractorMapProtocol?
    var router: PresenterToRouterMapProtocol?
    var locationService = LocationService.shared
    var mapView:MKMapView?
    func viewDidLoad(mapView: MKMapView) {
        self.mapView = mapView
        locationService.delegate = self
        mapView.centerToLocation(locationService.currentLocation)
        let region = MKCoordinateRegion(
             center: locationService.currentLocation.coordinate,
             latitudinalMeters: 50000,
             longitudinalMeters: 60000)
           mapView.setCameraBoundary(
             MKMapView.CameraBoundary(coordinateRegion: region),
             animated: true)
           let zoomRange = MKMapView.CameraZoomRange(maxCenterCoordinateDistance: 200000)
           mapView.setCameraZoomRange(zoomRange, animated: true)
        interactor?.getPlaces()
        
    }
}
extension MapPresenter : LocationServiceDelegate {
    func onLocationUpdate(location: CLLocation) {
        mapView!.centerToLocation(location)
        interactor?.getPlaces()
    }
    func onLocationDidFailWithError(error: Error) {
        
    }
}
extension MapPresenter: InteractorToPresenterMapProtocol{
    func landMarksRetreive(landmarks: [PlaceLandMark]) {
        view?.loadAnnotationInMap(landMarks: landmarks)
    }
}
private extension MKMapView {
  func centerToLocation(
    _ location: CLLocation,
    regionRadius: CLLocationDistance = 1000
  ) {
    let coordinateRegion = MKCoordinateRegion(
      center: location.coordinate,
      latitudinalMeters: regionRadius,
      longitudinalMeters: regionRadius)
      setRegion(coordinateRegion, animated: true)
  }
}


