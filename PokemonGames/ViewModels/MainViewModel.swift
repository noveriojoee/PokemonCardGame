//
//  MainViewModel.swift
//  PokemonGames
//
//  Created by noverio joe on 12/02/22.
//

import UIKit

class MainViewModel: BaseViewModel {
    //Fields
    var searchText : String?
    
    let pokemonService = PokemonServices()
    var pokemonCards : [CardModel?]?
    var cardsPage  =  1
    
    //GetterSetter
    var pokemonCardsCount: Int {
            get {
                return self.pokemonCards != nil ? self.pokemonCards!.count : 0
            }
        }
    
    //Constructor
    required init() {
        super.init()
        searchText = ""
    }
    
    func resetState(){
        self.pokemonCards = nil
        self.cardsPage = 1
    }
    
    public func searchPokemon(onSearchCompleted : @escaping (_ responseCode : String) -> Void){
        self.isFetchingData = true
        self.pokemonService.searchPokemonWithKeyword(keyword: self.searchText,selectedPage: self.cardsPage, onComplete: {
            (resultData) -> Void in
            self.isFetchingData = false
            self.resetState()
            if(resultData != nil || resultData?.data != nil){
                self.pokemonCards = resultData!.data
                onSearchCompleted("OK")
            }else{
                onSearchCompleted("Not Found")
            }
        })
        
    }
    
    public func loadMore(onSearchCompleted : @escaping (_ responseCode : String) -> Void){
        self.isFetchingData = true
        self.pokemonService.searchPokemonWithKeyword(keyword: self.searchText,selectedPage: self.cardsPage, onComplete: {
            (resultData) -> Void in
            self.isFetchingData = false
            if(resultData != nil || resultData?.data != nil){
                guard let cards = resultData?.data else{
                    onSearchCompleted("Not Found")
                    return
                }
                if (self.pokemonCards == nil){
                    self.pokemonCards = cards
                }else{
                    self.pokemonCards!.append(contentsOf: resultData!.data!)
                }
                onSearchCompleted("OK")
            }else{
                onSearchCompleted("Not Found")
            }
        })
    }
    
    public func goToDetailCard(index : Int){
        if self.pokemonCardsCount <= 0 {
            return
        }
        guard let selectedCard = self.pokemonCards![index] else {return}
        guard let type = selectedCard.types?.first else{return}
        guard let subtype = selectedCard.subtypes?.first else {return}
        let arguments = DetailCardArgs(cardID: selectedCard.id ?? "", subType: subtype, type: type)
        self.viewContext?.performSegue(withIdentifier: "segue_to_detail", sender:arguments)
    }
    
}
