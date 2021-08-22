//
//  PaymentMethodModel.swift
//  FoodPool
//
//  Created by Ayşe Nur Bakırcı on 20.08.2021.
//

import Foundation
import FirebaseFirestoreSwift

struct PaymentMethodModel: Codable {

    @DocumentID var id: String?
    var methodName: String
    var methodDescription: String
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        methodName = try values.decode(String.self, forKey: .methodName)
        methodDescription = try values.decode(String.self, forKey: .methodDescription)
    
    enum CodingKeys: String, CodingKey {
        case methodName
        case methodDescription
        }
    }
}
