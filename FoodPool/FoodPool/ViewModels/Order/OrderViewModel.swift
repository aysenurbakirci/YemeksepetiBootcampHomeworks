//
//  OrderViewModel.swift
//  FoodPool
//
//  Created by Ayşe Nur Bakırcı on 18.08.2021.
//

import Foundation
import FirebaseFirestore

protocol OrderViewModelProtocol {
    
    func load()
    func previousOrder(indexPath: Int) -> OrderModel?
    func currentOrder(indexPath: Int) -> OrderModel?
    func getMealList(order: OrderModel) -> String
    var numberOfItemsPreviosOrders: Int { get }
    var numberOfItemsCurrentOrders: Int { get }
    var delegate: OrderViewModelDelegate? { get set }
}

protocol OrderViewModelDelegate: AnyObject {
    func showLoadingView()
    func hideLoadingView()
    func reloadData()
}

final class OrderViewModel {
    
    private var previousOrders: [OrderModel] = []
    private var currentOrders: [OrderModel] = []
    
    let service: FoodPoolOrdersServiceProtocol
    
    weak var delegate: OrderViewModelDelegate?
    
    init(service: FoodPoolOrdersServiceProtocol) {
        self.service = service
    }
    
    fileprivate func fetchOrders() {
        delegate?.showLoadingView()
        previousOrders.removeAll()
        currentOrders.removeAll()
        service.fetchOrders { [weak self] result in
            guard let self = self else { return }
            self.delegate?.hideLoadingView()
            
            switch result {
            case .success(let order):
                print("ORDER: \(order)")
                if order.userID == AuthUserModel.authUser.userID {
                    if order.state == "current" {
                        self.currentOrders.append(order)
                    } else {
                        self.previousOrders.append(order)
                    }
                }
                self.delegate?.reloadData()
            case .failure(let error):
                print(error)
            }
            
        }
    }
}

extension OrderViewModel: OrderViewModelProtocol {
    
    func getMealList(order: OrderModel) -> String {
        var meals = ""
        for meal in order.mealList {
            meals += (" " + meal + ",")
        }
        return meals
    }
    
    func load() {
        fetchOrders()
    }
    
    func previousOrder(indexPath: Int) -> OrderModel? {
        previousOrders[safe: indexPath]
    }
    
    func currentOrder(indexPath: Int) -> OrderModel? {
        currentOrders[safe: indexPath]
    }
    
    var numberOfItemsPreviosOrders: Int {
        previousOrders.count
    }
    
    var numberOfItemsCurrentOrders: Int {
        currentOrders.count
    }
}
