//
//  ExploreView.swift
//  WeatherApp
//
//  Created by FGX on 2022/07/02.
//

import UIKit
class ExploreView: UICollectionViewController {
    var presenter: ViewToPresenterExploreProtocol?
    var place: Place!
    var fqResponse:[FQResults] = [FQResults]()
    let padding:CGFloat = 20
    let sectionInsets = UIEdgeInsets(
          top: 10.0,
          left: 10.0,
          bottom: 10.0,
          right: 10.0)
    let itemsPerRow: CGFloat = 1

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        presenter?.viewDidLoad(place)
        title = "Exploring \(place.name!)"
        
    }
    func setupView(){
        let weather = UserDefaults.standard.string(forKey: "weather")
        let themeColor =  WeatherGroup.allCases.filter { weatherGroup in
                   return  weatherGroup.rawValue == weather
               }.first?.color
           
        guard let collectionView = collectionView,
        let layout = collectionViewLayout as? UICollectionViewFlowLayout else {
                   print("KO")
                   return
        }
        collectionView.backgroundColor = themeColor
        // Register cell classes
        collectionView.register(ExploreCell.self, forCellWithReuseIdentifier: ExploreCell.reuseIdentifier)
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
    }

    // MARK: UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fqResponse.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ExploreCell.reuseIdentifier, for: indexPath) as? ExploreCell {
            let response = fqResponse[indexPath.row]
            cell.nameLabel.text = response.name
            cell.categoriesNameLabel.text = formatCategory(response.categories)
            return cell
        }
        return UICollectionViewCell()
    }
    func formatCategory(_ categories:[FQCategory]) -> String{
        var categoryName = ""
        categories.forEach{ category in
            categoryName.append(contentsOf: category.name + ",")
        }
        return categoryName.trimmingCharacters(in: [","])
    }
}

extension ExploreView : PresenterToViewExploreProtocol{
    func loadData(fourSquareResponse: [FQResults]) {
        DispatchQueue.main.async {
            self.fqResponse = fourSquareResponse
            self.collectionView.reloadData()
        }
    }
}
extension ExploreView : UICollectionViewDelegateFlowLayout{
      func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
      ) -> CGSize {
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = collectionView.bounds.size.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        return CGSize(width: widthPerItem, height: 60)
      }
      func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
      ) -> UIEdgeInsets {
        return sectionInsets
      }
      func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
      ) -> CGFloat {
        return sectionInsets.left
      }
}
class ExploreCell: UICollectionViewCell {
    static var reuseIdentifier:String = "ExploreCell"
    var nameLabel:UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    var categoriesNameLabel:UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    override func layoutSublayers(of layer: CALayer) {
        contentView.backgroundColor = .clear
    }
    
    override init(frame:CGRect){
        super.init(frame:frame)
        addSubViews()
        addConstraints()
    }

    func addSubViews(){
        contentView.addSubview(nameLabel)
        contentView.addSubview(categoriesNameLabel)
    }
    func addConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo:
                                                contentView.topAnchor, constant: 3),
            nameLabel.leadingAnchor.constraint(equalTo:
                                                contentView.leadingAnchor, constant: 20),
            categoriesNameLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 3),
            categoriesNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            categoriesNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
        ])
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
