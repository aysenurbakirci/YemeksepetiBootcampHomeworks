//
//  FoodPoolAddAddressTests.swift
//  FoodPoolTests
//
//  Created by Ayşe Nur Bakırcı on 22.08.2021.
//

import XCTest
@testable import FoodPool

class FoodPoolAddAddressTests: XCTestCase {

    var mockView: MockAddAddressViewController!
    var mockViewModel: MockAddAddressViewModel!

    override func setUp() {
        super.setUp()
        mockView = MockAddAddressViewController()
        mockViewModel = MockAddAddressViewModel()
        mockView.addAddressViewModel = mockViewModel
    }
    
    override func tearDown() {
        super.tearDown()
        mockView = nil
        mockViewModel = nil
    }
    
    func test_addNewAddress() {
        XCTAssertFalse(mockViewModel.createdNewAddress)
        mockView.addAddressViewModel.addNewAddress()
        XCTAssertTrue(mockViewModel.createdNewAddress)
    }
    
    func test_getData() {
        XCTAssertFalse(mockView.gettingData)
        _ = mockViewModel.delegate?.getData()
        XCTAssertTrue(mockView.gettingData)
    }

    func test_successAddAddress() {
        XCTAssertFalse(mockView.isSucceed)
        mockViewModel.delegate?.successAddAddress()
        XCTAssertTrue(mockView.isSucceed)
    }
    
    func test_failureAddAddress() {
        XCTAssertFalse(mockView.isFailed)
        mockViewModel.delegate?.failureAddAddress(err: nil)
        XCTAssertTrue(mockView.isFailed)
    }

}
