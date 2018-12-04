//
//  RecipeDetailViewController.swift
//  RecipePuppy
//
//  Created by mnu on 30/11/2018.
//  Copyright © 2018 mundaco.com. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController  {

    // MARK: - Connectors
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblIngredients: UILabel!
    @IBOutlet weak var imgThumbnail: UIImageView!
    
    // MARK: - Presenter
    var presenter: RecipeDetailPresenter?
    
    // MARK: - Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
    }
    
    func updateUI() {
        
        imgThumbnail.image = presenter!.thumbnailData == nil ? nil : UIImage(data: presenter!.thumbnailData!)
        lblTitle.text = presenter!.title
        lblIngredients.text = "Ingredients: \n" + (presenter!.ingredients.replacingOccurrences(of: ", ", with: "\n"))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
