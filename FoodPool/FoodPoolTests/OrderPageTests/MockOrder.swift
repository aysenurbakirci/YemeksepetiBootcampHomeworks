//
//  MockOrder.swift
//  FoodPoolTests
//
//  Created by Ayşe Nur Bakırcı on 22.08.2021.
//

import Foundation
@testable import FoodPool

class MockOrderViewModel: OrderViewModelProtocol {
    
    public init() {}
    weak var delegate: OrderViewModelDelegate?
    
    var isLoaded = false
    var createdPreviousOrder = false
    var createdCurrentOrder = false
    var gettingMealList = false
    
    func load() {
        self.isLoaded = true
    }
    
    func previousOrder(indexPath: Int) -> OrderModel? {
        self.createdPreviousOrder = true
        return nil
    }
    
    func currentOrder(indexPath: Int) -> OrderModel? {
        self.createdCurrentOrder = true
        return nil
    }
    
    func getMealList(order: OrderModel) -> String {
        self.gettingMealList = true
        return ""
    }
    
    var numberOfItemsPreviosOrders: Int = 0
    
    var numberOfItemsCurrentOrders: Int = 0
    
}

class MockOrderViewController: OrderViewModelDelegate {
    
    var orderViewModel: OrderViewModelProtocol! {
        didSet {
            orderViewModel.delegate = self
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
