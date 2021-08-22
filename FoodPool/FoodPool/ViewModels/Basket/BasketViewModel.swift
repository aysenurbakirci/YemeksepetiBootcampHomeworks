//
//  BasketViewModel.swift
//  FoodPool
//
//  Created by Ayşe Nur Bakırcı on 18.08.2021.
//

import Foundation

protocol BasketViewModelProtocol {
    
    func load()
    func meal(indexPath: Int) -> RestaurantMenuModel?
    var numberOfItemsMeal: Int { get }
    var totalPrice: String { get }
    var delegate: BasketViewModelDelegate? { get set }
}

protocol BasketViewModelDelegate: AnyObject {
    func reloadData()
}

final class BasketViewModel {
    
    private var basketModel: [RestaurantMenuModel] = BasketModel.basketList.menuModel
    private var total: Double = 0.0
    
    weak var delegate: BasketViewModelDelegate?

    fileprivate func getMealsInBasket() {
        
        total = 0.0
        basketModel = BasketModel.basketList.menuModel

        for meal in basketModel {
            total += Double(meal.price) ?? 0.0
        }
        
        BasketModel.basketList.totalPrice = total
        delegate?.reloadData()
    }
    
}

extension BasketViewModel: BasketViewModelProtocol {
    
    func load() {
        getMealsInBasket()
    }
    
    func meal(indexPath: Int) -> RestaurantMenuModel? {
        basketModel[safe: indexPath]
    }
    
    var totalPrice: String {
        "\(total)$"
    }
    
    var numberOfItemsMeal: Int {
        basketModel.count
    }
}
