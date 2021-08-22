//
//  FoodPoolRestaurantFilterTests.swift
//  FoodPoolTests
//
//  Created by Ayşe Nur Bakırcı on 21.08.2021.
//

import XCTest
@testable import FoodPool

class FoodPoolRestaurantFilterTests: XCTestCase {

    var mockView: MockRestaurantFilterViewController!
    var mockViewModel: MockRestaurantFilterViewModel!

    override func setUp() {
        super.setUp()
        mockView = MockRestaurantFilterViewController()
        mockViewModel = MockRestaurantFilterViewModel()
        mockView.restaurantFilterViewModel = mockViewModel
    }
    
    override func tearDown() {
        super.tearDown()
        mockView = nil
        mockViewModel = nil
    }
    
    func test_load() {
        XCTAssertFalse(mockViewModel.isLoaded)
        mockView.restaurantFilterViewModel.load()
        XCTAssertTrue(mockViewModel.isLoaded)
    }
    
    func test_restaurant() {
        XCTAssertFalse(mockViewModel.createdRestaurant)
        _ = mockView.restaurantFilterViewModel.restaurant(indexPath: 0)
        XCTAssertTrue(mockViewModel.createdRestaurant)
    }
    
    func test_numberOfItemsRestaurant() {
        XCTAssertEqual(mockView.restaurantFilterViewModel.numberOfItemsRestaurant, mockViewModel.numberOfItemsRestaurant)
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
    
    func test_getFilterCategory() {
        XCTAssertFalse(mockView.getFilterCategory)
        _ = mockViewModel.delegate?.filterCategory()
        XCTAssertTrue(mockView.getFilterCategory)
    }

}
