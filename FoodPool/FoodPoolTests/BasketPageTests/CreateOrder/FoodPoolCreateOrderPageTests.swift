//
//  FoodPoolCreateOrderPageTests.swift
//  FoodPoolTests
//
//  Created by Ayşe Nur Bakırcı on 22.08.2021.
//

import XCTest
@testable import FoodPool

class FoodPoolCreateOrderPageTests: XCTestCase {

    var mockView: MockCreateOrderViewController!
    var mockViewModel: MockCreateOrderViewModel!

    override func setUp() {
        super.setUp()
        mockView = MockCreateOrderViewController()
        mockViewModel = MockCreateOrderViewModel()
        mockView.createOrderViewModel = mockViewModel
    }
    
    override func tearDown() {
        super.tearDown()
        mockView = nil
        mockViewModel = nil
    }
    
    func test_create() {
        XCTAssertFalse(mockViewModel.isCreated)
        mockView.createOrderViewModel.create()
        XCTAssertTrue(mockViewModel.isCreated)
    }

    func test_getData() {
        XCTAssertFalse(mockView.gettingData)
        _ = mockViewModel.delegate?.getData()
        XCTAssertTrue(mockView.gettingData)
    }

    func test_successOrder() {
        XCTAssertFalse(mockView.orderIsSuccess)
        mockViewModel.delegate?.successOrder()
        XCTAssertTrue(mockView.orderIsSuccess)
    }

    func test_failureOrder() {
        XCTAssertFalse(mockView.orderIsFailure)
        mockViewModel.delegate?.failureOrder()
        XCTAssertTrue(mockView.orderIsFailure)
    }

}
