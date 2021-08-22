//
//  OrdersModel.swift
//  FoodPool
//
//  Created by Ayşe Nur Bakırcı on 17.08.2021.
//

import Foundation
import FirebaseFirestoreSwift

struct OrderModel: Codable {
    @DocumentID var id: String?
    var mealList: [String]
    var userID: String
    var price: String
    var state: String
    var restaurantName: String
    var paymentMethod: String
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        mealList = try values.decode([String].self, forKey: .mealList)
        price = try values.decode(String.self, forKey: .price)
        state = try values.decode(String.self, forKey: .state)
        restaurantName = try values.decode(String.self, forKey: .restaurantName)
        userID = try values.decode(String.self, forKey: .userID)
        paymentMethod = try values.decode(String.self, forKey: .paymentMethod)
    }
    
    enum CodingKeys: String, CodingKey {
        case mealList
        case price
        case userID
        case state
        case restaurantName
        case paymentMethod
    }
}


