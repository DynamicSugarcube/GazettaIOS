//
//  BookmarksViewController.swift
//  GazettaIOS
//
//  Created by Vsevolod Sharov on 25.01.2021.
//

import UIKit

class BookmarksViewController: UIViewController {
    
    private var bookmarksViewModel: BookmarksViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bookmarksViewModel = DependencyProvider.getBookmarksViewModel()
    }
    
    // MARK: TODO Remove, show bookmarked articles as a collection view
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        bookmarksViewModel.getBookmarks() { articles in
            let titles = articles.map() { article in
                return article.title
            }
            print("Bookmarked articles: \(titles)")
        }
    }
}
