//
//  NewsDetailsViewController.swift
//  GazettaIOS
//
//  Created by Vsevolod Sharov on 26.01.2021.
//

import UIKit
import WebKit

class NewsDetailsViewController: UIViewController, WKUIDelegate, Shareable {
    var data: NewsArticle?

    override func viewDidLoad() {
        super.viewDidLoad()

        let shareButton = UIBarButtonItem(
            barButtonSystemItem: .action,
            target: self,
            action: #selector(share))
        navigationItem.rightBarButtonItem = shareButton

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

    @objc private func share() {
        guard let article = data else {
            return
        }
        share(article: article, presenter: self)
    }

    @IBOutlet private weak var webView: WKWebView!
}
