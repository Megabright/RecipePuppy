//
//  RecipePuppyTests.swift
//  RecipePuppyTests
//
//  Created by mnu on 04/12/2018.
//  Copyright © 2018 mundaco.com. All rights reserved.
//

import XCTest
@testable import RecipePuppy

class RecipeListPresenterTests: XCTestCase {
    
    let view = RecipeListPresenterDelegateSpy()
    
    func test_emptySearch_returnsEmptyResults() {

        let sut = makeSUT(view: view)
        sut.recipeList = [testResult]

        view.resultsRefreshedExpectation = expectation(description: "ResultsRefreshed")
        
        sut.searchRecipe(text: "")
        
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertEqual(sut.recipeList.count, 0)
    }
    
    func test_emptySearch_resetsPageToOne() {
        
        let sut = makeSUT(view: view)
        
        sut.page = 2
        
        view.resultsRefreshedExpectation = expectation(description: "ResultsRefreshed")
        
        
        sut.searchRecipe(text: "")
        
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertEqual(sut.page,1)
    }
    
    func test_nonEmptySearch_resetsPageToOne() {
        
        let sut = makeSUT(view: view)
        
        sut.page = 2
        
        view.resultsRefreshedExpectation = expectation(description: "ResultsRefreshed")
        
        sut.searchRecipe(text: "hi")
        
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertEqual(sut.page,1)
    }
    
    func test_nonEmptySearch_WithNonEmptyResults_refreshesResults() {
        let sut = makeSUT(view: view)
        sut.recipeList = [testResult]
        
        view.resultsRefreshedExpectation = expectation(description: "ResultsRefreshed")
        
        sut.searchRecipe(text: "hi")
        
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertNotEqual(sut.recipeList[0].title, testResult.title)
    }
    
    func test_nonEmptySearch_WithEmptyResults_refreshesResults() {
        let sut = makeSUT(view: view)
        sut.recipeList = [testResult]
        
        view.resultsRefreshedExpectation = expectation(description: "ResultsRefreshed")
        
        sut.searchRecipe(text: "aba")
        
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertEqual(sut.recipeList.count, 0)
        
    }
    
