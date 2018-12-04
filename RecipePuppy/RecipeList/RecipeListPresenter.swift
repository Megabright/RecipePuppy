//
//  RecipeListPresenter.swift
//  RecipePuppy
//
//  Created by mnu on 04/12/2018.
//  Copyright © 2018 mundaco.com. All rights reserved.
//

import Foundation

protocol RecipeListPresenterDelegate {
    func listChanged()
}

class RecipeListPresenter: JsonAPIConnectorDelegate {
    
    // MARK: - Delegate
    private var delegate: RecipeListPresenterDelegate
    
    // MARK: - API
    private var api: JsonAPIConnector?
    
    // MARK: - Model
    private var recipePuppyRequest = RecipePuppyRequest(search: "")
    private var recipePuppyResult: RecipePuppyResult? = nil
    
    // MARK: - Properties
    var totalPages: Int = Int.max
    
    //MARK: - Functions
    init(delegate: RecipeListPresenterDelegate) {
        
        self.delegate = delegate
        
        // The API URL is stored AppSettings.strings
        let appSettings = NSDictionary(contentsOfFile: Bundle.main.path(forResource: "AppSettings", ofType: "strings")!)
        
        // Initialize the API connector with the API URL
        api = JsonAPIConnector(with: appSettings!["API_URL"] as! String, delegate: self)
    }
    
    func searchRecipe(name: String) {
        
        // Set the request query text
        recipePuppyRequest.query = name
        
        // Send the request to the API
        api!.sendRequest(params: recipePuppyRequest.toQueryString())
    }
    
    var recipeCount: Int {
        
        // If the query is empty we return 0 results
        return recipePuppyRequest.query.count == 0 ? 0 : recipePuppyResult!.results.count
    }
    
    func recipe(at row: Int) -> RecipePuppy {
        return recipePuppyResult!.results[row]
    }
    
    var page: Int {
        return recipePuppyRequest.page
    }
    
    func pageUp() {
        
        // Increase the page number in the request
        recipePuppyRequest.page += 1
        
        // Send the request to the API
        api!.sendRequest(params: recipePuppyRequest.toQueryString())
    }
    
    func pageDown() {
        
        // Decrease the page number in the request
        recipePuppyRequest.page -= 1
        
        // Send the request to the API
        api!.sendRequest(params: recipePuppyRequest.toQueryString())
    }
    
    func onAPIResponse(response: [String : Any]) {
        
        // If the result is empty and we are not on the first page, we found the last page
        let aux = RecipePuppyResult(fromJson: response)
        if(aux!.results.count == 0) && (recipePuppyRequest.page > 1) {
            recipePuppyRequest.page -= 1
            totalPages = recipePuppyRequest.page
        }
        else {
            recipePuppyResult = aux
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
