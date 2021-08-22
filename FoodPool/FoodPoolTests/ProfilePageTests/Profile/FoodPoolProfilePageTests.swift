//
//  FoodPoolProfilePageTests.swift
//  FoodPoolTests
//
//  Created by Ayşe Nur Bakırcı on 22.08.2021.
//

import XCTest
@testable import FoodPool

class FoodPoolProfilePageTests: XCTestCase {

    var mockView: MockProfileViewController!
    var mockViewModel: MockProfileViewModel!

    override func setUp() {
        super.setUp()
        mockView = MockProfileViewController()
        mockViewModel = MockProfileViewModel()
        mockView.profileViewModel = mockViewModel
    }
    
    override func tearDown() {
        super.tearDown()
        mockView = nil
        mockViewModel = nil
    }
    
    func test_load() {
        XCTAssertFalse(mockViewModel.isLoaded)
        mockView.profileViewModel.load()
        XCTAssertTrue(mockViewModel.isLoaded)
    }

    func test_address() {
        XCTAssertFalse(mockViewModel.createdAddress)
        _ = mockView.profileViewModel.address(indexPath: 0)
        XCTAssertTrue(mockViewModel.createdAddress)
    }
//
//    func test_userInfo() {
//        XCTAssertEqual(mockView.profileViewModel.userInfo, mockViewModel.userInfo)
//    }

    func test_numberOfItemsAddress() {
        XCTAssertEqual(mockView.profileViewModel.numberOfItemsAddress, mockViewModel.numberOfItemsAddress)
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
