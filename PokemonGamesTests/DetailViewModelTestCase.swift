//
//  DetailViewModelTestCase.swift
//  PokemonGamesTests
//
//  Created by noverio joe on 16/02/22.
//

import XCTest
@testable import PokemonGames

class DetailViewModelTestCase: XCTestCase {
    let mainViewModel = MainViewModel()
    let detailviewModel = DetailCardViewModel()
    
    func testOpenDetailCard(){
        
        let expectation = expectation(description: "Open Detail Card when pick up one card after search")
        
        self.mainViewModel.searchText = "Snorlax"
        self.mainViewModel.searchPokemon(onSearchCompleted: {
            (resultMessage) -> Void in
            print("TEST SEARCH RESULT "+resultMessage)
            
            XCTAssertEqual(resultMessage, "OK")
            XCTAssertTrue(self.mainViewModel.pokemonCardsCount > 0, "SEARCH POKEMON CARD SUCCEED")
            
            let selectedCard = self.mainViewModel.pokemonCards![0]
            let type = selectedCard!.types!.first ?? ""
            let subtype = selectedCard!.subtypes!.first ?? ""
            
            self.detailviewModel.arguments = DetailCardArgs(cardID: selectedCard!.id ?? "", subType: subtype, type: type)
            
            self.detailviewModel.getDetailCard(onGetCardCompleted:{
                (resultMessage) -> Void in
                print("TEST GET DETAIL RESULT "+resultMessage)
                
                XCTAssertEqual(resultMessage, "OK")
                XCTAssertTrue(self.detailviewModel.selectedCard != nil, "GET Pokemon Card Succeed")
                expectation.fulfill()
            })
        })
        
        waitForExpectations(timeout: 30) { error in
             if let error = error {
               XCTFail("waitForExpectationsWithTimeout errored: \(error)")
             }
           }
    }

}
