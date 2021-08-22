//
//  RestaurantListViewController.swift
//  FoodPool
//
//  Created by Ayşe Nur Bakırcı on 11.08.2021.
//

import UIKit
import FontAwesome

class RestaurantListViewController: UICollectionViewController, LoadingShowable{
    
    static let sectionHeaderReuseIdentifier = "sectionHeaderID"
    
    var restaurantListViewModel: RestaurantListViewModelProtocol! {
        didSet {
            restaurantListViewModel.delegate = self
        }
    }
    
    init() {
        let layout = RestaurantListViewController.createLayout()
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Home"
        navigationItem.setRightBarButton(UIBarButtonItem.init(image: UIImage.fontAwesomeIcon(name: .userCircle, style: .solid, textColor: .mainOrange, size: .init(width: 38, height: 35)), style: .plain, target: self, action: #selector(didTapUserButton)), animated: true)
        navigationItem.rightBarButtonItem?.tintColor = .mainOrange
        collectionViewConfiguration()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        restaurantListViewModel.load()

    }
    
    @objc private func didTapUserButton() {
        
        let controller = ProfileViewController()
        let viewModel = ProfileViewModel(service: FoodPoolServices())
        controller.profileViewModel = viewModel
        navigationController?.pushViewController(controller, animated: true)
        
    }
    
    private func collectionViewConfiguration() {
        
        collectionView.backgroundColor = .mainBackgroundGray
        
        collectionView.register(DiscountCell.self, forCellWithReuseIdentifier: DiscountCell.reuseIdentifier)
        collectionView.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.reuseIdentifier)
        collectionView.register(RestaurantRectangleCell.self, forCellWithReuseIdentifier: RestaurantRectangleCell.reuseIdentifier)
        collectionView.register(SectionHeaderCell.self, forSupplementaryViewOfKind: RestaurantListViewController.sectionHeaderReuseIdentifier, withReuseIdentifier: SectionHeaderCell.reuseIdentifier)
    }
}

extension RestaurantListViewController {
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if indexPath.section == 1 {
            
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeaderCell.reuseIdentifier, for: indexPath) as! SectionHeaderCell
            header.configuration(with: "Categories")
            return header
            
        } else {
            
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeaderCell.reuseIdentifier, for: indexPath) as! SectionHeaderCell
            header.configuration(with: "Restaurants")
            return header
            
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let restaurantState = restaurantListViewModel.restaurant(indexPath: indexPath.row)?.restaurantIsOpen ?? true
        if indexPath.section == 1 {
            
            let controller = RestaurantFilterViewController()
            let viewModel = RestaurantFilterViewModel(service: FoodPoolServices())
            controller.restaurantFilterViewModel = viewModel
            controller.selectedCategory = restaurantListViewModel.cuisine(indexPath: indexPath.row)?.cuisine ?? ""
            navigationController?.pushViewController(controller, animated: true)
            
        } else if indexPath.section == 2 {
            if restaurantState {
                let controller = RestaurantMenuListViewController()
                let model = restaurantListViewModel.restaurant(indexPath: indexPath.row)
                controller.restaurantInfo = model
                BasketModel.basketList.restaurant = model?.restaurantName ?? "Restaurant Name"
                navigationController?.pushViewController(controller, animated: true)
            } else {
                showAlert(title: "Closed!", message: "This restaurant is closed now.")
            }
        }
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return restaurantListViewModel.numberOfItemsDiscount
        } else if section == 1 {
            return restaurantListViewModel.numberOfItemsCuisine
        } else {
            return restaurantListViewModel.numberOfItemsRestaurant
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0 {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DiscountCell.reuseIdentifier, for: indexPath) as! DiscountCell
            if let discountImage = restaurantListViewModel.discount(indexPath: indexPath.row) {
                cell.configuration(with: discountImage)
            }
            return cell
            
        } else if indexPath.section == 1 {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.reuseIdentifier, for: indexPath) as! CategoryCell
            cell.layer.cornerRadius = 14
            cell.layer.masksToBounds = true
            
            if let cuisine = restaurantListViewModel.cuisine(indexPath: indexPath.row) {
                cell.configuration(with: cuisine)
            }
            return cell
            
        } else {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RestaurantRectangleCell.reuseIdentifier, for: indexPath) as! RestaurantRectangleCell
            cell.layer.cornerRadius = 16
            cell.layer.masksToBounds = true
            
            if let restaurant = restaurantListViewModel.restaurant(indexPath: indexPath.row) {
                cell.configuration(with: restaurant)
            }
            return cell
        }
    }
    
    static func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (sectionNumber, env) -> NSCollectionLayoutSection? in
            
            if sectionNumber == 0 {
                
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
    
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(200)), subitems: [item])
                
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .paging
                
                return section
                
            } else if sectionNumber == 1 {
                
                let item = NSCollectionLayoutItem.init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                item.contentInsets.trailing = 16
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(0.3), heightDimension: .absolute(140)), subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                section.contentInsets.leading = 16
                section.boundarySupplementaryItems = [
                    .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50)), elementKind: sectionHeaderReuseIdentifier, alignment: .topLeading)
                ]
                
                return section
                
            } else {
                
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(0.5), heightDimension: .absolute(260)))
                item.contentInsets.bottom = 16
                item.contentInsets.trailing = 16
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(1000)), subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets.leading = 16
                section.contentInsets.bottom = 8
                section.boundarySupplementaryItems = [
                    .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50)), elementKind: sectionHeaderReuseIdentifier, alignment: .topLeading)
                ]
                
                return section
            }
        }
    }
    
}


extension RestaurantListViewController: RestaurantListViewModelDelegate {
    
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
