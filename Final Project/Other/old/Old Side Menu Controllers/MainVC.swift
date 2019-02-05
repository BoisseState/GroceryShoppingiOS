//
//  MainVC.swift
//  Side Menu Test
//
//  Created by Joe Boisse on 11/24/18.
//  Copyright © 2018 Joe Boisse. All rights reserved.
//

import UIKit

class MainVC: UIViewController {

    @IBAction func showMenu(){
        NotificationCenter.default.post(name: NSNotification.Name("ToggleMenu"), object: nil)
    }

}
