//
//  ViewController.swift
//  RecipePuppy
//
//  Created by mnu on 29/11/2018.
//  Copyright © 2018 mundaco.com. All rights reserved.
//

import UIKit

class ViewController: UIViewController, JsonAPIConnectorDelegate, UITableViewDataSource  {
    
    // Connectors
    @IBOutlet weak var tblRecipes: UITableView!
    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var btnPrevPage: UIButton!
    @IBOutlet weak var btnNextPage: UIButton!
    @IBOutlet weak var lblPage: UILabel!
    
    // Model
    var api: JsonAPIConnector?
    var recipePuppyRequest = RecipePuppyRequest(search: "")
    var recipePuppyResult: RecipePuppyResult? = nil
    
    // Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // The API URL is stored AppSettings.strings
        let appSettings = NSDictionary(contentsOfFile: Bundle.main.path(forResource: "AppSettings", ofType: "strings")!)
        
        // Initialize the API connector with the API URL
        api = JsonAPIConnector(withApiURL: appSettings!["API_URL"] as! String, delegate: self)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // Show the keyboard when the view appears
        txtSearch.becomeFirstResponder()
    }

    func onAPIResponse(response: [String: Any]) {
        
        // Map the Json response from the API into a RecipePuppyResult class
        recipePuppyResult = RecipePuppyResult(fromJson: response)
        
        
        // Refresh the UI in the main thread
        DispatchQueue.main.async {
            self.updateUI()
        }
    }
    
    func updateUI () {
        if(recipePuppyResult == nil || recipePuppyResult?.results.count == 0) {
            if(recipePuppyRequest.page > 1) {
                lblPage.text = "End of results"
                btnPrevPage.isEnabled = true
                btnNextPage.isEnabled = false
            } else {
                lblPage.text = "No results"
                btnPrevPage.isEnabled = false
                btnNextPage.isEnabled = false
            }
        } else {
            lblPage.text = "Page \(String(recipePuppyRequest.page))"
            btnPrevPage.isEnabled = recipePuppyRequest.page > 1
            btnNextPage.isEnabled = true
        }
        tblRecipes.reloadData()
    }
    
    @IBAction func txtSearch_ValueChanged(_ sender: UITextField) {
        
        if(sender.text == "") {
            
            // If the search box is empty show no results
            recipePuppyResult = nil
            updateUI()
            
        } else {
            
            // Set the request query text
            recipePuppyRequest.query = sender.text!
            
            // Send the request to the API
            api?.sendRequest(params: recipePuppyRequest.toQueryString())
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard recipePuppyResult != nil else {
            return 0
        }
        return (recipePuppyResult?.results.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Get the cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellRecipe", for: indexPath)
        
        // Get the recipe for this cell
        let recipe: RecipePuppy = (recipePuppyResult?.results[indexPath.row])!
        
        // Set the cell title
        let cellTitle: UILabel = cell.contentView.subviews[0] as! UILabel
        cellTitle.text = recipe.title
        
        // Set the cell image
        let cellImage: UIImageView = cell.contentView.subviews[1] as! UIImageView
        cellImage.image = recipe.thumbnailData == nil ? nil : UIImage(data: recipe.thumbnailData!)
        
        return cell
    }
    
    
    @IBAction func btnPrevPage_Touched(_ sender: UIButton) {
        
        // Decrease the page number in the request
        self.recipePuppyRequest.page -= 1
        
        // Send the request to the API
        api?.sendRequest(params: recipePuppyRequest.toQueryString())
    }
    
    @IBAction func btnNextPage_Touched(_ sender: UIButton) {
        
        // Increase the page number in the request
        self.recipePuppyRequest.page += 1
        
        // Send the request to the API
        api?.sendRequest(params: recipePuppyRequest.toQueryString())
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.destination is DetailViewController
        {
            let detailViewController  = segue.destination as! DetailViewController
            
            // Set the recipe to show in the DetailViewController
            detailViewController.recipe = recipePuppyResult?.results[(tblRecipes.indexPathForSelectedRow?.row)!]
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

