//
//  DiscountModel.swift
//  FoodPool
//
//  Created by Ayşe Nur Bakırcı on 18.08.2021.
//

import FirebaseFirestoreSwift

struct DiscountModel: Codable {

    @DocumentID var id: String?
    var discountImages: [String]
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        discountImages = try values.decode([String].self, forKey: .discountImages)
    
    enum CodingKeys: String, CodingKey {
        case discountImages
        }
    }
}
