//
//  MockRestaurantList.swift
//  FoodPoolTests
//
//  Created by Ayşe Nur Bakırcı on 21.08.2021.
//

import Foundation
@testable import FoodPool

class MockRestaurantListViewModel: RestaurantListViewModelProtocol {
    
    public init() {}
    
    weak var delegate: RestaurantListViewModelDelegate?
    
    var isLoaded = false
    var createdRestaurant = false
    var createdCuisine = false
    var createdDiscount = false
    
    func load() {
        self.isLoaded = true
    }
    
    func restaurant(indexPath: Int) -> RestaurantModel? {
        self.createdRestaurant = true
        return nil
    }
    
    func cuisine(indexPath: Int) -> CuisineModel? {
        self.createdCuisine = true
        return nil
    }
    
    func discount(indexPath: Int) -> String? {
        self.createdDiscount = true
        return nil
    }
    
    var numberOfItemsRestaurant: Int = 1
    
    var numberOfItemsCuisine: Int = 1
    
    var numberOfItemsDiscount: Int = 1
    
}

class MockRestaurantListViewController: RestaurantListViewModelDelegate {
    
    var restaurantListViewModel: RestaurantListViewModelProtocol! {
        didSet {
            restaurantListViewModel.delegate = self
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
