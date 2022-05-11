//
//  SearchCardDTO.swift
//  PokemonGames
//
//  Created by noverio joe on 13/02/22.
//

import UIKit
import ObjectMapper

class SearchCardDTO: Mappable {
    
    var data : [CardModel]?
    var page : Int?
    var pageSize : Int?
    var count : Int?
    var totalCount : Int?
    var error : Error?
    
    required init?(map: Map) {
        page = 0
        pageSize = 0
        count = 0
        totalCount = 0
    }

    func mapping(map: Map){
        data <- map["data"]
        page <- map["page"]
        pageSize <- map["pageSize"]
        count <- map["count"]
        totalCount <- map["totalCount"]
        error <- map["error"]
    }
}