    func test_pageUp_WithResults_refreshesResults() {
        
        let sut = makeSUT(view: view)
        
        sut.recipeList = [testResult]
        
        view.resultsRefreshedExpectation = expectation(description: "ResultsRefreshed")
        
        sut.pageUp()
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func test_pageUp_withEmptyResults_doesntRefreshResults() {
        let sut = makeSUT(view: view)
        
        view.resultsRefreshedExpectation = expectation(description: "ResultsRefreshed")
        view.resultsRefreshedExpectation?.isInverted = true
        
        sut.pageUp()
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func test_pageUp_withEmptyResults_doesntIncreasePage() {
        let sut = makeSUT(view: view)
        
        view.resultsRefreshedExpectation = expectation(description: "ResultsRefreshed")
        view.resultsRefreshedExpectation?.isInverted = true
        
        sut.pageUp()
        
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertEqual(sut.page, 1)
    }
    
    func test_pageUp_withNonEmptyResults_increasesPage() {
        let sut = makeSUT(view: view)
        sut.recipeList = [testResult]
        
        view.resultsRefreshedExpectation = expectation(description: "ResultsRefreshed")
        
        
        XCTAssertNotEqual(sut.recipeList.count, 0)
        
        sut.pageUp()
        
        waitForExpectations(timeout: 5, handler: nil)
        
        
        XCTAssertEqual(sut.page, 2)
    }
    
    func test_nonEmptySearch_withResults_setslastPageToFalse() {
        let sut = makeSUT(view: view)
        
        view.resultsRefreshedExpectation = expectation(description: "ResultsRefreshed")
        view.resultsRefreshedExpectation?.isInverted = false
        
        sut.searchRecipe(text: "hi")
        
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertFalse(sut.lastPage)
    }
    
    func test_nonEmptySearch_whenReturnsEmptyResults_setsLastPageToTrue() {
        let sut = makeSUT(view: view)
        
        sut.page = 100
        sut.recipeList = [testResult]
        
        view.resultsRefreshedExpectation = expectation(description: "ResultsRefreshed")
        
        sut.searchRecipe(text: "hiho")
        
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertTrue(sut.lastPage)
    }
    
    func test_pageUp_whenReturnsEmptyResults_setsLastPageToTrue() {
        let sut = makeSUT(view: view)
        sut.search = "hi"
        sut.page = 100
        sut.recipeList = [testResult]
        
        view.resultsRefreshedExpectation = expectation(description: "ResultsRefreshed")
        
        sut.pageUp()
        
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertTrue(sut.lastPage)
    }
    
    func test_pageUp_whenReturnsEmptyResults_doesntIncreasePage() {
        let sut = makeSUT(view: view)
        sut.search = "hi"
        sut.page = 100
        sut.recipeList = [testResult]
        
        view.resultsRefreshedExpectation = expectation(description: "ResultsRefreshed")
        
        sut.pageUp()
        
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertEqual(sut.page, 100)
    }
    
    func test_pageUp_whenReturnsEmptyResults_resultsDontChange() {
        let sut = makeSUT(view: view)
        sut.search = "ab"
        sut.page = 2
        sut.recipeList = [testResult]
        
        view.resultsRefreshedExpectation = expectation(description: "ResultsRefreshed")
        
        sut.pageUp()
        
        waitForExpectations(timeout: 5, handler: nil)
        
        if(sut.recipeList.count > 0) {
            XCTAssertEqual(sut.recipeList[0].title, testResult.title)
        } else {
            XCTFail()
        }
    }
    
    func test_pageDown_whenOnFirstPage_doesntRefreshResults() {
        let sut = makeSUT(view: view)
        sut.page = 1
        
        view.resultsRefreshedExpectation = expectation(description: "ResultsRefreshed")
        view.resultsRefreshedExpectation?.isInverted = true
        
        sut.pageDown()
        
        waitForExpectations(timeout: 5, handler: nil)
        
    }
    
    func test_pageDown_whenOnFirstPage_resultsDontChange() {
        let sut = makeSUT(view: view)
        sut.search = "hi"
        sut.page = 1
        sut.recipeList = [testResult]
        
        view.resultsRefreshedExpectation = expectation(description: "ResultsRefreshed")
        view.resultsRefreshedExpectation?.isInverted = true
        
        sut.pageDown()
        
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertEqual(sut.recipeList[0].title, testResult.title)
    }
    
    func test_pageDown_whenNotOnFirstPage_resultsDoChange() {
        let sut = makeSUT(view: view)
        sut.search = "hi"
        sut.page = 2
        sut.recipeList = [testResult]
        
        view.resultsRefreshedExpectation = expectation(description: "ResultsRefreshed")
        
        
        sut.pageDown()
        
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertNotEqual(sut.recipeList[0].title, testResult.title)
    }
    
    func test_resultCount_returnsTheResultCount() {
        let sut = makeSUT(view: view)
        sut.recipeList = [testResult]
        
        XCTAssertEqual(sut.recipeList.count, sut.recipeCount)
    }
    
    func test_getResultAtPostion_returnsResult() {
        let sut = makeSUT(view: view)
        sut.recipeList = [testResult]
        
        let result = sut.recipe(at: 0)!
        
        XCTAssertEqual(testResult.title, result.title)
    }
    
    func test_getResultAtPostionOutOfBounds_returnsNil() {
        let sut = makeSUT(view: view)
        sut.recipeList = [testResult]
        
        let result = sut.recipe(at: 1)
        
        XCTAssertNil(result)
        
    }
    
    // MARK: - Helpers
    let testResult = Recipe(with: "test", ingredients: "", thumbnail: "")
    
    func makeSUT(view: RecipeListPresenterView) -> RecipeListPresenter {
        return RecipeListPresenter(view: view)
    }
    
    class RecipeListPresenterDelegateSpy: RecipeListPresenterView {
        
        var resultsRefreshedExpectation:XCTestExpectation?
        
        func listChanged() {
            
            if(resultsRefreshedExpectation != nil) {
                resultsRefreshedExpectation!.fulfill()
            }
        }
    }
}


