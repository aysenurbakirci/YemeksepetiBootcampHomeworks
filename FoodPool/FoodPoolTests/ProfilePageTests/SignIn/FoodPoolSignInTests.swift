//
//  FoodPoolSignInTests.swift
//  FoodPoolTests
//
//  Created by Ayşe Nur Bakırcı on 22.08.2021.
//

import XCTest
@testable import FoodPool

class FoodPoolSignInTests: XCTestCase {

    var mockView: MockSignInViewController!
    var mockViewModel: MockSignInViewModel!

    override func setUp() {
        super.setUp()
        mockView = MockSignInViewController()
        mockViewModel = MockSignInViewModel()
        mockView.signInViewModel = mockViewModel
    }
    
    override func tearDown() {
        super.tearDown()
        mockView = nil
        mockViewModel = nil
    }
    
    func test_userSignIn() {
        XCTAssertFalse(mockViewModel.isSignIn)
        mockView.signInViewModel.userSignIn()
        XCTAssertTrue(mockViewModel.isSignIn)
    }
    
    func test_userForgatPassword() {
        XCTAssertFalse(mockViewModel.getNewPassword)
        mockView.signInViewModel.userForgatPassword()
        XCTAssertTrue(mockViewModel.getNewPassword)
    }
    
    func test_getData() {
        XCTAssertFalse(mockView.gettingData)
        _ = mockViewModel.delegate?.getData()
        XCTAssertTrue(mockView.gettingData)
    }

    func test_successAddAddress() {
        XCTAssertFalse(mockView.isSucceed)
        mockViewModel.delegate?.successSignIn()
        XCTAssertTrue(mockView.isSucceed)
    }

    func test_failureAddAddress() {
        XCTAssertFalse(mockView.isFailed)
        mockViewModel.delegate?.failureSignIn(err: nil)
        XCTAssertTrue(mockView.isFailed)
    }

}
