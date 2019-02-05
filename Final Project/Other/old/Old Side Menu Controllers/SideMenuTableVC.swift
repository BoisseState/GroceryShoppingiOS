//
//  SideMenuTableVC.swift
//  Side Menu Test
//
//  Created by Joe Boisse on 11/24/18.
//  Copyright © 2018 Joe Boisse. All rights reserved.
//

import UIKit

class SideMenuTableVC: UITableViewController {

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NotificationCenter.default.post(name: NSNotification.Name.ToggleMenu, object: nil)
        
       
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier! {
        case "SavedSegue":
           print("Switched to Save Recipee\n")
        default:
            assert(false, "Unhandled Segue")
        }
        
    }
}
