//
//  CreateOrderDataModel.swift
//  FoodPool
//
//  Created by Ayşe Nur Bakırcı on 22.08.2021.
//

import Foundation

struct CreateOrderData {
    let mealList: [String]
    let price: String
    let state: String
    let nameRestaurant: String
    let userID: String
    let paymentMethod: String
}
