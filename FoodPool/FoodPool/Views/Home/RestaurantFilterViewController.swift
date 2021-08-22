//
//  RestaurantFilterViewController.swift
//  FoodPool
//
//  Created by Ayşe Nur Bakırcı on 21.08.2021.
//

import UIKit

class RestaurantFilterViewController: UICollectionViewController, LoadingShowable {
    
    init() {
        let layout = RestaurantFilterViewController.createLayout()
        super.init(collectionViewLayout: layout)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var selectedCategory: String!
    
    var restaurantFilterViewModel: RestaurantFilterViewModelProtocol! {
        didSet {
            restaurantFilterViewModel.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = selectedCategory
        collectionViewConfiguration()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        restaurantFilterViewModel.load()
    }
    
    func collectionViewConfiguration() {
        collectionView.backgroundColor = .mainBackgroundGray
        collectionView.register(RestaurantCell.self, forCellWithReuseIdentifier: RestaurantCell.reuseIdentifier)
    }
}

extension RestaurantFilterViewController {
    
    static func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (sectionNumber, env) -> NSCollectionLayoutSection? in
            
            let item = NSCollectionLayoutItem.init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
            item.contentInsets.trailing = 16
            item.contentInsets.leading = 16
            item.contentInsets.top = 4
            item.contentInsets.bottom = 4
            
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(90)), subitems: [item])
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets.top = 12
            return section
        }
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if restaurantFilterViewModel.numberOfItemsRestaurant == 0 {
            collectionView.setEmptyMessage("Restaurant not found for this category.")
        } else {
            collectionView.restore()
        }
        
        return restaurantFilterViewModel.numberOfItemsRestaurant
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RestaurantCell.reuseIdentifier, for: indexPath) as! RestaurantCell
        
        let model = restaurantFilterViewModel.restaurant(indexPath: indexPath.row)
        cell.configuration(with: IconAndTitleCardUIView(imageName: model?.restaurantImagePath ?? "", titleAndSubtitle: TitleAndSubtitleUIModel(title: model?.restaurantName ?? "", subtitle: model?.restaurantAddress)))
        
        cell.layer.cornerRadius = 20
        cell.clipsToBounds = true
    
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let restaurantState = restaurantFilterViewModel.restaurant(indexPath: indexPath.row)?.restaurantIsOpen ?? true
        if restaurantState {
            let controller = RestaurantMenuListViewController()
            let model = restaurantFilterViewModel.restaurant(indexPath: indexPath.row)
            controller.restaurantInfo = model
            BasketModel.basketList.restaurant = model?.restaurantName ?? "Restaurant Name"
            navigationController?.pushViewController(controller, animated: true)
        } else {
            showAlert(title: "Closed!", message: "This restaurant is closed now.")
        }
    }
}

extension RestaurantFilterViewController: RestaurantFilterViewModelDelegate {
    
    func filterCategory() -> String {
        return selectedCategory
    }
    
    func showLoadingView() {
        showLoading()
    }
    
    func hideLoadingView() {
        hideLoading()
    }
    
    func reloadData() {
        collectionView.reloadData()
    }
}
