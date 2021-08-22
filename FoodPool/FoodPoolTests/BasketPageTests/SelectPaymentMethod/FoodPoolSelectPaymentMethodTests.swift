//
//  FoodPoolSelectPaymentMethodTests.swift
//  FoodPoolTests
//
//  Created by Ayşe Nur Bakırcı on 22.08.2021.
//

import XCTest
@testable import FoodPool

class FoodPoolSelectPaymentMethodTests: XCTestCase {

    var mockView: MockSelectPaymentMethodViewController!
    var mockViewModel: MockSelectPaymentMethodViewModel!

    override func setUp() {
        super.setUp()
        mockView = MockSelectPaymentMethodViewController()
        mockViewModel = MockSelectPaymentMethodViewModel()
        mockView.selectPaymentMethodsViewModel = mockViewModel
    }
    
    override func tearDown() {
        super.tearDown()
        mockView = nil
        mockViewModel = nil
    }
    
    func test_load() {
        XCTAssertFalse(mockViewModel.isLoaded)
        mockView.selectPaymentMethodsViewModel.load()
        XCTAssertTrue(mockViewModel.isLoaded)
    }

    func test_paymentMethods() {
        XCTAssertFalse(mockViewModel.createdPaymentMethods)
        _ = mockView.selectPaymentMethodsViewModel.paymentMethod(indexPath: 0)
        XCTAssertTrue(mockViewModel.createdPaymentMethods)
    }

    func test_numberOfItemsPaymentMethods() {
        XCTAssertEqual(mockView.selectPaymentMethodsViewModel.numberOfItemsPaymentMethods, mockViewModel.numberOfItemsPaymentMethods)
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
