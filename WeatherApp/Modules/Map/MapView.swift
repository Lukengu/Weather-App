//
//  MapView.swift
//  WeatherApp
//
//  Created by FGX on 2022/07/02.
//

import UIKit
import MapKit

class MapView: UIViewController {
    var presenter: ViewToPresenterMapProtocol?
    var mapView: MKMapView = {
        let mkMapView = MKMapView()
        mkMapView.translatesAutoresizingMaskIntoConstraints = false
        return mkMapView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        addSubViews()
        addContraints()
        presenter?.viewDidLoad(mapView: mapView)
        mapView.delegate = self
        
    }
    func setUpView(){
        let weather = UserDefaults.standard.string(forKey: "weather")
        let themeColor =  WeatherGroup.allCases.filter { weatherGroup in
            return  weatherGroup.rawValue == weather
        }.first?.color
        view.backgroundColor = themeColor
    }
    func addSubViews(){
        view.addSubview(mapView)
    }
    func addContraints(){
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
}

extension MapView : MKMapViewDelegate {
      func mapView(
        _ mapView: MKMapView,
        viewFor annotation: MKAnnotation
      ) -> MKAnnotationView? {
        guard let annotation = annotation as? PlaceLandMark else {
          return nil
        }
        let identifier = "place"
        var view: MKMarkerAnnotationView
        if let dequeuedView = mapView.dequeueReusableAnnotationView(
          withIdentifier: identifier) as? MKMarkerAnnotationView {
          dequeuedView.annotation = annotation
          view = dequeuedView
        } else {
          view = MKMarkerAnnotationView(
            annotation: annotation,
            reuseIdentifier: identifier)
          view.canShowCallout = true
          view.calloutOffset = CGPoint(x: -5, y: 5)
          view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        return view
      }
    
}
extension MapView : PresenterToViewMapProtocol {
    func loadAnnotationInMap(landMarks: [PlaceLandMark]) {
        mapView.addAnnotations(landMarks)
    }
}
