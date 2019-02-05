//
//  ViewController.swift
//  Side Menu Test
//
//  Created by Joe Boisse on 11/24/18.
//  Copyright © 2018 Joe Boisse. All rights reserved.
//

import UIKit

class SideMenuContainerVC: UIViewController {

    @IBOutlet weak var sideMenuWidthConstraint: NSLayoutConstraint!
    var menuStatus = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(toggleMenu), name: NSNotification.Name.ToggleMenu, object: nil)
    }
    
    @objc func toggleMenu(){
        if menuStatus{
            self.sideMenuWidthConstraint.constant = -240
        }
        else{
           self.sideMenuWidthConstraint.constant = 0
        }
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
        menuStatus = !menuStatus
    }


}
