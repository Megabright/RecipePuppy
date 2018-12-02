//
//  DetailViewController.swift
//  RecipePuppy
//
//  Created by mnu on 30/11/2018.
//  Copyright © 2018 mundaco.com. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController  {

    // Connectors
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblIngredients: UILabel!
    @IBOutlet weak var imgThumbnail: UIImageView!
    
    //Model
    var recipe: RecipePuppy? = nil
    
    // Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
    }
    
    func updateUI() {
        if(recipe != nil) {
            lblTitle.text = recipe?.title
            lblIngredients.text = "Ingredients: \n" + (recipe?.ingredients.replacingOccurrences(of: ", ", with: "\n"))!
            if(recipe?.thumbnail != "") {
                do {
                    let imageData: Data = try Data(contentsOf: URL(string: (recipe?.thumbnail)!)!)
                    imgThumbnail.image = UIImage(data: imageData)
                } catch {
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
