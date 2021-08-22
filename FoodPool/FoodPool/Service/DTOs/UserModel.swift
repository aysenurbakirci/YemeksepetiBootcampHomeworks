//
//  UserModel.swift
//  FoodPool
//
//  Created by Ayşe Nur Bakırcı on 17.08.2021.
//

import Foundation
import FirebaseFirestoreSwift

struct UserModel: Codable {
    @DocumentID var documentID: String?
    var uid: String
    var userName: String
    var userEmail: String
    var userPhone: String
    var userAddresses: [UserAddressesModel]
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        userName = try values.decode(String.self, forKey: .userName)
        userEmail = try values.decode(String.self, forKey: .userEmail)
        userPhone = try values.decode(String.self, forKey: .userPhone)
        userAddresses = try values.decode([UserAddressesModel].self, forKey: .userAddresses)
        uid = try values.decode(String.self, forKey: .uid)
    }
    
    enum CodingKeys: String, CodingKey {
        case userName
        case userEmail
        case userPhone
        case userAddresses
        case uid
    }
}
