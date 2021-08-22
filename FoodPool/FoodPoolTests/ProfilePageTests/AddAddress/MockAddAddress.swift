//
//  MockAddAddress.swift
//  FoodPoolTests
//
//  Created by Ayşe Nur Bakırcı on 22.08.2021.
//

import Foundation
@testable import FoodPool

class MockAddAddressViewModel: AddAddressViewModelProtocol{
    
    public init() {}
    weak var delegate: AddAddressViewModelDelegate?
    
    var createdNewAddress = false
    
    func addNewAddress() {
        self.createdNewAddress = true
    }

}

class MockAddAddressViewController: AddAddressViewModelDelegate {
    
    var addAddressViewModel: AddAddressViewModelProtocol! {
        didSet {
            addAddressViewModel.delegate = self
        }
    }
    
    var gettingData = false
    var isSucceed = false
    var isFailed = false
    
    func getData() -> AddAddressData? {
        self.gettingData = true
        return nil
    }
    
    func successAddAddress() {
        self.isSucceed = true
    }
    
    func failureAddAddress(err: Error?) {
        self.isFailed = true
    }

}
