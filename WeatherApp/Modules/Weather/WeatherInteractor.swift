    //  WeatherInteractor.swift
    //  WeatherApp
    //
    //  Created by FGX on 2022/06/29.
    //
    import Foundation
    import CoreLocation
    import UIKit
    import CoreData

class WeatherInteractor:PresenterToInteractorWeatherProtocol {
    
    func saveToFavorite(name:String? = nil, location: CLLocation? = nil) {
        DispatchQueue.main.async { [self] in
            guard let appDelegate = UIApplication.shared.delegate  as? AppDelegate else { return }
            let managedContext = appDelegate.persistentContainer.viewContext
            let  place = Place(entity:Place.entity() , insertInto: managedContext)
            let placeFetchRequest:NSFetchRequest<Place>
            placeFetchRequest = Place.fetchRequest()
            
            if location == nil && name == nil {
                let fetchRequest:NSFetchRequest<Weather>
                fetchRequest = Weather.fetchRequest()
                do {
                    guard let wheather = try managedContext.fetch(fetchRequest).first else {return}
                    
                    placeFetchRequest.predicate = NSPredicate(format: "name == %@", wheather.place!)
                    do {
                        let places = try managedContext.fetch(placeFetchRequest)
                        if places.isEmpty {
                            place.lng = wheather.lng
                            place.lat = wheather.lat
                            place.name = wheather.place
                            appDelegate.saveContext()
                        }
                    } catch {}
                    
                } catch {}
                } else {
                    guard let location = location else {return}

                    placeFetchRequest.predicate = NSPredicate(format: "name == %@", name!)
                    do {
                        let places = try managedContext.fetch(placeFetchRequest)
                        if places.isEmpty {
                            place.lng = Double(location.coordinate.longitude)
                            place.lat = Double(location.coordinate.latitude )
                            place.name = name
                            appDelegate.saveContext()
                        }
                    } catch{}
                }
                presenter?.favoriteSaved()
            }
            
        
    }
    func currentWeatherRemote(location: CLLocation) {
        if let weatherEndpoint = Bundle.main.infoDictionary?["WEATHER_ENDPOINT"] as? String, let apiKey =  Bundle.main.infoDictionary?["WEATHER_API_KEY"] as? String {
                let latitude = String(location.coordinate.latitude)
                let longitude = String(location.coordinate.longitude)
                let endpoint = "https://\(String(format: weatherEndpoint, latitude,longitude, apiKey))"
                let url = URL(string: endpoint)!
            HttpRequestService.get(url: url, type: WeatherResponse.self, headers:["Content-type":"application/json"]) { [self] success, response, error in
                if success, let response = response as? WeatherResponse{
                    persist(response )
                    presenter?.success(weatherResponse: response)
                } else {
                    presenter?.failure(error: error!)
                }
              }
    
            }
    }
    func currentWeatherLocal() {
        guard let appDelegate = UIApplication.shared.delegate  as? AppDelegate else { return }
            DispatchQueue.main.async {
                let managedContext = appDelegate.persistentContainer.viewContext
                let fetchRequest:NSFetchRequest<Weather>
                fetchRequest = Weather.fetchRequest()
                do {
                    guard let row = try managedContext.fetch(fetchRequest).first else {return}
                    self.presenter?.localData(weather: row)
                } catch {
                }
            }
        }
    private func persist(_ response:WeatherResponse) {
            DispatchQueue.main.async {
                guard let appDelegate = UIApplication.shared.delegate  as? AppDelegate else { return }
                
                let managedContext = appDelegate.persistentContainer.viewContext
                let fetchRequest:NSFetchRequest<Weather>
                fetchRequest = Weather.fetchRequest()
                var weather:Weather
                do {
                    let object = try managedContext.fetch(fetchRequest)
                    if object.count > 0 {
                        weather = object.first!
                    } else {
                        weather = Weather(entity:Weather.entity() , insertInto: managedContext)
                    }
                    weather.lng = Double(response.coord.lon)
                    weather.lat = Double(response.coord.lat)
                    weather.place = response.name
                    weather.name = response.weather.first?.main
                    weather.max  = response.main.tempMax
                    weather.min  = response.main.tempMin
                    weather.temp = response.main.temp
                    weather.desc = response.weather.first?.description
                    weather.lastupdate = Date()
                    appDelegate.saveContext()
                } catch {
                    print(error)
                }
                
            }
        }
        var presenter:InteractorToPresenterWeatherProtocol?
    }
