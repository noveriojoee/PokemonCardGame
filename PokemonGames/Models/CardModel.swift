//
//  CardModel.swift
//  PokemonGames
//
//  Created by noverio joe on 13/02/22.
//

import UIKit
import ObjectMapper

struct CardModel: Mappable {
    
    var id : String?
    var name : String?
    var supertype : String?
    var level : String?
    var hp : String?
    var images : CardImage?
    var subtypes : [String]?
    var types : [String]?
    var attacks : [AttackModel]?
    var flavorText : String?
    
    init?(map: Map) {
        id <- map["id"]
        name <- map["name"]
        supertype <- map["supertype"]
        level <- map["level"]
        hp <- map["hp"]
        images <- map["images"]
        subtypes <- map["subtypes"]
        types <- map["types"]
        attacks <- map["attacks"]
        flavorText <- map["flavorText"]
    }
    
    mutating func mapping(map: Map) {
    }
}

struct AttackModel : Mappable{
    var name : String?
    var convertedEnergyCost : Int?
    var damage : String?
    var text : String?
    
    init?(map: Map) {
        name <- map["name"]
        convertedEnergyCost <- map["convertedEnergyCost"]
        damage <- map["damage"]
        text <- map["text"]
    }
    
    mutating func mapping(map: Map) {
        name <- map["name"]
        convertedEnergyCost <- map["convertedEnergyCost"]
        damage <- map["damage"]
        text <- map["text"]

    }
}

struct CardImage : Mappable{
    var small : String?
    var large : String?
    
    init?(map: Map) {
        small <- map["small"]
        large <- map["large"]
    }
    
    mutating func mapping(map: Map) {
    }
}
