//
//  ProfileViewController.swift
//  FoodPool
//
//  Created by Ayşe Nur Bakırcı on 11.08.2021.
//

import UIKit

class ProfileViewController: UIViewController, LoadingShowable {

    var profileViewModel: ProfileViewModelProtocol! {
        didSet {
            profileViewModel.delegate = self
        }
    }
    
    private let userInformation = IconAndTitleUserInfoCardView()
    
    private let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    private lazy var collectionView: UICollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Profile"
        
        collectionViewConfiguration()
        configuration()
    }
    
    private func configuration() {
        view.addSubview(userInformation)
        userInformation.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: collectionView.topAnchor, trailing: view.trailingAnchor, padding: .init(top: 0.0, left: 0.0, bottom: 10.0, right: 0.0))
        userInformation.anchorSize(size: .init(width: self.view.frame.size.width, height: 180))
        
        navigationItem.setRightBarButton(UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAddAddressButton)), animated: true)
        navigationItem.rightBarButtonItem?.tintColor = .mainOrange
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        profileViewModel.load()
    }
    
    @objc private func didTapAddAddressButton() {
        let controller = AddAddressViewController()
        let viewModel = AddAddressViewModel(service: FoodPoolServices())
        controller.addAddressViewModel = viewModel
        navigationController?.pushViewController(controller, animated: true)
    }
}

extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionViewConfiguration() {
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .mainBackgroundGray
        collectionView.register(MethodCell.self, forCellWithReuseIdentifier: MethodCell.reuseIdentifier)
        view.addSubview(collectionView)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: view.frame.width, height: view.frame.width * 0.4)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return profileViewModel.numberOfItemsAddress
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MethodCell.reuseIdentifier, for: indexPath) as! MethodCell
        
        let model = profileViewModel.address(indexPath: indexPath.row)
        cell.configuration(with: TitleAndSubtitleUIModel(title: model?.addressTitle ?? "Title", subtitle: model?.address ?? "Description"))
        cell.backgroundColor = .white
        return cell
    }
    
}

extension ProfileViewController: ProfileViewModelDelegate {
    func showLoadingView() {
        showLoading()
    }
    
    func hideLoadingView() {
        hideLoading()
    }
    
    func reloadData() {
        collectionView.reloadData()
        userInformation.configuration(with: IconAndTitleUserInfoCardUIView(title: profileViewModel.userInfo?.userName ?? "User Name", subtitle: profileViewModel.userInfo?.userEmail ?? "Mail", subtitleTwo: profileViewModel.userInfo?.userPhone ?? "Phone"))
    }
}
