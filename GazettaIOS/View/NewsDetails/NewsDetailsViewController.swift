//
//  NewsDetailsViewController.swift
//  GazettaIOS
//
//  Created by Vsevolod Sharov on 26.01.2021.
//

import UIKit
import WebKit

class NewsDetailsViewController: UIViewController, WKUIDelegate {
    @IBOutlet private weak var webView: WKWebView!
    
    var data: NewsArticle? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.uiDelegate = self
        
        if let urlString = data?.newsUrl {
            if let url = URL(string: urlString) {
                let request = URLRequest(url: url)
                webView.load(request)
            }
        }
    }
}
