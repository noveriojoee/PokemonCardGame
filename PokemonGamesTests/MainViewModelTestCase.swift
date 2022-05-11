//
//  MainViewModel.swift
//  PokemonGamesTests
//
//  Created by noverio joe on 16/02/22.
//

import XCTest
@testable import PokemonGames

class MainViewModelTestCase: XCTestCase {
    let viewModel = MainViewModel()
    func setupTestCase(){
        viewModel.searchText = "Pikachu"
    }
    
    func testSearch() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.

        let expectation = expectation(description: "Search Pokemon result are pumping to pokemon cards list")

        setupTestCase()
        viewModel.searchPokemon(onSearchCompleted: {
            (resultDTO) -> Void in
            print("TEST SEARCH RESULT "+resultDTO)
            
            XCTAssertEqual(resultDTO, "OK")
            XCTAssertTrue(self.viewModel.pokemonCardsCount > 0, "SEARCH POKEMON CARD SUCCEED")
            
            expectation.fulfill()
        })
        
        waitForExpectations(timeout: 30) { error in
             if let error = error {
               XCTFail("waitForExpectationsWithTimeout errored: \(error)")
             }
           }
    }
    
    func testSearchWithoutKeyword() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.

        let expectation = expectation(description: "Searching pokemon with space keyword, should return pikachu list anyway")

        viewModel.searchText = nil
        viewModel.searchPokemon(onSearchCompleted: {
            (resultDTO) -> Void in
            print("TEST SEARCH RESULT "+resultDTO)
            
            XCTAssertEqual(resultDTO, "OK")
            XCTAssertTrue(self.viewModel.pokemonCardsCount > 0, "SEARCH POKEMON CARD SUCCEED")
            
            expectation.fulfill()
        })
        
        waitForExpectations(timeout: 30) { error in
             if let error = error {
               XCTFail("waitForExpectationsWithTimeout errored: \(error)")
             }
           }
    }
    
    func testSearchWithoutSpaceKeyword() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.

        let expectation = expectation(description: "Searching pokemon with space keyword, should return pikachu list anyway")

        viewModel.searchText = "Pika Ch u"
        viewModel.searchPokemon(onSearchCompleted: {
            (resultDTO) -> Void in
            print("TEST SEARCH RESULT "+resultDTO)
            
            XCTAssertEqual(resultDTO, "OK")
            XCTAssertTrue(self.viewModel.pokemonCardsCount > 0, "SEARCH POKEMON CARD SUCCEED")
            
            expectation.fulfill()
        })
        
        waitForExpectations(timeout: 30) { error in
             if let error = error {
               XCTFail("waitForExpectationsWithTimeout errored: \(error)")
             }
           }
    }
    
    func testLoadMoreWithoutSearch() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let expectation = expectation(description: "Load More Pokemon result are appending to pokemon cards list eventhought have not search first")
        setupTestCase()
        viewModel.loadMore(onSearchCompleted: {
            (resultDTO) -> Void in
            
            print("TEST LOAD MORE RESULT"+resultDTO)
            
            XCTAssertEqual(resultDTO, "OK")
            XCTAssertTrue(self.viewModel.pokemonCardsCount > 0, "SEARCH POKEMON CARD SUCCEED")
            
            expectation.fulfill()
        })
        
        waitForExpectations(timeout: 30) { error in
             if let error = error {
               XCTFail("waitForExpectationsWithTimeout errored: \(error)")
             }
           }
    }
    
    func testLoadMoreWithSearchFirst() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let expectation = expectation(description: "Load More Pokemon result are appending to pokemon cards list after have doing search")
        setupTestCase()
        viewModel.searchPokemon(onSearchCompleted: {
            (resultDTO) -> Void in
            print("TEST SEARCH RESULT "+resultDTO)
            
            XCTAssertEqual(resultDTO, "OK")
            XCTAssertTrue(self.viewModel.pokemonCardsCount > 0, "SEARCH POKEMON CARD SUCCEED")
            
            self.viewModel.cardsPage += 1 // move the page
            
            let currentCardCount = self.viewModel.pokemonCardsCount
            
            self.viewModel.loadMore(onSearchCompleted: {
                (resultDTO) -> Void in
                
                print("TEST LOAD MORE RESULT"+resultDTO)
                
                XCTAssertEqual(resultDTO, "OK")
                XCTAssertTrue(self.viewModel.pokemonCardsCount > currentCardCount, "SEARCH POKEMON CARD SUCCEED")
                
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
