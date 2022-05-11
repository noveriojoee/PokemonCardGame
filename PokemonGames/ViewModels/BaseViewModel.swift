//
//  BaseViewModel.swift
//  PokemonGames
//
//  Created by noverio joe on 12/02/22.
//

import UIKit

class BaseViewModel: NSObject {
    var isFetchingData : Bool = false
    weak var viewContext : UIViewController?
    
    required override init() {
        super.init()
    }
    
    func registerObservabilityToView(object : Any){}
}
