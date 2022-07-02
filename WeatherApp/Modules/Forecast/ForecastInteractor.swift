//
//  ForecastInteractor.swift
//  WeatherApp
//
//  Created by FGX on 2022/06/30.
//

import Foundation
import CoreLocation
import CoreData
import UIKit

class ForecastInteractor: PresenterToInteractorForecastProtocol{
    var presenter: InteractorToPresenterForecastProtocol?
    func getRemoteForecasts(location: CLLocation) {
     if let forecastEndpoint = Bundle.main.infoDictionary?["FORECAST5_ENDPOINT"] as? String, let apiKey =  Bundle.main.infoDictionary?["WEATHER_API_KEY"] as? String {
         let latitude = String(location.coordinate.latitude)
         let longitude = String(location.coordinate.longitude)
         let endpoint = "https://\(String(format:forecastEndpoint, latitude,longitude,apiKey))"
         let url = URL(string: endpoint)!
         
         HttpRequestService.get(url: url, type: ForecastResponse.self, headers:["Content-type":"application/json"]) { [self] success, response, error in
             if success, let response = response as? ForecastResponse{
                 let parsedResponse = parse(response: response)
                 persist(parseResponse: parsedResponse)
                 presenter?.success(forecastResponse: parsedResponse)
             } else {
                 presenter?.failure(error: error!)
             }
           }
 
         }
    }
    func getLocalForecasts() {
        DispatchQueue.main.async { [self] in
            guard let appDelegate = UIApplication.shared.delegate  as? AppDelegate else { return }
            let managedContext = appDelegate.persistentContainer.viewContext
            let fetchRequest:NSFetchRequest<Forecast>
            fetchRequest = Forecast.fetchRequest()
            do{
                let forecasts = try managedContext.fetch(fetchRequest)
                var parsedForecast: [ParsedForescat] = []
                forecasts.forEach { forecast in
                    parsedForecast.append(ParsedForescat(day: forecast.day!, name: forecast.name!, temp: forecast.temp))
                }
                self.presenter?.success(forecastResponse: parsedForecast)
            } catch {
                self.presenter?.failure(error: error)
            }
        }
    }
    private func persist(parseResponse: [ParsedForescat]) {
        DispatchQueue.main.async {
            guard let appDelegate = UIApplication.shared.delegate  as? AppDelegate else { return }
            
            let managedContext = appDelegate.persistentContainer.viewContext
            let fetchRequest:NSFetchRequest<NSFetchRequestResult>
            = NSFetchRequest(entityName: "Forecast")
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            do {
                try managedContext.execute(deleteRequest)
            } catch {
            }
            appDelegate.saveContext()
            parseResponse.enumerated().forEach { (index,response) in
                let forecast = Forecast(entity:Forecast.entity() , insertInto: managedContext)
                forecast.temp = response.temp
                forecast.day = response.day
                forecast.name = response.name
                forecast.order = Int16(index)
                appDelegate.saveContext()
                
            }
        }
    }
    
    private func parse(response:ForecastResponse) -> [ParsedForescat]{
        var dt:[Double] = []
        var dates:[String] = []
        for forecasts in response.list {
            if !dates.contains(toDate(forecasts.dt)){
                dates.append(toDate(forecasts.dt))
                dt.append(forecasts.dt)
            }
        }
        
        let forecasts = response.list.filter { forecast in
            return dt.contains(forecast.dt)
        }.prefix(6).dropLast()
        var parsedList:[ParsedForescat] = []
        forecasts.forEach { forecast in
            parsedList.append(ParsedForescat(
                day: toDay(forecast.dt), name: forecast.weather.first!.main, temp: forecast.main.temp
            ))
        }
        return parsedList
        
    }
    
    private func toDate(_ dt: Double) -> String {
        let date = Date(timeIntervalSince1970: dt)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: date)
    }
    private func  toDay(_ dt: Double) -> String {
        let date = Date(timeIntervalSince1970: dt)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: date)
    }

}
