//
//  AddAddressViewModel.swift
//  FoodPool
//
//  Created by Ayşe Nur Bakırcı on 22.08.2021.
//

import Foundation

protocol AddAddressViewModelProtocol {
    
    func addNewAddress()
    var delegate: AddAddressViewModelDelegate? { get set }
}

protocol AddAddressViewModelDelegate: AnyObject {
    func getData() -> AddAddressData?
    func successAddAddress()
    func failureAddAddress(err: Error?)
}

final class AddAddressViewModel {
    
    let service: FoodPoolCreateAddressServiceProtocol
    weak var delegate: AddAddressViewModelDelegate?
    
    init(service: FoodPoolCreateAddressServiceProtocol) {
        self.service = service
    }
    
    fileprivate func addAddress() {
        
        let model = delegate?.getData()
        
        guard let addressTitle = model?.addressTitle, let address = model?.address, let province = model?.province else {
            delegate?.failureAddAddress(err: "Empty Value." as? Error)
            return
        }

        service.createAddress(addressTitle: addressTitle, address: address, province: province, document: AuthUserModel.authUser.userDocumentID) { state in
            if state! {
                self.delegate?.successAddAddress()
            } else {
                self.delegate?.failureAddAddress(err: "Address could not be created." as? Error)
            }
        }
    }
}

extension AddAddressViewModel: AddAddressViewModelProtocol {
    
    func addNewAddress() {
        addAddress()
    }
}
