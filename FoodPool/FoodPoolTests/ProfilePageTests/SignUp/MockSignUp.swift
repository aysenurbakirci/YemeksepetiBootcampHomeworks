//
//  MockSignUp.swift
//  FoodPoolTests
//
//  Created by Ayşe Nur Bakırcı on 22.08.2021.
//

import Foundation
@testable import FoodPool

class MockSignUpViewModel: SignUpViewModelProtocol{
    
    public init() {}
    weak var delegate: SignUpViewModelDelegate?
    
    var isSignUp = false
    
    func userSignUp() {
        self.isSignUp = true
    }
}

class MockSignUpViewController: SignUpViewModelDelegate {
    
    var signUpViewModel: SignUpViewModelProtocol! {
        didSet {
            signUpViewModel.delegate = self
        }
    }
    
    var gettingData = false
    var isSucceed = false
    var isFailed = false

    func getData() -> SignUpData? {
        self.gettingData = true
        return nil
    }
    
    func successSignUp() {
        self.isSucceed = true
    }
    
    func failureSignUp(err: Error?) {
        self.isFailed = true
    }

}
