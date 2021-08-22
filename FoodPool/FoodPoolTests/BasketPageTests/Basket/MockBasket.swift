//
//  MockBasket.swift
//  FoodPoolTests
//
//  Created by Ayşe Nur Bakırcı on 22.08.2021.
//

import Foundation
@testable import FoodPool

class MockBasketViewModel: BasketViewModelProtocol {
    
    var isLoaded = false
    var createdMeal = false
    
    public init() {}
    
    weak var delegate: BasketViewModelDelegate?
    
    func load() {
        self.isLoaded = true
    }
    
    func meal(indexPath: Int) -> RestaurantMenuModel? {
        self.createdMeal = true
        return nil
    }
    
    var numberOfItemsMeal: Int = 0
    
    var totalPrice: String = ""

}

class MockBasketViewController: BasketViewModelDelegate {
    
    var basketViewModel: BasketViewModelProtocol! {
        didSet {
            basketViewModel.delegate = self
        }
    }
    
    var dataIsReloaded = false
    
    func reloadData() {
        self.dataIsReloaded = true
    }

}
