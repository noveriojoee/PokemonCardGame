//
//  DetailCardArgs.swift
//  PokemonGames
//
//  Created by noverio joe on 16/02/22.
//

import Foundation

struct DetailCardArgs{
    var cardID : String?
    var subType : String?
    var type : String?
    
    init(cardID : String, subType : String, type : String){
        self.cardID = cardID
        self.subType = subType
        self.type = type
    }
}
