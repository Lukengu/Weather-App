//
//  FavouriteRouter.swift
//  WeatherApp
//
//  Created by FGX on 2022/07/01.
//

import Foundation
import UIKit
class FavouriteRouter : PresenterToRouterFavouriteProtocol {

    var view: UIViewController?
    
    func presentPlace(_ place: Place) {
        let explore = ExploreWireFrame.createExploreModule()
        explore.place = place
        view?.navigationController?.pushViewController(explore, animated: false)
        
    }
    func showMap() {
        let map = MapWireFrame.createMapModule()
        view?.navigationController?.pushViewController(map, animated: false)
    }
    
}
