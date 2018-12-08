//
//  RecipeListViewController.swift
//  RecipePuppy
//
//  Created by mnu on 29/11/2018.
//  Copyright © 2018 mundaco.com. All rights reserved.
//

import UIKit

class RecipeListViewController: UIViewController, RecipeListPresenterView, UITableViewDataSource  {
    
    // MARK: - Connectors
    @IBOutlet weak var tblRecipes: UITableView!
    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var btnPrevPage: UIButton!
    @IBOutlet weak var btnNextPage: UIButton!
    @IBOutlet weak var lblPage: UILabel!
    
    // MARK: - Presenter
    var presenter: RecipeListPresenter!
    
    // MARK: -
    var timer: Timer!
    
    // MARK: - Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = RecipeListPresenter(view: self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // Show the keyboard when the view appears
        txtSearch.becomeFirstResponder()
    }

    func listChanged() {
        
        // Refresh the UI on the main thread
        DispatchQueue.main.async {
            self.updateUI()
        }
    }
    
    func updateUI () {
        if(presenter!.recipeCount == 0) {
            lblPage.text = "No results"
            btnPrevPage.isEnabled = false
            btnNextPage.isEnabled = false
        } else {
            lblPage.text = "Page \(String(presenter!.page))"
            btnPrevPage.isEnabled = presenter!.page > 1
            btnNextPage.isEnabled = !presenter!.lastPage
        }
        tblRecipes.reloadData()
    }
    
    @IBAction func txtSearch_ValueChanged(_ sender: UITextField) {
        
        // Wait for the user to stop typing for 1 second before refreshing the presenter
        if(timer != nil) {
            timer.invalidate()
        }
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { (timer) in
            self.presenter!.searchRecipe(text: sender.text!)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter!.recipeCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Get the cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellRecipe", for: indexPath)
        
        // Get the recipe for this cell
        let recipe: Recipe = presenter!.recipe(at: indexPath.row)!
        
        // Set the cell title
        let cellTitle: UILabel = cell.contentView.subviews[0] as! UILabel
        cellTitle.text = recipe.title
        
        // Set the cell image
        let cellImage: UIImageView = cell.contentView.subviews[1] as! UIImageView
        cellImage.image = recipe.thumbnailData == nil ? nil : UIImage(data: recipe.thumbnailData!)
        
        return cell
    }
    
    
    @IBAction func btnPrevPage_Touched(_ sender: UIButton) {
        
        presenter!.pageDown()
    }
    
    @IBAction func btnNextPage_Touched(_ sender: UIButton) {
        
        presenter!.pageUp()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.destination is RecipeDetailViewController
        {
            let detailViewController  = segue.destination as! RecipeDetailViewController
            
            // Set the presenter of the detail view
            detailViewController.presenter = presenter!.getDetailPresenter(for: tblRecipes.indexPathForSelectedRow!.row)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

