//
//  MockSignIn.swift
//  FoodPoolTests
//
//  Created by Ayşe Nur Bakırcı on 22.08.2021.
//

import Foundation
@testable import FoodPool

class MockSignInViewModel: SignInViewModelProtocol{

    public init() {}
    weak var delegate: SignInViewModelDelegate?
    
    var isSignIn = false
    var getNewPassword = false

    func userSignIn() {
        self.isSignIn = true
    }
    
    func userForgatPassword() {
        self.getNewPassword = true
    }
}

class MockSignInViewController: SignInViewModelDelegate {
    
    var signInViewModel: SignInViewModelProtocol! {
        didSet {
            signInViewModel.delegate = self
        }
    }
    
    var gettingData = false
    var isSucceed = false
    var isFailed = false

    func getData() -> SignInData? {
        self.gettingData = true
        return nil
    }
    
    func successSignIn() {
        self.isSucceed = true
    }
    
    func failureSignIn(err: Error?) {
        self.isFailed = true
    }

}
