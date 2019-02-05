//
//  Constants.swift
//  Final Project
//
//  Created by Joe Boisse on 11/25/18.
//  Copyright © 2018 Joe Boisse. All rights reserved.
//

import Foundation
import UIKit

extension NSNotification.Name {
    static let RecipeDataDownloaded = NSNotification.Name("RecipeDataDownloadedNotification")
    static let ImageDataDownloaded = NSNotification.Name("ImageDataDownloadedNotification")
    static let ToggleMenu = NSNotification.Name("ToggleSideMenu")
    static let toggleScroll = NSNotification.Name("ToggleScroll")
    
}

extension UIColor {
    
    
    static var selectedMonth : UIColor {return UIColor(red: 58.0/255.0, green: 41.0/255.0, blue: 75.0/255.0, alpha: 1.0)}
    
    static var outsideMonth : UIColor {return UIColor(red: 88.0/255.0, green: 74.0/255.0, blue: 102/255.0, alpha: 1.0)}
    
    static var currentDateColor : UIColor {return UIColor(red: 78.0/255.0, green: 63.0/255.0, blue: 93.0/255.0, alpha: 1.0)}
    
}


