//
//  OrderViewController.swift
//  FoodPool
//
//  Created by Ayşe Nur Bakırcı on 11.08.2021.
//

import UIKit

class OrderViewController: UICollectionViewController, LoadingShowable {

    static let sectionHeaderReuseIdentifier = "sectionHeaderID"
    
    var orderViewModel: OrderViewModelProtocol! {
        didSet {
            orderViewModel.delegate = self
        }
    }
    
    init() {
        super.init(collectionViewLayout: OrderViewController.createLayout())
        collectionView.backgroundColor = .mainBackgroundGray
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Order"

        collectionView.register(OrderCell.self, forCellWithReuseIdentifier: OrderCell.reuseIdentifier)
        collectionView.register(SectionHeaderCell.self, forSupplementaryViewOfKind: OrderViewController.sectionHeaderReuseIdentifier, withReuseIdentifier: SectionHeaderCell.reuseIdentifier)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        orderViewModel.load()
    }
    
    static func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (sectionNumber, env) -> NSCollectionLayoutSection? in
            
            let item = NSCollectionLayoutItem.init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
            item.contentInsets.top = 6
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(84)), subitems: [item])
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets.leading = 16
            section.contentInsets.trailing = 16
            
            section.boundarySupplementaryItems = [
                .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50)), elementKind: sectionHeaderReuseIdentifier, alignment: .topLeading)
            ]
            
            return section
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeaderCell.reuseIdentifier, for: indexPath) as! SectionHeaderCell
        
        if indexPath.section == 0 && orderViewModel.numberOfItemsCurrentOrders > 0{
            header.configuration(with: "Current Orders")
            
        } else if  indexPath.section == 1 && orderViewModel.numberOfItemsPreviosOrders > 0{
            header.configuration(with: "Previous Orders")
        }
        
        return header

    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return orderViewModel.numberOfItemsCurrentOrders
        } else {
            return orderViewModel.numberOfItemsPreviosOrders
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OrderCell.reuseIdentifier, for: indexPath) as! OrderCell
        
        cell.layer.cornerRadius = 20
        cell.layer.masksToBounds = true
        cell.backgroundColor = .white
        
        if indexPath.section == 0 {
            
            let model = orderViewModel.currentOrder(indexPath: indexPath.row)
            cell.configuration(with: TitleAndSubtitleUIModel(title: model?.restaurantName ?? "", subtitle: orderViewModel.getMealList(order: model!)), price: model?.price ?? "0.0")
            
        } else {
            
            let model = orderViewModel.previousOrder(indexPath: indexPath.row)
            cell.configuration(with: TitleAndSubtitleUIModel(title: model?.restaurantName ?? "", subtitle: orderViewModel.getMealList(order: model!)), price: model?.price ?? "0.0")
        }
        
        return cell
        
    }
}

extension OrderViewController: OrderViewModelDelegate {
    
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
