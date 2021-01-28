//
//  NewsDetailsViewController.swift
//  GazettaIOS
//
//  Created by Vsevolod Sharov on 26.01.2021.
//

import UIKit
import WebKit

class NewsDetailsViewController: UIViewController, WKUIDelegate {
    var data: NewsArticle?

    override func viewDidLoad() {
        super.viewDidLoad()

        webView.uiDelegate = self

        loadWebView()
    }

    private func loadWebView() {
        guard
            let urlString = data?.newsUrl,
            let url = URL(string: urlString)
        else {
            print("Couldn't load web view. Wrong URL")
            return
        }
        let request = URLRequest(url: url)
        webView.load(request)
    }

    @IBOutlet private weak var webView: WKWebView!
}
