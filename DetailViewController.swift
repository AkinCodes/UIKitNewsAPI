//
//  DetailViewController.swift
//  UIKitNewsAPI
//
//  Created by Akin on 16/08/2021.
//

import UIKit
import WebKit

class DetailViewController: UIViewController, WKNavigationDelegate {
    
    

    // I created a webview by code
    var webView: WKWebView!
    var selectedItem: Guardian?

    
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }

    override func viewDidLoad() {
       
        super.viewDidLoad()
        
        if let url =  URL(string: (selectedItem?.webUrl)!){
            webView.load(URLRequest(url: url))
        }

    }
    
    
    
    // below i created another webview function here to tell the webview the navigation is complete and then show the title of the site on the nav bar
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }
    
    
    


    
    
}




    


    
    
    

