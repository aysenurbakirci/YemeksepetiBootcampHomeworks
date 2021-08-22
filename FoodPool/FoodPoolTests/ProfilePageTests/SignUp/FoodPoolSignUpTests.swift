//
//  FoodPoolSignUpTests.swift
//  FoodPoolTests
//
//  Created by Ayşe Nur Bakırcı on 22.08.2021.
//

import XCTest
@testable import FoodPool

class FoodPoolSignUpTests: XCTestCase {

    var mockView: MockSignUpViewController!
    var mockViewModel: MockSignUpViewModel!

    override func setUp() {
        super.setUp()
        mockView = MockSignUpViewController()
        mockViewModel = MockSignUpViewModel()
        mockView.signUpViewModel = mockViewModel
    }
    
    override func tearDown() {
        super.tearDown()
        mockView = nil
        mockViewModel = nil
    }
    
    func test_userSignUp() {
        XCTAssertFalse(mockViewModel.isSignUp)
        mockView.signUpViewModel.userSignUp()
        XCTAssertTrue(mockViewModel.isSignUp)
    }

    func test_getData() {
        XCTAssertFalse(mockView.gettingData)
        _ = mockViewModel.delegate?.getData()
        XCTAssertTrue(mockView.gettingData)
    }

    func test_successAddAddress() {
        XCTAssertFalse(mockView.isSucceed)
        mockViewModel.delegate?.successSignUp()
        XCTAssertTrue(mockView.isSucceed)
    }

    func test_failureAddAddress() {
        XCTAssertFalse(mockView.isFailed)
        mockViewModel.delegate?.failureSignUp(err: nil)
        XCTAssertTrue(mockView.isFailed)
    }
}
