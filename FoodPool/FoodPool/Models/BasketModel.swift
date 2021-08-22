//
//  BasketModel.swift
//  FoodPool
//
//  Created by Ayşe Nur Bakırcı on 19.08.2021.
//

import Foundation

class BasketModel{
    
    static let basketList = BasketModel()
    
    var menuModel: [RestaurantMenuModel] = []
    var totalPrice: Double = 0.0
    var restaurant: String = ""
    
    private init(){}
}
