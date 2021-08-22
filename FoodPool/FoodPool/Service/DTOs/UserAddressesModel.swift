//
//  UserAddressesModel.swift
//  FoodPool
//
//  Created by Ayşe Nur Bakırcı on 17.08.2021.
//

import Foundation

struct UserAddressesModel: Codable, Hashable {
    var address: String
    var addressTitle: String
    var province: String
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        address = try values.decode(String.self, forKey: .address)
        addressTitle = try values.decode(String.self, forKey: .addressTitle)
        province = try values.decode(String.self, forKey: .province)
    }
    
    enum CodingKeys: String, CodingKey {
        case address
        case addressTitle
        case province
    }
}
