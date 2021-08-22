//
//  MockProfile.swift
//  FoodPoolTests
//
//  Created by Ayşe Nur Bakırcı on 22.08.2021.
//

import Foundation
@testable import FoodPool

class MockProfileViewModel: ProfileViewModelProtocol{
    
    public init() {}
    weak var delegate: ProfileViewModelDelegate?
    
    var isLoaded = false
    var createdAddress = false
    
    func load() {
        self.isLoaded = true
    }
    
    func address(indexPath: Int) -> UserAddressesModel? {
        self.createdAddress = true
        return nil
    }
    
    var userInfo: UserModel?
    
    var numberOfItemsAddress: Int = 0
}

class MockProfileViewController: ProfileViewModelDelegate {

    var profileViewModel: ProfileViewModelProtocol! {
        didSet {
            profileViewModel.delegate = self
        }
    }

    var isInvokedShowLoading = false
    var isInvokedHideLoading = false
    var dataIsReloaded = false

    func showLoadingView() {
        self.isInvokedShowLoading = true
    }

    func hideLoadingView() {
        self.isInvokedHideLoading = true
    }

    func reloadData() {
        self.dataIsReloaded = true
    }
}
