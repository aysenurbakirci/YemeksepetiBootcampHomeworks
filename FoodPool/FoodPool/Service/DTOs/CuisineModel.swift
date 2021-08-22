//
//  CuisineModel.swift
//  FoodPool
//
//  Created by Ayşe Nur Bakırcı on 15.08.2021.
//

import Foundation
import FirebaseFirestoreSwift

struct CuisineModel: Codable {
    @DocumentID var id: String?
    var cuisine: String
    var image: String
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        cuisine = try values.decode(String.self, forKey: .cuisine)
        image = try values.decode(String.self, forKey: .image)
    }
    
    enum CodingKeys: String, CodingKey {
        case cuisine
        case image
    }
}
