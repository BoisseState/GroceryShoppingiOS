//
//  RecipeModel.swift
//  Final Project
//
//  Created by Joe Boisse on 11/24/18.
//  Copyright © 2018 Joe Boisse. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class RecipeModel{
    
    var currentRecipes = [RecipeInfo]()
    var savedRecipes = [RecipeCD]()
    var scheduledRecipes = [RecipeCD]()
    
    var count : Int = 0
    let baseURL = "https://api.edamam.com/search?q="
    let key = "&app_id=a0a11cff&app_key=8c3283d1a2cb00530674e1b9f7906ef9&"
    var low = 0
    var high = 20
    var range : String
    var search = "Dinner"
    var mainURL : String
    //let temp = "https://api.edamam.com/search?q=Dinner&app_id=a0a11cff&app_key=8c3283d1a2cb00530674e1b9f7906ef9&from=0&to=20"
    init(){
        self.range = "from=\(low)&to=\(high)"
        self.mainURL = baseURL + search + key + range
        performSearch()
    }
    
    // Use Operations and OperationQueues to download everything, including images
    func performSearch(){
        //let mainBundle = Bundle.main
        //let solutionURL = mainBundle.url(forResource: "edamam_chicken", withExtension: "json")
        //let url = solutionURL!
        let urlSearch = search.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        mainURL = baseURL + urlSearch! + key + range
        let url = URL(string: mainURL)!
        let queue = OperationQueue()
        
        // operation to download the json & parse it, convert it to currentRecipes array
        let recipeOperation = BlockOperation {
            let data = try? Data(contentsOf: url)
            if let data = data {
                self.currentRecipes = self.getRecipes(data: data)
            }
        }
        
        recipeOperation.completionBlock = {
            let center = NotificationCenter.default
            center.post(name: NSNotification.Name.RecipeDataDownloaded, object: self)
        }
        
        let imageOperation = BlockOperation {
            for recipe in self.currentRecipes {
                let url = URL(string: recipe.imageURL)!
                let data = try? Data(contentsOf: url)
                recipe.imageData = data
            }
        }
        
        // when all images downloaded we can tell tableview controller to reload
        imageOperation.completionBlock = {
            let center = NotificationCenter.default
            center.post(name: NSNotification.Name.ImageDataDownloaded, object: self)
        }
        
        // images loaded only after json data
        imageOperation.addDependency(recipeOperation)
        
        queue.addOperation(recipeOperation)
        queue.addOperation(imageOperation)
        }
    
    
    func getRecipes(data:Data) -> [RecipeInfo] {
        var _currentRecipes : [RecipeInfo] = []
        let decoder = JSONDecoder()
        do {
            let decodedRecipes = try decoder.decode(RecipeData.self, from: data)
            let hits = decodedRecipes.hits
            count = hits.count
            for hit in hits {
                let recipe = hit.recipe
                let info = RecipeInfo.init(recipe: recipe)
                _currentRecipes.append(info)
            }
            
        } catch   {
            _currentRecipes = []
        }
        
        
        return _currentRecipes
    }
    
    func recipeTitle(at index:Int) -> String {
        return currentRecipes[index].title
    }
    
    func recipePublisher(at index:Int) -> String {
        return currentRecipes[index].publisher
    }
    
    func recipeURL(at index:Int) -> String {
        return currentRecipes[index].sourceURL
        
    }
    func recipeIngredients(at index:Int) -> [String] {
        return currentRecipes[index].ingredients
    }
    
    func scheduleRecipe(atIndex i:Int, date: Date){
        let recipeCD = savedRecipes[i]
        
        
       
        
    }
    func deleteRecipe(atIndex i:Int){
        let recipe = savedRecipes.remove(at: i)
        DataManager.context.delete(recipe)
        DataManager.saveContext()
    }
    
    func fetchRecipes () {
        let fetchRequest: NSFetchRequest<RecipeCD> = RecipeCD.fetchRequest()
        do{
            let fetchedRecipes = try DataManager.context.fetch(fetchRequest)
            savedRecipes = fetchedRecipes
        }
        catch{
            print("Failed to fetch Core Data")
            savedRecipes = []
        }
    }
    
    
   // func recipeImage(at index:Int) -> UIImage {}
    
    // lazy loading of images
    func recipeImageData(at index:Int) -> Data? {
        let recipe = currentRecipes[index]
        if let imageData = recipe.imageData {
            return imageData
        } else { //need to fetch the data
            let url = URL(string: recipe.imageURL)!
            let session = URLSession.shared
            let task = session.dataTask(with: url) { (data, response, error) in
                guard error == nil else {print(error!.localizedDescription); return}
                recipe.imageData = data
                let center = NotificationCenter.default
                let userInfo : [AnyHashable:Any] = ["row":index]
                center.post(name: Notification.Name.ImageDataDownloaded, object: nil, userInfo: userInfo)
            }
            task.resume()
            return nil
        }
    }
    
}
