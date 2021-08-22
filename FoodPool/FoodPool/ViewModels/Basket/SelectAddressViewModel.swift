//
//  SelectAddressViewModel.swift
//  FoodPool
//
//  Created by Ayşe Nur Bakırcı on 20.08.2021.
//

import Foundation

protocol SelectAddressViewModelProtocol {
    
    func load()
    func address(indexPath: Int) -> UserAddressesModel?
    var numberOfItemsAddressses: Int { get }
    var delegate: SelectAddressViewModelDelegate? { get set }
}

protocol SelectAddressViewModelDelegate: AnyObject {
    
    func showLoadingView()
    func hideLoadingView()
    func reloadData()
}

final class SelectAddressViewModel {
    
    private var addresses: [UserAddressesModel] = []
    
    let service: FoodPoolUsersServiceProtocol
    
    weak var delegate: SelectAddressViewModelDelegate?
    
    init(service: FoodPoolUsersServiceProtocol) {
        self.service = service
    }
    
    fileprivate func fetchUserAddressList() {
        delegate?.showLoadingView()
        service.fetchUserInfo { [weak self] result in
            guard let self = self else { return }
            self.delegate?.hideLoadingView()
            switch result {
            case .success(let user):
                if user.uid == AuthUserModel.authUser.userID {
                    self.addresses = user.userAddresses
                    self.delegate?.reloadData()
                }
            case .failure(let error):
                print(error)
            }
            
        }
    }
}

extension SelectAddressViewModel: SelectAddressViewModelProtocol {
    var numberOfItemsAddressses: Int {
        addresses.count
    }
    
    func load() {
        fetchUserAddressList()
    }
    
    func address(indexPath: Int) -> UserAddressesModel? {
        addresses[safe: indexPath]
    }
}
