//
//  FoodPoolBasketPageTests.swift
//  FoodPoolTests
//
//  Created by Ayşe Nur Bakırcı on 21.08.2021.
//

import XCTest
@testable import FoodPool

class FoodPoolBasketPageTests: XCTestCase {

    var mockView: MockBasketViewController!
    var mockViewModel: MockBasketViewModel!

    override func setUp() {
        super.setUp()
        mockView = MockBasketViewController()
        mockViewModel = MockBasketViewModel()
        mockView.basketViewModel = mockViewModel
    }
    
    override func tearDown() {
        super.tearDown()
        mockView = nil
        mockViewModel = nil
    }
    
    func test_load() {
        XCTAssertFalse(mockViewModel.isLoaded)
        mockView.basketViewModel.load()
        XCTAssertTrue(mockViewModel.isLoaded)
    }

    func test_meal() {
        XCTAssertFalse(mockViewModel.createdMeal)
        _ = mockView.basketViewModel.meal(indexPath: 0)
        XCTAssertTrue(mockViewModel.createdMeal)
    }

    func test_numberOfItemsMeal() {
        XCTAssertEqual(mockView.basketViewModel.numberOfItemsMeal, mockViewModel.numberOfItemsMeal)
    }
    
    func test_totalPrice() {
        XCTAssertEqual(mockView.basketViewModel.totalPrice, mockViewModel.totalPrice)
    }

    func test_reloadData() {
        XCTAssertFalse(mockView.dataIsReloaded)
        mockViewModel.delegate?.reloadData()
        XCTAssertTrue(mockView.dataIsReloaded)
    }

}
