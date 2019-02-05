//
//  RecipeViewController.swift
//  Final Project
//
//  Created by Joe Boisse on 12/4/18.
//  Copyright © 2018 Joe Boisse. All rights reserved.
//

import UIKit

class RecipeViewController: UIViewController {

    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var recipeName: UITextView!
    
    @IBOutlet weak var textView: UITextView!
    
    let model = RecipeModel()
    var recipeURL : String?
    var recipeTitle : String?
    var recipeIngredients: [String]?
    
    var recipeImage : UIImage?
    var recipePublisher : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recipeImageView.image = recipeImage!
        recipeImageView.contentMode = .scaleAspectFit
        recipeName.text = recipeTitle
        let count = recipeIngredients!.count
        var ingredients = "Ingredients:\n\n"
        for i in 0..<count{
            let ingredient = recipeIngredients![i]
            ingredients = ingredients+"* \(ingredient)\n"
        }
        textView.text = ingredients
    }
    
    func configure(title:String, url:String, ingredients:[String], image:UIImage, publisher:String){
        recipeTitle = title
        recipeURL = url
        recipeIngredients = ingredients
        recipeImage = image
        recipePublisher = publisher
       
    }
    
    @IBAction func saveRecipe(_ sender: Any) {
        model.fetchRecipes()
        let myRecipes = model.savedRecipes
        for recipe in myRecipes{
            if recipe.url == recipeURL{
                let prompt = "Recipe is already saved"
                let alertView = UIAlertController(title: prompt, message: nil, preferredStyle: .alert)
                let action = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
                alertView.addAction(action)
                self.present(alertView, animated: true, completion: nil)
                return
            }
        }
        let recipe = RecipeCD(context: DataManager.context)
        recipe.historyDates = nil
        recipe.scheduledDates = nil
        recipe.name = recipeTitle
        recipe.publisher = recipePublisher
        recipe.url = recipeURL
        recipe.ingredients = recipeIngredients! as NSObject
        let imageData = recipeImage!.pngData()! as NSData
        recipe.imageData = imageData
        DataManager.saveContext()
        model.savedRecipes.append(recipe)
        
    }
    
    // MARK: - Segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier! {
             case "WebSegue":
                 let controller = segue.destination as! RecipeWebViewController
                 controller.configure(title: recipeTitle!, url: recipeURL!)
            default:
                assert(false, "Unhandled Segue")
            }
    }
            

}
