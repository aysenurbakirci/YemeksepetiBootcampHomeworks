//
//  MovieModel.swift
//  MovieList
//
//  Created by Ayşe Nur Bakırcı on 29.07.2021.
//

import Foundation
import ObjectMapper

struct MovieModel: Mappable {

    var id : Int?
    var title : String?
    var poster : String?
    var vote: Int?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        title <- map["title"]
        poster <- map["poster_path"]
        vote <- map["vote_count"]
    }
    
}

