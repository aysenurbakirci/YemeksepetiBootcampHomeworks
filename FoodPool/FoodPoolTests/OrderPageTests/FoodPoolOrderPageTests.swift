//
//  FoodPoolOrderPageTests.swift
//  FoodPoolTests
//
//  Created by Ayşe Nur Bakırcı on 22.08.2021.
//

import XCTest
@testable import FoodPool

class FoodPoolOrderPageTests: XCTestCase {
    
    var mockView: MockOrderViewController!
    var mockViewModel: MockOrderViewModel!

    override func setUp() {
        super.setUp()
        mockView = MockOrderViewController()
        mockViewModel = MockOrderViewModel()
        mockView.orderViewModel = mockViewModel
    }
    
    override func tearDown() {
        super.tearDown()
        mockView = nil
        mockViewModel = nil
    }
    
    func test_load() {
        XCTAssertFalse(mockViewModel.isLoaded)
        mockView.orderViewModel.load()
        XCTAssertTrue(mockViewModel.isLoaded)
    }

    func test_previousOrder() {
        XCTAssertFalse(mockViewModel.createdPreviousOrder)
        _ = mockView.orderViewModel.previousOrder(indexPath: 0)
        XCTAssertTrue(mockViewModel.createdPreviousOrder)
    }
    
    func test_currentOrder() {
        XCTAssertFalse(mockViewModel.createdCurrentOrder)
        _ = mockView.orderViewModel.currentOrder(indexPath: 0)
        XCTAssertTrue(mockViewModel.createdCurrentOrder)
    }
    
    func test_getMealList() {
        XCTAssertFalse(mockViewModel.gettingMealList)
//        _ = mockView.orderViewModel.getMealList(order:)
//        XCTAssertTrue(mockViewModel.gettingMealList)
    }

    func test_numberOfItemsPreviousOrders() {
        XCTAssertEqual(mockView.orderViewModel.numberOfItemsPreviosOrders, mockViewModel.numberOfItemsPreviosOrders)
    }
    
    func test_numberOfItemsCurrentOrders() {
        XCTAssertEqual(mockView.orderViewModel.numberOfItemsCurrentOrders, mockViewModel.numberOfItemsCurrentOrders)
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
