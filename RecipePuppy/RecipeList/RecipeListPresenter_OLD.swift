//
//  RecipeListPresenter.swift
//  RecipePuppy
//
//  Created by mnu on 04/12/2018.
//  Copyright © 2018 mundaco.com. All rights reserved.
//

import Foundation

protocol RecipeListPresenterDelegate_OLD {
    func listChanged()
}

class RecipeListPresenter_OLD: APIClientDelegate {
    
    // MARK: - Delegate
    private var delegate: RecipeListPresenterDelegate_OLD
    
    // MARK: - API
    private var api: APIClient?
    
    // MARK: - Model
    private var request = RecipePuppyRequest(search: "")
    private var result: RecipePuppyResult? = nil
    
    // MARK: - Properties
    var totalPages: Int = Int.max
    
    //MARK: - Functions
    init(delegate: RecipeListPresenterDelegate_OLD) {
        
        self.delegate = delegate
        
        // Initialize the API Client
        api = APIClient(delegate: self)
    }
    
    func searchRecipe(name: String) {
        
        // Set the request query text
        request.query = name
        
        // Send the request to the API
        api!.sendRequest(params: request.toQueryString())
    }
    
    var recipeCount: Int {
        
        // If the query is empty we return 0 results
        return request.query.count == 0 ? 0 : result!.results.count
    }
    
    func recipe(at row: Int) -> RecipePuppy {
        return result!.results[row]
    }
    
    var page: Int {
        return request.page
    }
    
    func pageUp() {
        
        // Increase the page number in the request
        request.page += 1
        
        // Send the request to the API
        api!.sendRequest(params: request.toQueryString())
    }
    
    func pageDown() {
        
        // Decrease the page number in the request
        request.page -= 1
        
        // Send the request to the API
        api!.sendRequest(params: request.toQueryString())
    }
    
    func onAPIResponse(response: [String : Any]) {
        
        // If the result is empty and we are not on the first page, we found the last page
        let aux = RecipePuppyResult(fromJson: response)
        if(aux!.results.count == 0) && (request.page > 1) {
            request.page -= 1
            totalPages = request.page
        }
        else {
            result = aux
            totalPages = Int.max
        }
        
        DispatchQueue.main.async {
            self.delegate.listChanged()
        }
    }
    
    func getDetailPresenter(for row: Int) -> RecipeDetailPresenter {
        return RecipeDetailPresenter(with: recipe(at: row))
    }
}
