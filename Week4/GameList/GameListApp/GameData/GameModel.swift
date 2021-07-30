//
//  GameModel.swift
//  GameListApp
//
//  Created by Ayşe Nur Bakırcı on 15.07.2021.
//

import Foundation
import ObjectMapper

struct GameModel: Mappable {

    var id : Int?
    var name : String?
    var image: String?
    var released : String?
    var rating: Double?
    var metacritc: Double?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        image <- map["background_image"]
        released <- map["released"]
        rating <- map["rating"]
        metacritc <- map["metacritic"]
    }
    
}
