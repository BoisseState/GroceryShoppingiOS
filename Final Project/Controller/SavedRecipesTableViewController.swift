//
//  SavedRecipesTableViewController.swift
//  Final Project
//
//  Created by Joe Boisse on 12/8/18.
//  Copyright © 2018 Joe Boisse. All rights reserved.
//

import UIKit
import CoreData


class SavedRecipesTableViewController: MainTableViewController {

    let model = RecipeModel()
    var myRecipes : [RecipeCD] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        model.fetchRecipes()
        myRecipes = model.savedRecipes
        self.tableView.reloadData()
    
    }
   

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return myRecipes.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath)
        
        cell.textLabel?.text = myRecipes[indexPath.row].name
        cell.detailTextLabel?.text = myRecipes[indexPath.row].publisher
        cell.accessoryType = .disclosureIndicator
        
        let imageData = myRecipes[indexPath.row].imageData
        let image = UIImage(data: imageData! as Data)
        cell.imageView?.image = image
        cell.imageView?.contentMode = .scaleAspectFit
    
        return cell
    }
    
     override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]?{
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete"){action, index in self.deleteCell(indexPath)}
        /*let scheduleAction = UITableViewRowAction(style: .normal, title: "Schedule"){action, index in self.scheduleCellSegue(indexPath)}
        return [scheduleAction, deleteAction]*/
        return[deleteAction]
    }
    
    func scheduleCellSegue(_ index:IndexPath){
        let recipe = myRecipes[index.row]
        self.performSegue(withIdentifier: "ChooseDate", sender: recipe)
        
    }
    
    func scheduleCell(recipe: RecipeCD){
        
    }
    
    
     func deleteCell(_ index:IndexPath){
        self.model.deleteRecipe(atIndex: index.row)
        self.model.fetchRecipes()
        myRecipes = self.model.savedRecipes
        self.tableView.deleteRows(at: [index], with: UITableView.RowAnimation.automatic)
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier! {
        case "RecipeSegue":
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let controller = segue.destination as! RecipeViewController
                let title = myRecipes[indexPath.row].name
                let sourceURL = myRecipes[indexPath.row].url
                let ingredients = myRecipes[indexPath.row].ingredients as! [String]
                let publisher = myRecipes[indexPath.row].publisher
                let imageData = myRecipes[indexPath.row].imageData! as Data
                let image = UIImage(data: imageData)
                controller.configure(title: title!, url: sourceURL!, ingredients: ingredients, image: image!, publisher: publisher!)
            }
        case "ChooseDate":
            let recipe = sender as! RecipeCD
            let controller = segue.destination as! CalendarVC
            controller.configure(recipe: recipe, set: 1)
            
        default:
            assert(false, "Unhandled Segue")
        }
        
    }
    
    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
