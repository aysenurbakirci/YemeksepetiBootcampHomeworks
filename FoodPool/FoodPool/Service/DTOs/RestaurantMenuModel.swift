//
//  RestaurantMenuModel.swift
//  FoodPool
//
//  Created by Ayşe Nur Bakırcı on 15.08.2021.
//

import Foundation

struct RestaurantMenuModel: Codable, Hashable {
    var image: String
    var name: String
    var price: String
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        image = try values.decode(String.self, forKey: .image)
        name = try values.decode(String.self, forKey: .name)
        price = try values.decode(String.self, forKey: .price)
    }
    
    enum CodingKeys: String, CodingKey {
        case image
        case name
        case price
    }
}
