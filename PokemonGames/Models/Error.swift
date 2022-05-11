//
//  Error.swift
//  PokemonGames
//
//  Created by noverio joe on 15/02/22.
//

import UIKit
import ObjectMapper

class Error: Mappable {
    var code : Int?
    var message : String?
    
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        code <- map["code"]
        message <- map["message"]
    }

}
