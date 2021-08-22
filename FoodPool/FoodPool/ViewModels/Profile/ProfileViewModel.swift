//
//  ProfileViewModel.swift
//  FoodPool
//
//  Created by Ayşe Nur Bakırcı on 18.08.2021.
//

import Foundation
import FirebaseFirestore

protocol ProfileViewModelProtocol {
    
    func load()
    func address(indexPath: Int) -> UserAddressesModel?
    var userInfo: UserModel? { get }
    var numberOfItemsAddress: Int { get }
    var delegate: ProfileViewModelDelegate? { get set }
}

protocol ProfileViewModelDelegate: AnyObject {
    func showLoadingView()
    func hideLoadingView()
    func reloadData()
}

final class ProfileViewModel {
    
    private var userModel: UserModel?
    private var addressList: [UserAddressesModel] = []
    
    let service: FoodPoolUsersServiceProtocol
    
    weak var delegate: ProfileViewModelDelegate?
    
    init(service: FoodPoolUsersServiceProtocol) {
        self.service = service
    }
    
    fileprivate func fetchUsers() {
        delegate?.showLoadingView()
        service.fetchUserInfo { [weak self] user in
            guard let self = self else { return }
            self.delegate?.hideLoadingView()
            switch user {
            case .success(let user):
                if user.uid == AuthUserModel.authUser.userID {
                    self.userModel = user
                    self.addressList = user.userAddresses
                    self.delegate?.reloadData()
                }
            case.failure(let error):
                print(error)
            }
        }
    }
}

extension ProfileViewModel: ProfileViewModelProtocol {
    
    func load() {
        fetchUsers()
    }
    
    var userInfo: UserModel? {
        guard let user = userModel else { return nil }
        print("USERMODEL: \(user)")
        return user
    }
    
    func address(indexPath: Int) -> UserAddressesModel? {
        addressList[safe: indexPath]
    }
    
    var numberOfItemsAddress: Int {
        addressList.count
    }
}

