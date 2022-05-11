//
//  PokemonServices.swift
//  PokemonGames
//
//  Created by noverio joe on 13/02/22.
//

import UIKit



class PokemonServices : BasicAPIRequestServices {
    override init() {
        super.init()
        self.baseUrl = "https://api.pokemontcg.io/v2"
    }
    
    public func searchPokemonWithKeyword(keyword : String?, selectedPage : Int?, onComplete : @escaping (SearchCardDTO?) -> Void){
        let page = selectedPage != nil && selectedPage! > 0 ? selectedPage : 1
        let limiter = "&page=" + String(page!) + "&pageSize=10"
        let query = keyword != nil ? "q=name:" + keyword! : "q=name:*"
        let resourceEndpoint = self.baseUrl + "/cards?" + query + "" + limiter
        let apiGetRequest = self.getBasicGETAuthRequest(withEndpointUrl: resourceEndpoint)
        
        NetworkingObject.sharedManager().performRequest(withHTTPRequest: apiGetRequest) {  (resultData) -> Void in
            print (resultData)
            if (resultData is String){
                onComplete(nil)
                return
            }
            let responseObject = SearchCardDTO(JSONString: Serializer.toJsonString(from: resultData), context: nil)
            
            onComplete(responseObject!)
            return
        }
    }
    
    public func getDetailCard(cardId : String!, onComplete : @escaping (GetCardDTO?) -> Void){
        let query = "/"+cardId
        let resourceEndpoint = self.baseUrl + "/cards" + query
        let apiGetRequest = self.getBasicGETAuthRequest(withEndpointUrl: resourceEndpoint)
        
        NetworkingObject.sharedManager().performRequest(withHTTPRequest: apiGetRequest) {  (resultData) -> Void in
            print (resultData)
            if (resultData is String){
                onComplete(nil)
                return
            }
            let responseObject = GetCardDTO(JSONString: Serializer.toJsonString(from: resultData), context: nil)
            
            onComplete(responseObject!)
            return
        }
    }
    
    public func loadOtherCard(subtypes : String!, types : String!, selectedPage : Int?, onComplete : @escaping (SearchCardDTO?) -> Void){
        let page = selectedPage != nil && selectedPage! > 0 ? selectedPage : 1
        let limiter = "&page=" + String(page!) + "&pageSize=10"
        let query = "subtypes:"+subtypes+" -types:"+types
        let resourceEndpoint = self.baseUrl + "/cards?q="+query+limiter
        let apiGetRequest = self.getBasicGETAuthRequest(withEndpointUrl: resourceEndpoint)
        
        NetworkingObject.sharedManager().performRequest(withHTTPRequest: apiGetRequest) {  (resultData) -> Void in
            print (resultData)
            if (resultData is String){
                onComplete(nil)
                return
            }
            let responseObject = SearchCardDTO(JSONString: Serializer.toJsonString(from: resultData), context: nil)
            
            onComplete(responseObject!)
            return
        }
    }
}
