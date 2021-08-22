//
//  RestaurantMenuListViewController.swift
//  FoodPool
//
//  Created by Ayşe Nur Bakırcı on 11.08.2021.
//

import UIKit

class RestaurantMenuListViewController: UICollectionViewController{
    
    
    static let sectionHeaderReuseIdentifier = "sectionHeaderID"
    var restaurantInfo: RestaurantModel? = nil
    
    init() {
        let layout = RestaurantMenuListViewController.createLayout()
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = restaurantInfo?.restaurantName ?? "Restaurant Name"
        collectionViewConfiguration()
    }
    
    func collectionViewConfiguration() {
        
        collectionView.backgroundColor = .mainBackgroundGray
        collectionView.register(RestaurantCell.self, forCellWithReuseIdentifier: RestaurantCell.reuseIdentifier)
        collectionView.register(MealRectangleCell.self, forCellWithReuseIdentifier: MealRectangleCell.reuseIdentifier)
        collectionView.register(SectionHeaderCell.self, forSupplementaryViewOfKind: RestaurantListViewController.sectionHeaderReuseIdentifier, withReuseIdentifier: SectionHeaderCell.reuseIdentifier)
        
    }
}

extension RestaurantMenuListViewController {
    
    static func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (sectionNumber, env) -> NSCollectionLayoutSection? in
            
            if sectionNumber == 0 {
                
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                item.contentInsets.trailing = 16
                item.contentInsets.leading = 16
                item.contentInsets.top = 16
                item.contentInsets.bottom = 16
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(130)), subitems: [item])
                
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .paging
                
                return section
                
            } else if sectionNumber == 1 {
                
                let item = NSCollectionLayoutItem.init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                item.contentInsets.trailing = 16
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(0.4), heightDimension: .absolute(180)), subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                section.contentInsets.leading = 16
                section.contentInsets.bottom = 16
                section.boundarySupplementaryItems = [
                    .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50)), elementKind: sectionHeaderReuseIdentifier, alignment: .topLeading)
                ]
                
                return section
                
            } else {
                
                let item = NSCollectionLayoutItem.init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                item.contentInsets.trailing = 16
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(0.4), heightDimension: .absolute(180)), subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                section.contentInsets.leading = 16
                section.contentInsets.bottom = 16
                section.boundarySupplementaryItems = [
                    .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50)), elementKind: sectionHeaderReuseIdentifier, alignment: .topLeading)
                ]
                return section
                
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if indexPath.section == 1 {
            
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeaderCell.reuseIdentifier, for: indexPath) as! SectionHeaderCell
            header.configuration(with: "Meal")
            
            return header
            
        } else {
            
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeaderCell.reuseIdentifier, for: indexPath) as! SectionHeaderCell
            header.configuration(with: "Drink")
            
            return header
            
        }
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return restaurantInfo?.restaurantMeals.count ?? 0
        } else {
            return restaurantInfo?.restaurantDrinks.count ?? 0
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RestaurantCell.reuseIdentifier, for: indexPath) as! RestaurantCell
            cell.layer.cornerRadius = 16
            cell.layer.masksToBounds = true
            
            let title = TitleAndSubtitleUIModel(title: restaurantInfo?.restaurantName ?? "Restaurant Name", subtitle: restaurantInfo?.restaurantCuisineType ?? "Kitchen")
            
            cell.configuration(with: IconAndTitleCardUIView(imageName: restaurantInfo?.restaurantImagePath ?? "", titleAndSubtitle: title))
            
            return cell
            
        } else if indexPath.section == 1 {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MealRectangleCell.reuseIdentifier, for: indexPath) as! MealRectangleCell
            cell.layer.cornerRadius = 16
            cell.layer.masksToBounds = true
            if let meal = restaurantInfo?.restaurantMeals[safe: indexPath.row] {
                cell.configuration(with: meal)
                cell.model = meal
                cell.delegate = self
            }
            return cell
            
        } else {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MealRectangleCell.reuseIdentifier, for: indexPath) as! MealRectangleCell
            cell.layer.cornerRadius = 16
            cell.layer.masksToBounds = true
            if let meal = restaurantInfo?.restaurantDrinks[safe: indexPath.row] {
                cell.configuration(with: meal)
                cell.model = meal
                cell.delegate = self
            }
            return cell
        }
    }
}

extension RestaurantMenuListViewController: MealRectangleCellProtocol {
    
    func addToBasket(model: RestaurantMenuModel) {
        showToast(message: "\(model.name) is added to basket")
        BasketModel.basketList.menuModel.append(model)
        print(BasketModel.basketList.menuModel)
    }
    
}
