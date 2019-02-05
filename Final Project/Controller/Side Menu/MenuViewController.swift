//
//  MenuViewController.swift
//  Final Project
//
//  Created by Joe Boisse on 12/9/18.
//  Copyright © 2018 Joe Boisse. All rights reserved.
//

import UIKit
protocol MenuDelegate{
    func sideMenuItemSelectedAtIndex(_ index:Int32)
}
class MenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    let menuOptions = ["Search","My Recipes", "Calendar"]//, "Grocery List", "Settings"]
    var btnMenu : UIButton!
    var delegate: MenuDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.isScrollEnabled = false
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    @IBAction func closeBtnPressed(_ sender: UIButton) {
        let center = NotificationCenter.default
        center.post(name: NSNotification.Name.toggleScroll, object: self)
        
        btnMenu.tag = 0
        
        if (self.delegate != nil) {
            var index = Int32(sender.tag)
            if(sender == self.closeButton){
                index = -1
            }
            delegate?.sideMenuItemSelectedAtIndex(index)
        }
        
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            self.view.frame = CGRect(x: -UIScreen.main.bounds.size.width, y: 0, width: UIScreen.main.bounds.size.width,height: UIScreen.main.bounds.size.height)
            self.view.layoutIfNeeded()
            self.view.backgroundColor = UIColor.clear
        }, completion: { (finished) -> Void in
            self.view.removeFromSuperview()
            self.removeFromParent()
        })
    }
   
     func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuOptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "MenuCell")!
        
        /*cell.selectionStyle = UITableViewCell.SelectionStyle.none
        cell.layoutMargins = UIEdgeInsets.zero
        cell.preservesSuperviewLayoutMargins = false
        cell.backgroundColor = UIColor.clear*/
        
       cell.textLabel?.text = menuOptions[indexPath.row]
        
    
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let btn = UIButton(type: UIButton.ButtonType.custom)
        btn.tag = indexPath.row
        self.closeBtnPressed(btn)
        
    }
    

}
