//
//  FavouriteView.swift
//  WeatherApp
//
//  Created by FGX on 2022/07/01.
//

import UIKit

class FavouriteView: UITableViewController {
    var presenter: ViewToPresenterFavouriteProtocol?
    var favourites:[Place] = [Place]()
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationController()
        setUpTableView()
        presenter?.viewDidLoad()
    }
    
    func setUpTableView(){
    
        tableView.separatorColor = .white
        tableView.separatorStyle = .singleLine
        tableView.separatorInset = UIEdgeInsets(top: 1, left: 20, bottom: 1, right: 20)
        tableView.bounces = false
        tableView.isScrollEnabled = true
        tableView.register(FavouriteCell.self, forCellReuseIdentifier: FavouriteCell.reuseIdentifier)
    }
    func setUpNavigationController(){
        let weather = UserDefaults.standard.string(forKey: "weather")
        let themeColor =  WeatherGroup.allCases.filter { weatherGroup in
            return  weatherGroup.rawValue == weather
        }.first?.color
        
        tableView.backgroundColor = themeColor
        navigationController?.navigationBar.backgroundColor
        =  themeColor
        view.backgroundColor = themeColor
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationController?.navigationBar.tintColor = .white
        title = "View Favourites"
        let viewBtn = UIButton(type: .custom)
        viewBtn.addAction(UIAction() { _ in
            self.presenter?.openPlacesInMap()
        }, for: .touchUpInside)
        
        viewBtn.setImage(UIImage(systemName:  "eye.fill"), for: .normal)
        viewBtn.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        let rightButton = UIBarButtonItem(customView: viewBtn)
        self.navigationItem.rightBarButtonItem = rightButton
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favourites.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: FavouriteCell.reuseIdentifier, for: indexPath)
            as? FavouriteCell {
            let place = favourites[indexPath.row]
            cell.nameLabel.text = place.name
            cell.exploreButton.addAction(UIAction(){ _ in
                self.presenter?.explore(place: place)
            }, for: .touchUpInside)
            return cell
        } else {
            return UITableViewCell()
        }
    }
}

extension FavouriteView : PresenterToViewFavouriteProtocol {
    func displayPlaces(places: [Place]) {
        DispatchQueue.main.async {
            self.favourites = places
            self.tableView.reloadData()
        }
    }
}

class FavouriteCell: UITableViewCell {
    static var reuseIdentifier:String = "ForecastCell"
    var nameLabel:UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var exploreButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.textColor = .white
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.setTitle("Explore", for: .normal)
        button.backgroundColor = .clear
        button.layer.cornerRadius = 10
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    override func layoutSublayers(of layer: CALayer) {
        contentView.backgroundColor = .clear
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style:style, reuseIdentifier: reuseIdentifier)
        addSubViews()
        addConstraints()
    }
    func addSubViews(){
        contentView.addSubview(nameLabel)
        contentView.addSubview(exploreButton)
    }
    func addConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.centerYAnchor.constraint(equalTo:
                                                contentView.centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo:
                                                contentView.leadingAnchor, constant: 20),
            exploreButton.centerYAnchor.constraint(equalTo:
                                                contentView.centerYAnchor),
            exploreButton.trailingAnchor.constraint(equalTo:
                                                contentView.trailingAnchor, constant: -20),
            exploreButton.heightAnchor.constraint(equalToConstant: 32),
            exploreButton.widthAnchor.constraint(equalToConstant: 120),
            nameLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
