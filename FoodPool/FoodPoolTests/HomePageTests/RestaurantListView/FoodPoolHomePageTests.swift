//
//  FoodPoolHomePageTests.swift
//  FoodPoolHomePageTests
//
//  Created by Ayşe Nur Bakırcı on 6.08.2021.
//

import XCTest
@testable import FoodPool

class FoodPoolHomePageTests: XCTestCase {

    var mockView: MockRestaurantListViewController!
    var mockViewModel: MockRestaurantListViewModel!

    override func setUp() {
        super.setUp()
        mockView = MockRestaurantListViewController()
        mockViewModel = MockRestaurantListViewModel()
        mockView.restaurantListViewModel = mockViewModel
    }
    
    override func tearDown() {
        super.tearDown()
        mockView = nil
        mockViewModel = nil
    }
    
    func test_load() {
        XCTAssertFalse(mockViewModel.isLoaded)
        mockView.restaurantListViewModel.load()
        XCTAssertTrue(mockViewModel.isLoaded)
    }
    
    func test_restaurant() {
        XCTAssertFalse(mockViewModel.createdRestaurant)
        _ = mockView.restaurantListViewModel.restaurant(indexPath: 0)
        XCTAssertTrue(mockViewModel.createdRestaurant)
    }
    
    func test_cuisine() {
        XCTAssertFalse(mockViewModel.createdCuisine)
        _ = mockView.restaurantListViewModel.cuisine(indexPath: 0)
        XCTAssertTrue(mockViewModel.createdCuisine)
    }
    
    func test_discount() {
        XCTAssertFalse(mockViewModel.createdDiscount)
        _ = mockView.restaurantListViewModel.discount(indexPath: 0)
        XCTAssertTrue(mockViewModel.createdDiscount)
    }
    
    func test_numberOfItemsRestaurant() {
        XCTAssertEqual(mockView.restaurantListViewModel.numberOfItemsRestaurant, mockViewModel.numberOfItemsRestaurant)
    }
    
    func test_numberOfItemsCuisine() {
        XCTAssertEqual(mockView.restaurantListViewModel.numberOfItemsCuisine, mockViewModel.numberOfItemsCuisine)
    }
    
    func test_numberOfItemsDiscount() {
        XCTAssertEqual(mockView.restaurantListViewModel.numberOfItemsDiscount, mockViewModel.numberOfItemsDiscount)
    }
    
    func test_showLoadingView() {
        XCTAssertFalse(mockView.isInvokedShowLoading)
        mockViewModel.delegate?.showLoadingView()
        XCTAssertTrue(mockView.isInvokedShowLoading)
    }
    
    func test_hideLoadingView() {
        XCTAssertFalse(mockView.isInvokedHideLoading)
        mockViewModel.delegate?.hideLoadingView()
        XCTAssertTrue(mockView.isInvokedHideLoading)
    }
    
    func test_reloadData() {
        XCTAssertFalse(mockView.dataIsReloaded)
        mockViewModel.delegate?.reloadData()
        XCTAssertTrue(mockView.dataIsReloaded)
    }

}
