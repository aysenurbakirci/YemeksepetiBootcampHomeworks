//
//  SignInViewModel.swift
//  FoodPool
//
//  Created by Ayşe Nur Bakırcı on 22.08.2021.
//

import Foundation
import FirebaseFirestore


protocol SignInViewModelProtocol {
    
    func userSignIn()
    func userForgatPassword()
    var delegate: SignInViewModelDelegate? { get set }
}

protocol SignInViewModelDelegate: AnyObject {
    
    func getData() -> SignInData?
    func successSignIn()
    func failureSignIn(err: Error?)
}

final class SignInViewModel {
    
    let service: FoodPoolSignInServiceProtocol
    weak var delegate: SignInViewModelDelegate?
    
    init(service: FoodPoolSignInServiceProtocol) {
        self.service = service
    }
    
    fileprivate func signIn() {
        
        let model = delegate?.getData()
        
        guard let email = model?.email, let password = model?.password else {
            self.delegate?.failureSignIn(err: "Empty Value" as? Error)
            return
        }
        
        service.signIn(userEmail: email, userPassword: password) { result in
            switch result {
            case .success(let userID):
                AuthUserModel.authUser.userID = userID
                self.delegate?.successSignIn()
            case .failure(let error):
                self.delegate?.failureSignIn(err: error)
            }
        }
    }
    
    fileprivate func forgatPassword() {
        
        let model = delegate?.getData()
        
        guard let email = model?.email else {
            self.delegate?.failureSignIn(err: "Empty Value" as? Error)
            return
        }
        
        service.forgatPassword(userEmail: email) { state in
            switch state {
            case .failure(let error):
                self.delegate?.failureSignIn(err: error)
            case .success(true):
                self.delegate?.successSignIn()
            case .success(false):
                self.delegate?.failureSignIn(err: "Unknown Error." as? Error)
            }
        }
    }
}

extension SignInViewModel: SignInViewModelProtocol {
    func userForgatPassword() {
        forgatPassword()
    }
    
    func userSignIn() {
        signIn()
    }
}
