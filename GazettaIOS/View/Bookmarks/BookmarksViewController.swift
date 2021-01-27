//
//  BookmarksViewController.swift
//  GazettaIOS
//
//  Created by Vsevolod Sharov on 25.01.2021.
//

import UIKit

fileprivate struct BookmarksConstraints {
    private static let cellPaddingRight = CGFloat(16)
    private static let cellPaddingLeft = CGFloat(16)
    
    private static var cellPadding: CGFloat {
        return cellPaddingRight + cellPaddingLeft
    }
    
    static func calculateCellWidth(for view: UICollectionView) -> CGFloat {
        return view.bounds.width - cellPadding
    }
    
    static let cellHeight = CGFloat(150)
}

class BookmarksViewController: UIViewController {
    private var bookmarksViewModel: BookmarksViewModel!
    
    @IBOutlet private weak var bookmarksCollectionView: UICollectionView!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bookmarksViewModel = DependencyProvider.getBookmarksViewModel()
        
        bookmarksCollectionView.register(BookmarksCollectionViewCell.nib, forCellWithReuseIdentifier: BookmarksCollectionViewCell.identifier)
        
        bookmarksCollectionView.delegate = self
        bookmarksCollectionView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        bookmarksViewModel.getBookmarks { [weak self] in
            self?.bookmarksCollectionView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showNewsDetails" {
            guard let cell = sender as? BookmarksCollectionViewCell else {
                return
            }
            guard let controller = segue.destination as? NewsDetailsViewController else {
                return
            }
            controller.data = cell.viewModel?.article
        }
    }
}

extension BookmarksViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = BookmarksConstraints.calculateCellWidth(for: bookmarksCollectionView)
        let cellHeight = BookmarksConstraints.cellHeight
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = bookmarksCollectionView.cellForItem(at: indexPath)
        performSegue(withIdentifier: "showNewsDetails", sender: cell)
    }
}

extension BookmarksViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bookmarksViewModel.dataSet.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = bookmarksCollectionView.dequeueReusableCell(withReuseIdentifier: BookmarksCollectionViewCell.identifier, for: indexPath) as! BookmarksCollectionViewCell
        let viewModel = bookmarksViewModel.createViewModelForCell(indexOfArticle: indexPath.row)
        cell.viewModel = viewModel
        return cell
    }
}
