//
//  DetailViewController.swift
//  RecipePuppy
//
//  Created by mnu on 30/11/2018.
//  Copyright © 2018 mundaco.com. All rights reserved.
//

import UIKit
import StringExtensionHTML

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
            
            imgThumbnail.image = recipe!.thumbnailData == nil ? nil : UIImage(data: (recipe!.thumbnailData)!)
            lblTitle.text = recipe!.title
            lblIngredients.text = "Ingredients: \n" + (recipe!.ingredients.replacingOccurrences(of: ", ", with: "\n"))
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
