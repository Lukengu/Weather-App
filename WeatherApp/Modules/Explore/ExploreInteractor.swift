//
//  ExploreInteractor.swift
//  WeatherApp
//
//  Created by FGX on 2022/07/01.
//

import Foundation
import UIKit
class ExploreInteractor: PresenterToInteractorExploreProtocol{
    var presenter: InteractorToPresenterExploreProtocol?
    func search(with latitude: Double, and longitude: Double) {
        if let fqEndpoint = Bundle.main.infoDictionary?["FQ_ENPOINT"] as? String, let apiKey =  Bundle.main.infoDictionary?["FQ_API_KEY"] as? String {
            let url = URL(string: "https://\(String(format: fqEndpoint, String(latitude),String(longitude)))")!
            HttpRequestService.get(url: url, type: FoursquareResponse.self, headers:["Content-type":"application/json", "Authorization": apiKey]) { [self] success, response, error in
                if success, let response = response as? FoursquareResponse{
                    presenter?.success(fourSquareResponse: response)
                } else {
                    presenter?.failure(error: error!)
                }
            }
        }
    }
}
