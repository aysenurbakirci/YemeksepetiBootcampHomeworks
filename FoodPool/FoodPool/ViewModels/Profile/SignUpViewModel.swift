//
//  SignUpViewModel.swift
//  FoodPool
//
//  Created by Ayşe Nur Bakırcı on 22.08.2021.
//

import Foundation
import FirebaseFirestore

protocol SignUpViewModelProtocol {
    
    func userSignUp()
    var delegate: SignUpViewModelDelegate? { get set }
}

protocol SignUpViewModelDelegate: AnyObject {
    func getData() -> SignUpData?
    func successSignUp()
    func failureSignUp(err: Error?)
}

final class SignUpViewModel {
    
    let service: FoodPoolCreateUserServiceProtocol
    weak var delegate: SignUpViewModelDelegate?
    
    init(service: FoodPoolCreateUserServiceProtocol) {
        self.service = service
    }
    
    fileprivate func signUp() {
        
        let model = delegate?.getData()
        
        guard let email = model?.email, let password = model?.password, let name = model?.fullName, let phone = model?.phone else {
            delegate?.failureSignUp(err: "Empty Value." as! Error)
            return
        }
        
        service.signUp(userEmail: email, userPassword: password, userName: name, userPhone: phone) { state in
            switch state {
            case .success(true):
                self.delegate?.successSignUp()
            case .failure(let error):
                self.delegate?.failureSignUp(err: error)
            case .success(false):
                self.delegate?.failureSignUp(err: "Unknown Error" as! Error)
            }
        }
    }
}

extension SignUpViewModel: SignUpViewModelProtocol {
    
    func userSignUp() {
        signUp()
    }
}
