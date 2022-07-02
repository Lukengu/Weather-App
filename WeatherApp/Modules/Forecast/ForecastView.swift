//
//  ForecastView.swift
//  WeatherApp
//
//  Created by FGX on 2022/06/30.
//

import UIKit
import CoreLocation
class ForecastView: UITableViewController {
    var presenter: ViewToPresenterForecastProtocol?
    var currrentLocation: CLLocation?
    var forecastList: [ParsedForescat] = [ParsedForescat]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        
    }
    func setUpTableView(){
        tableView.backgroundView = .none
        tableView.backgroundColor = .clear
        tableView.separatorColor = .clear
        tableView.bounces = false
        tableView.isScrollEnabled = false
        tableView.register(ForecastCell.self, forCellReuseIdentifier: ForecastCell.reuseIdentifier)
        tableView.rowHeight = UITableView.automaticDimension
    }
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecastList.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let  cell = tableView.dequeueReusableCell(withIdentifier:ForecastCell.reuseIdentifier, for: indexPath) as? ForecastCell {
        let forecast = forecastList[indexPath.row]
        cell.dayLabel.text = forecast.day
        cell.icon.image  = UIImage(named:  forecast.name.lowercased())
        cell.tempLabel.text =  (forecast.temp - 272.15).toCelsius()
            return cell
        }
        return UITableViewCell()
    }
    
    func populateTable(with location:CLLocation?){
        presenter?.viewDidLoad(with: location)
    }
}
extension ForecastView: PresenterToViewForecastProtocol {
    func reloadTable(forecastResponse: [ParsedForescat]) {
        DispatchQueue.main.async {
            self.forecastList = forecastResponse
            self.tableView.reloadData()
        }
    }
}
class ForecastCell : UITableViewCell {
    static var reuseIdentifier:String = "ForecastCell"
    var dayLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 17)
        return label
    }()
    var icon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    var tempLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 17)
        return label
    }()
    override func layoutSublayers(of layer: CALayer) {
        contentView.backgroundColor = .clear
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style:style, reuseIdentifier: reuseIdentifier)
        addSubViews()
        addConstraints()
    }
    func addSubViews() {
        contentView.addSubview(dayLabel)
        contentView.addSubview(icon)
        contentView.addSubview(tempLabel)
    }
    func addConstraints() {
        NSLayoutConstraint.activate([
            dayLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            dayLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            icon.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            icon.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            tempLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            tempLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            icon.widthAnchor.constraint(equalToConstant: 32),
            icon.heightAnchor.constraint(equalToConstant: 32)
        ])
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
