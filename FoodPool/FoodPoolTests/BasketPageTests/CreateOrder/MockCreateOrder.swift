//
//  MockCreateOrder.swift
//  FoodPoolTests
//
//  Created by Ayşe Nur Bakırcı on 22.08.2021.
//

import Foundation
@testable import FoodPool

class MockCreateOrderViewModel: SelectOrderMethodsViewModelProtocol {
    
    public init() {}
    weak var delegate: SelectOrderMethodsViewModelDelegate?
    
    var isCreated = false
    
    func create() {
        self.isCreated = true
    }
}

class MockCreateOrderViewController: SelectOrderMethodsViewModelDelegate {
    
    var createOrderViewModel: SelectOrderMethodsViewModelProtocol! {
        didSet {
            createOrderViewModel.delegate = self
        }
    }
    
    var gettingData = false
    var orderIsSuccess = false
    var orderIsFailure = false
    
    func getData() -> CreateOrderData? {
        self.gettingData = true
        return nil
    }
    
    func successOrder() {
        self.orderIsSuccess = true
    }
    
    func failureOrder() {
        self.orderIsFailure = true
    }
}
