//
//  DetailCardViewModel.swift
//  PokemonGames
//
//  Created by noverio joe on 16/02/22.
//

import UIKit

class DetailCardViewModel: BaseViewModel {
    let pokemonService = PokemonServices()
    var arguments : DetailCardArgs?
    var selectedCard : CardModel?
    var pokemonCards : [CardModel?]?
    var cardsPage  =  1
    var isFetchDetailCard : Bool = false

    //GetterSetter
    var pokemonCardsCount: Int {
            get {
                return self.pokemonCards != nil ? self.pokemonCards!.count : 0
            }
        }
    
    required init() {
        super.init()
    }
    
    override func registerObservabilityToView(object: Any?) {
        guard let args = object as? DetailCardArgs else{
            return
        }
        self.arguments = args
    }
    
    //Public function
    
    public func getAttributeDetail () -> String{
        var result = ""
        guard let attacks =  self.selectedCard?.attacks else{
            return "N/A"
        }
        //Setup Attacks Attributes
        attacks.forEach{
            result += ($0.name ?? "") + ","
        }
        //Setup XP Attributes
        guard let pokemonHP =  self.selectedCard?.hp else{
            return result + " HP(-)"
        }
        
        //Setup Supertype
        guard let superType = self.selectedCard?.supertype else {
            return result + " HP(" + pokemonHP + ")"
        }
        
        //Setup Subtype
        guard let subType = self.selectedCard?.subtypes?.first else {
            return result + " HP(" + pokemonHP + ") \r\n " + superType
        }
        
        result += " HP(" + pokemonHP + ") \r\n" + superType + " - " + subType

        return result
    }
    
    public func getFlavourDetail () -> String{
        guard let flavourText = self.selectedCard?.flavorText else{
            return "(N/A)"
        }
        return flavourText
    }
    
    
    public func getDetailCard(onGetCardCompleted : @escaping (_ responseCode : String) -> Void){
        self.isFetchDetailCard = true
        let cardID = self.arguments?.cardID!
        self.pokemonService.getDetailCard(cardId: cardID, onComplete: {
            (resultDTO) -> Void in
            guard let resultData = resultDTO else{return}
            if (resultData.error != nil){
                guard let error = resultData.error else {return}
                onGetCardCompleted(error.message ?? "")
                return
            }
            
            guard let cardData = resultData.data else{
                onGetCardCompleted("DATA Not Found")
                return
            }
            
            self.selectedCard = cardData
            
            onGetCardCompleted("OK")
            
            return
        })
    }
    
    public func loadOtherCards(onSearchCompleted : @escaping (_ responseCode : String) -> Void){
        self.isFetchingData = true
        let subTypeVal = self.arguments!.subType ?? ""
        let typeVal = self.arguments!.type ?? ""
        self.pokemonService.loadOtherCard(subtypes: subTypeVal, types: typeVal,selectedPage: self.cardsPage, onComplete: {
            (resultDTO) -> Void in
            self.isFetchingData = false
            if(resultDTO != nil || resultDTO?.data != nil){
                self.pokemonCards = resultDTO!.data!
                onSearchCompleted("OK")
            }else{
                onSearchCompleted("Not Found")
            }
        })
    }
    
    public func loadMore(onSearchCompleted : @escaping (_ responseCode : String) -> Void){
        self.isFetchingData = true
        let subTypeVal = self.arguments!.subType ?? ""
        let typeVal = self.arguments!.type ?? ""
        self.pokemonService.loadOtherCard(subtypes: subTypeVal, types: typeVal,selectedPage: self.cardsPage, onComplete: {
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
}
