//
//  HttpRequestService.swift
//  WeatherApp
//
//  Created by FGX on 2022/07/02.
//

import Foundation
class HttpRequestService {
    typealias Response = (_ success: Bool, _ response: Decodable?, _ error: Error?) -> Void
    
    
    static func get<T:Decodable>(url:URL,type: T.Type, headers:[String:String]? = nil, completion:@escaping Response) {
        var request = URLRequest(url: url)
        if let  headers = headers {
            headers.forEach { (key: String, value: String) in
                request.setValue(value, forHTTPHeaderField: key)
            }
        }
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let response  = try decoder.decode(T.self, from: data)
                    completion(true, response, nil)
                    
                } catch let error {
                    completion(false, nil, error)
                }
            } else if let error = error {
                completion(false, nil, error)
            }
        }
        task.resume()
    }

}
