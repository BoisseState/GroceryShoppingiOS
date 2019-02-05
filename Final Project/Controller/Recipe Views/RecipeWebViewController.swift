//
//  RecipeViewController.swift
//  Final Project
//
//  Created by Joe Boisse on 11/25/18.
//  Copyright © 2018 Joe Boisse. All rights reserved.
//

import UIKit
import WebKit

class RecipeWebViewController: UIViewController, WKUIDelegate {

    
    var recipeURL : String?
    var webView : WKWebView!
    
    override func loadView() {
        let webConfig = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfig)
        webView.uiDelegate = self
        self.view = webView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: recipeURL!)!
        var comps = URLComponents(url: url, resolvingAgainstBaseURL: false)!
        comps.scheme = "https"
        let httpsURL = comps.url!
        let request = URLRequest(url: httpsURL)
        webView.load(request)
        
    }
    
    func configure(title:String, url:String) {
        self.title = title
        recipeURL = url
    }

    

}
