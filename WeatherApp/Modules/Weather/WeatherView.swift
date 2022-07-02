//
//  WeatherView.swift
//  WeatherApp
//
//  Created by FGX on 2022/06/29.
//

import UIKit
import CoreLocation

class WeatherView: UIViewController {
    // MARK: - Properties
    var presenter: ViewToPresenterWeatherProtocol?
    var alertController: UIAlertController?
    var dateFormatter = DateFormatter()
    var cityName = ""
    var  forecastImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    var  bottomView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    var tempLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 40.0)
        return label
    }()
    var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 40.0)
        return label
    }()
    var minLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 17.0)
        return label
    }()
    var minLabelValue: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 17.0)
        return label
    }()
    var currentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 17.0)
        return label
    }()
    var currentLabelValue: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 17.0)
        return label
    }()
    var maxLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 17.0)
        return label
    }()
    var maxLabelValue: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 17.0)
        return label
    }()
    var separator: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderWidth = 1.0
        view.layer.borderColor = UIColor.white.cgColor
        return view
    }()
    var forecastView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderColor = UIColor.white.cgColor
        return view
    }()
    var reportPane: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderColor = UIColor.white.cgColor
        return view
    }()
    var lastUpdatedLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 12.0)
        return label
    }()
    var favButton: UIButton = {
        let button = UIButton()
        button.setTitle("Add Favourite", for: .normal)
        button.tintColor = .white
        button.backgroundColor = .clear
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isHidden = true
        button.layer.cornerRadius = 10
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        return button
    }()
    var viewButton: UIButton = {
        let button = UIButton()
        button.setTitle("View Favourite", for: .normal)
        button.tintColor = .white
        button.backgroundColor = .clear
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isHidden = true
        button.layer.cornerRadius = 10
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        return button
    }()
    var forecastTable = ForecastWireFrame.createForecastModule(nil)
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeVar()
        addViews()
        setUpConstraints()
        addActions()
        presenter?.viewDidLoad()
    }
    func initializeVar() {
        view.backgroundColor = .white
        view.isUserInteractionEnabled = true
        dateFormatter.dateFormat = "MMM dd,yyyy HH:mm"
    }
    func addActions() {
        favButton.addAction(UIAction(handler: { [self] _ in
            presenter?.saveToFavorite(name:cityName)
        }), for: .touchUpInside)
        viewButton.addAction(UIAction(handler: { [self] _ in
            presenter?.presentFavourite()
        }), for: .touchUpInside)
    }
   
    func addViews() {
        forecastImage.addSubview(tempLabel)
        forecastImage.addSubview(descriptionLabel)
        view.addSubview(forecastImage)
        bottomView.addSubview(separator)
        bottomView.addSubview(minLabelValue)
        bottomView.addSubview(minLabel)
        bottomView.addSubview(currentLabel)
        bottomView.addSubview(currentLabelValue)
        bottomView.addSubview(maxLabel)
        bottomView.addSubview(maxLabelValue)
        view.addSubview(bottomView)
        view.addSubview(forecastView)
        reportPane.addSubview(lastUpdatedLabel)
        view.addSubview(reportPane)
        view.addSubview(favButton)
        view.addSubview(viewButton)
        addChild(forecastTable)
        forecastView.addSubview(forecastTable.view)
        forecastTable.view.frame = forecastTable.view.bounds
        forecastTable.view.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        forecastTable.didMove(toParent: self)
    }
    func setUpConstraints() {
        NSLayoutConstraint.activate([
            forecastImage.topAnchor.constraint(equalTo: view.topAnchor),
            forecastImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            forecastImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tempLabel.centerXAnchor.constraint(equalTo: forecastImage.centerXAnchor),
            tempLabel.topAnchor.constraint(equalTo: forecastImage.topAnchor,constant: 90.0),
            descriptionLabel.topAnchor.constraint(equalTo: tempLabel.bottomAnchor, constant: 5),
            descriptionLabel.centerXAnchor.constraint(equalTo: tempLabel.centerXAnchor),
            bottomView.topAnchor.constraint(equalTo: forecastImage.bottomAnchor),
            bottomView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            minLabelValue.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 15.0),
            minLabel.topAnchor.constraint(equalTo: minLabelValue.topAnchor, constant: 15.0),
            minLabel.centerXAnchor.constraint(equalTo:minLabelValue.centerXAnchor ),
            minLabelValue.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 20.0),
            currentLabelValue.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 15.0),
            currentLabelValue.centerXAnchor.constraint(equalTo:bottomView.centerXAnchor),
            currentLabel.topAnchor.constraint(equalTo: currentLabelValue.topAnchor, constant: 15.0),
            currentLabel.centerXAnchor.constraint(equalTo:currentLabelValue.centerXAnchor ),
            maxLabelValue.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 15.0),
            maxLabelValue.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -20.0),
            maxLabel.topAnchor.constraint(equalTo: maxLabelValue.topAnchor, constant: 15.0),
            maxLabel.centerXAnchor.constraint(equalTo: maxLabelValue.centerXAnchor ),
            separator.heightAnchor.constraint(equalToConstant: 1),
            separator.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor),
            separator.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor),
            separator.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 60),
            forecastView.topAnchor.constraint(equalTo: separator.bottomAnchor),
            forecastView.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor),
            forecastView.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor),
            forecastView.bottomAnchor.constraint(equalTo: reportPane.topAnchor),
            reportPane.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor),
            reportPane.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor),
            reportPane.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor),
            reportPane.heightAnchor.constraint(equalToConstant: 64),
            lastUpdatedLabel.centerYAnchor.constraint(equalTo:reportPane.centerYAnchor),
            lastUpdatedLabel.centerXAnchor.constraint(equalTo:reportPane.centerXAnchor),
            favButton.bottomAnchor.constraint(equalTo: viewButton.topAnchor, constant: -3),
            favButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 35),
            favButton.heightAnchor.constraint(equalToConstant: 44),
            favButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -35),
            viewButton.bottomAnchor.constraint(equalTo: reportPane.topAnchor),
            viewButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 35),
            viewButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -35),
            viewButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    // MARK Protocol Signature
    func showAlertMsg(title: String, message: String) {
        guard (alertController == nil) else {return}
        alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController!.addAction(UIAlertAction(title: "OK", style: .default))
        present(alertController!, animated: true, completion: nil)
    }
    func willLoadWeather(location:CLLocation?) {
        forecastTable.populateTable(with: location)
    }

}
extension WeatherView: PresenterToViewWeatherProtocol {
    func willUpdateFromLocal(weather: Weather) {
        UserDefaults.standard.set(weather.name, forKey: "weather")
        let weatherGroup = WeatherGroup.allCases.filter { all in
            return all.rawValue == weather.name
        }.first
        DispatchQueue.main.async { [self] in
            willLoadWeather(location: nil)
            forecastImage.image =  weatherGroup?.image
            bottomView.backgroundColor = weatherGroup?.color
           
            tempLabel.text = round(weather.temp - 272.15).toCelsius()
            descriptionLabel.text = weather.desc
            minLabelValue.text =  round(weather.min - 272.15).toCelsius()
            currentLabelValue.text = round(weather.temp - 272.15).toCelsius()
            maxLabelValue.text = round(weather.temp - 272.15).toCelsius()
            minLabel.text="min"
            currentLabel.text="current"
            maxLabel.text="max"
            lastUpdatedLabel.text = "\(weather.place!), Last Update :"+dateFormatter.string(from: weather.lastupdate!)
            favButton.isHidden = false
            viewButton.isHidden = false
            cityName = weather.place!
        }
    }
    func willUpdate(with weatherResponse: WeatherResponse) {
      
        if let weatherGroup = weatherResponse.weather.first?.main as? String {
            UserDefaults.standard.set(weatherGroup, forKey: "weather")
            let weather = WeatherGroup.allCases.filter{ all in
                all.rawValue == weatherGroup
            }.first
            DispatchQueue.main.async { [self] in
                forecastImage.image = weather?.image
                bottomView.backgroundColor = weather?.color
                tempLabel.text = round(weatherResponse.main.temp - 272.15).toCelsius()
                descriptionLabel.text =  weatherResponse.weather.first?.description.capitalized
                minLabelValue.text =  round(weatherResponse.main.tempMin - 272.15).toCelsius()
                currentLabelValue.text = round(weatherResponse.main.temp - 272.15).toCelsius()
                maxLabelValue.text = round(weatherResponse.main.tempMax - 272.15).toCelsius()
                minLabel.text="min"
                currentLabel.text="current"
                maxLabel.text="max"
                lastUpdatedLabel.text = "\(weatherResponse.name), Last Update :"+dateFormatter.string(from: Date())
                favButton.isHidden = false
                viewButton.isHidden = false
                cityName = weatherResponse.name
            }
        }
    }
}
