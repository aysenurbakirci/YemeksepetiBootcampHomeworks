//
//  FoodPoolSelectOrderTests.swift
//  FoodPoolTests
//
//  Created by Ayşe Nur Bakırcı on 22.08.2021.
//

import XCTest
@testable import FoodPool

class FoodPoolSelectOrderTests: XCTestCase {

    var mockView: MockSelectAddressViewController!
    var mockViewModel: MockSelectAddressViewModel!

    override func setUp() {
        super.setUp()
        mockView = MockSelectAddressViewController()
        mockViewModel = MockSelectAddressViewModel()
        mockView.selectAddressViewModel = mockViewModel
    }
    
    override func tearDown() {
        super.tearDown()
        mockView = nil
        mockViewModel = nil
    }
    
    func test_load() {
        XCTAssertFalse(mockViewModel.isLoaded)
        mockView.selectAddressViewModel.load()
        XCTAssertTrue(mockViewModel.isLoaded)
    }

    func test_address() {
        XCTAssertFalse(mockViewModel.createdAddress)
        _ = mockView.selectAddressViewModel.address(indexPath: 0)
        XCTAssertTrue(mockViewModel.createdAddress)
    }

    func test_numberOfItemsRestaurant() {
        XCTAssertEqual(mockView.selectAddressViewModel.numberOfItemsAddressses, mockViewModel.numberOfItemsAddressses)
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
