//
//  RestaurantModel.swift
//  FoodPool
//
//  Created by Ayşe Nur Bakırcı on 15.08.2021.
//

import Foundation
import FirebaseFirestoreSwift

struct RestaurantModel: Codable {
    
    @DocumentID var id: String?
    var restaurantName: String
    var restaurantImagePath: String
    var restaurantAddress: String
    var restaurantCuisineType: String
    var restaurantIsOpen: Bool
    var restaurantMeals: [RestaurantMenuModel]
    var restaurantDrinks: [RestaurantMenuModel]
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        restaurantName = try values.decode(String.self, forKey: .restaurantName)
        restaurantImagePath = try values.decode(String.self, forKey: .restaurantImagePath)
        restaurantAddress = try values.decode(String.self, forKey: .restaurantAddress)
        restaurantCuisineType = try values.decode(String.self, forKey: .restaurantCuisineType)
        restaurantIsOpen = try values.decode(Bool.self, forKey: .restaurantIsOpen)
        restaurantMeals = try values.decode([RestaurantMenuModel].self, forKey: .restaurantMeals)
        restaurantDrinks = try values.decode([RestaurantMenuModel].self, forKey: .restaurantDrinks)
    }
    
    enum CodingKeys: String, CodingKey {
        case restaurantName
        case restaurantImagePath
        case restaurantAddress
        case restaurantCuisineType
        case restaurantIsOpen
        case restaurantMeals
        case restaurantDrinks
    }
}


