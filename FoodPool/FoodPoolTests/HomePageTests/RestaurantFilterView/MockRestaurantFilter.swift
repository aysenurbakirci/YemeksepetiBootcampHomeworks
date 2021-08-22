//
//  MockRestaurantFilter.swift
//  FoodPoolTests
//
//  Created by Ayşe Nur Bakırcı on 21.08.2021.
//

import Foundation
@testable import FoodPool

class MockRestaurantFilterViewModel: RestaurantFilterViewModelProtocol {
    
    public init() {}
    
    weak var delegate: RestaurantFilterViewModelDelegate?
    
        var isLoaded = false
        var createdRestaurant = false
    
    
    func load() {
        self.isLoaded = true
    }
    
    func restaurant(indexPath: Int) -> RestaurantModel? {
        self.createdRestaurant = true
        return nil
    }
    
    var numberOfItemsRestaurant: Int = 1
}

class MockRestaurantFilterViewController: RestaurantFilterViewModelDelegate {
    
    var restaurantFilterViewModel: RestaurantFilterViewModelProtocol! {
        didSet {
            restaurantFilterViewModel.delegate = self
        }
    }
    
    var isInvokedShowLoading = false
    var isInvokedHideLoading = false
    var dataIsReloaded = false
    var getFilterCategory = false
    
    func showLoadingView() {
        self.isInvokedShowLoading = true
    }
    
    func hideLoadingView() {
        self.isInvokedHideLoading = true
    }
    
    func reloadData() {
        self.dataIsReloaded = true
    }
    
    func filterCategory() -> String {
        self.getFilterCategory = true
        return ""
    }
}
