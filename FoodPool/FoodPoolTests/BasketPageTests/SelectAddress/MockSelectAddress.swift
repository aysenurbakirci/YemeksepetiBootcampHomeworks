//
//  MockSelectAddress.swift
//  FoodPoolTests
//
//  Created by Ayşe Nur Bakırcı on 22.08.2021.
//

import Foundation
@testable import FoodPool

class MockSelectAddressViewModel: SelectAddressViewModelProtocol {
    
    public init() {}
    weak var delegate: SelectAddressViewModelDelegate?
    
    var isLoaded = false
    var createdAddress = false
    
    func load() {
        self.isLoaded = true
    }
    
    func address(indexPath: Int) -> UserAddressesModel? {
        self.createdAddress = true
        return nil
    }
    var numberOfItemsAddressses: Int = 0
    
}

class MockSelectAddressViewController: SelectAddressViewModelDelegate {
    
    var selectAddressViewModel: SelectAddressViewModelProtocol! {
        didSet {
            selectAddressViewModel.delegate = self
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
