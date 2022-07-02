//
//  Image.swift
//  WeatherApp
//
//  Created by FGX on 2022/07/02.
//

import Foundation
import UIKit
extension UIImageView {
    func loadFromUrl(_ link:String){
        let url = URL(string:link )
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url!) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
