//
//  Flow.swift
//  RecipePuppy
//
//  Created by mnu on 05/12/2018.
//  Copyright © 2018 mundaco.com. All rights reserved.
//

protocol RecipeListPresenterView {
    
    func listChanged()
}

class RecipeListPresenter: APIClientDelegate {
    
    private var view: RecipeListPresenterView?
    
    // MARK: - API
    private var api: APIClient?
    
    var request = RecipePuppyRequest(search: "")
    var recipeList: [Recipe] = []
    var lastPage: Bool = true
    
    init(view: RecipeListPresenterView) {
        
        self.view = view
        
        // Initialize the API Client
        api = APIClient(delegate: self)
        
    }
    
    var page: Int {
        get {
            return request.page
        }
        set {
            request.page = newValue
        }
    }
    
    var search: String {
        get {
            return request.query
        }
        set {
            request.query = newValue
        }
    }
    
    var recipeCount: Int {
        get {
            return recipeList.count
        }
    }
    
    func recipe(at row: Int) -> Recipe? {
        if(row >= recipeList.count) {
            return nil
        } else {
            return recipeList[row]
        }
    }
    
    func searchRecipe(text: String) {
        request.query = text
        request.page = 1
        if(text.count == 0) {
            recipeList = []
            lastPage = true
            view!.listChanged()
        } else {
            self.api!.sendRequest(RecipePuppyResult.self, params: request.toQueryString())
        }
    }
    
    func pageUp() {
        if(recipeList.count > 0) {
            request.page += 1
            self.api!.sendRequest(RecipePuppyResult.self, params: request.toQueryString())
        }
    }
    
    func pageDown() {
        if(request.page > 1) {
            request.page -= 1
            self.api!.sendRequest(RecipePuppyResult.self, params: request.toQueryString())
        }
    }
    func onAPIResponse(response: Any) {
    
        guard let result = response as? RecipePuppyResult else {
            return
        }
        let aux: [Recipe] = .map(recipes: result.results)
        lastPage = (aux.count == 0)
        if(lastPage) {
            if(page > 1) {
                request.page -= 1
            } else {
                recipeList = []
            }
        } else {
            recipeList = aux
        }
        view!.listChanged()
    }
    
    func getDetailPresenter(for row: Int) -> RecipeDetailPresenter {
        return RecipeDetailPresenter(with: recipe(at: row)!)
    }
}
