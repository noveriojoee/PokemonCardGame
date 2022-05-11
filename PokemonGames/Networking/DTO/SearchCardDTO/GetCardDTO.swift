//
//  GetCardDTO.swift
//  PokemonGames
//
//  Created by noverio joe on 16/02/22.
//

import UIKit
import ObjectMapper

class GetCardDTO: Mappable {
    var data : CardModel?
    var error : Error?
    
    required init?(map: Map) {
    }

    func mapping(map: Map){
        data <- map["data"]
        error <- map["error"]
    }
}
