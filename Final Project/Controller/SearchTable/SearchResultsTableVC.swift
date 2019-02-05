//
//  SearchResultsTableVC.swift
//  Final Project
//
//  Created by Joe Boisse on 11/24/18.
//  Copyright © 2018 Joe Boisse. All rights reserved.
//

import UIKit

class SearchResultsTableVC: MainTableViewController, UISearchControllerDelegate, UISearchBarDelegate{
    
    let model = RecipeModel()
    let searchController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //initialize notification center and add observers
        let center = NotificationCenter.default
        center.addObserver(self, selector: #selector(SearchResultsTableVC.dataDownloaded(notification:)), name: Notification.Name.RecipeDataDownloaded, object: nil)
        center.addObserver(self, selector: #selector(SearchResultsTableVC.imageDataDownloaded(notification:)), name: Notification.Name.ImageDataDownloaded, object: nil)
        
        //search bar default values and declarations
        //searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        tableView.tableHeaderView = searchController.searchBar
        searchController.searchBar.showsCancelButton = false
        searchController.searchBar.showsSearchResultsButton = false
        searchController.dimsBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        self.definesPresentationContext = true
      
    }
    
    //MARK: - Observers (code taken from Top Apps: AppsTableViewController)
    //What is this doing exactly???????????????????????????????????????????
    @objc func dataDownloaded(notification:Notification) {
        let block = {
            self.tableView.reloadData()
            self.refreshControl?.endRefreshing()
        }
        DispatchQueue.main.async(execute: block)
    }
    @objc func imageDataDownloaded(notification:Notification) {
        if let userInfo = notification.userInfo {
            let row = userInfo["row"] as! Int
            let indexPaths = [IndexPath(row: row, section:0)]
            let block = {self.tableView.reloadRows(at: indexPaths, with: .automatic)}
            DispatchQueue.main.async(execute: block)
        }
    }
    
    //Mark: - Menu Action
    @IBAction func showMenu(){
        NotificationCenter.default.post(name: NSNotification.Name("ToggleMenu"), object: nil)
    }
    
    
    //MARK: - Search Bar Functions
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        if searchController.searchBar.showsCancelButton {
            searchController.searchBar.showsCancelButton = false
        }
        else{
            searchController.searchBar.showsCancelButton = true
        }
        if searchController.searchBar.showsSearchResultsButton{
            searchController.searchBar.showsSearchResultsButton = false
        }
        else
        {
            searchController.searchBar.showsSearchResultsButton = true
        }
        
        let entry = searchController.searchBar.text!
        if entry == "" {
            self.tableView.reloadData()
        }
        else {
            model.search = entry
            model.performSearch()
            self.tableView.reloadData()
        }
    }
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return model.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath)
        
        cell.textLabel?.text = model.recipeTitle(at: indexPath.row)
        cell.detailTextLabel?.text = model.recipePublisher(at: indexPath.row)
        cell.accessoryType = .disclosureIndicator
        
       if let imageData = model.recipeImageData(at: indexPath.row),
            let image = UIImage(data: imageData) {
            cell.imageView?.image = image
            cell.imageView?.contentMode = .scaleAspectFit
        }
        
        return cell
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier! {
        case "RecipeSegue":
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let controller = segue.destination as! RecipeViewController
                let title = model.recipeTitle(at: indexPath.row)
                let sourceURL = model.recipeURL(at: indexPath.row)
                let ingredients = model.recipeIngredients(at: indexPath.row)
                let publisher = model.recipePublisher(at: indexPath.row)
                if let imageData = model.recipeImageData(at: indexPath.row),
                     let image = UIImage(data: imageData) {
                    controller.configure(title: title, url: sourceURL, ingredients: ingredients, image: image, publisher: publisher)
                
                }
                else{
                     let image = UIImage(imageLiteralResourceName: "noImage")
                     controller.configure(title: title, url: sourceURL, ingredients: ingredients, image: image, publisher: publisher)
                }
            }
        default:
            assert(false, "Unhandled Segue")
        }
        
    }
    
    

}
