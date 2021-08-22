//
//  SelectOrderMethodsViewModel.swift
//  FoodPool
//
//  Created by Ayşe Nur Bakırcı on 18.08.2021.
//

import Foundation

protocol SelectOrderMethodsViewModelProtocol {
    
    func create()
    var delegate: SelectOrderMethodsViewModelDelegate? { get set }
}

protocol SelectOrderMethodsViewModelDelegate: AnyObject {
    func getData() -> CreateOrderData?
    func successOrder()
    func failureOrder()
}

final class SelectOrderMethodsViewModel {
    
    let service: FoodPoolCreateOrderServiceProtocol
    weak var delegate: SelectOrderMethodsViewModelDelegate?
    
    init(service: FoodPoolCreateOrderServiceProtocol) {
        self.service = service
    }
    
    fileprivate func createOrder() {
        
        let model = delegate?.getData()
        service.createOrder(mealList: model?.mealList ?? ["",""], price: model?.price ?? "00", state: model?.state ?? "current", nameRestaurant: model?.nameRestaurant ?? "Restaurant Name", userID: model?.userID ?? "", paymentMethod: model?.paymentMethod ?? "Online") { state in
            if state ?? false {
                print("Success")
                self.delegate?.successOrder()
            } else {
                print("Failure")
                self.delegate?.failureOrder()
            }
        }
        
    }
    
}

extension SelectOrderMethodsViewModel: SelectOrderMethodsViewModelProtocol {
    
    func create() {
        createOrder()
    }
}
