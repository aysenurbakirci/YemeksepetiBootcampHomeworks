//
//  SelectAddressViewController.swift
//  FoodPool
//
//  Created by Ayşe Nur Bakırcı on 20.08.2021.
//

import UIKit

class SelectAddressViewController: UICollectionViewController, LoadingShowable {

    var notificationData: [String: Any] = [:]
    
    init() {
        let layout = SelectAddressViewController.createLayout()
        super.init(collectionViewLayout: layout)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var selectAddressViewModel: SelectAddressViewModelProtocol! {
        didSet {
            selectAddressViewModel.delegate = self
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Addresses"
        collectionViewConfiguration()
        selectAddressViewModel.load()
        
    }
    
    func collectionViewConfiguration() {
        
        collectionView.backgroundColor = .mainBackgroundGray
        collectionView.register(MethodCell.self, forCellWithReuseIdentifier: MethodCell.reuseIdentifier)
    }
}

extension SelectAddressViewController {
    
    static func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (sectionNumber, env) -> NSCollectionLayoutSection? in
            
            let item = NSCollectionLayoutItem.init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))

            item.contentInsets.bottom = 4

            let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(90)), subitems: [item])
            let section = NSCollectionLayoutSection(group: group)
            
            section.contentInsets.top = 8
            section.contentInsets.leading = 8
            section.contentInsets.trailing = 8
            
            return section
        }
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selectAddressViewModel.numberOfItemsAddressses
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MethodCell.reuseIdentifier, for: indexPath) as! MethodCell
        
        let model = selectAddressViewModel.address(indexPath: indexPath.row)
        
        cell.configuration(with: TitleAndSubtitleUIModel(title: model?.addressTitle ?? "Title", subtitle: model?.address ?? "Description"))
        
        cell.backgroundColor = .white
        cell.layer.cornerRadius = 14
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        notificationData["address"] = selectAddressViewModel.address(indexPath: indexPath.row)
        NotificationCenter.default.post(name: .sendDataNotification, object: nil, userInfo: notificationData)
        navigationController?.popViewController(animated: true)
        
    }
}

extension SelectAddressViewController: SelectAddressViewModelDelegate {
    
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
