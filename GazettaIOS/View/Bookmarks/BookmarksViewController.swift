//
//  BookmarksViewController.swift
//  GazettaIOS
//
//  Created by Vsevolod Sharov on 25.01.2021.
//

import UIKit

class BookmarksViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = DependencyProvider.getBookmarksViewModel()
        
        collectionView.register(
            BookmarksCollectionViewCell.nib,
            forCellWithReuseIdentifier: BookmarksCollectionViewCell.identifier)

        collectionView.delegate = self
        collectionView.dataSource = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getBookmarks { [weak self] in
            self?.collectionView.reloadData()
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard
            segue.identifier == viewModel.showNewsDetailsSegueId,
            let cell = sender as? BookmarksCollectionViewCell,
            let controller = segue.destination as? NewsDetailsViewController
        else {
            print("Couldn't prepare for segue")
            return
        }
        controller.data = cell.viewModel?.article
    }

    @IBOutlet private weak var collectionView: UICollectionView!

    private var viewModel: BookmarksViewModel!
}

extension BookmarksViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        performSegue(withIdentifier: viewModel.showNewsDetailsSegueId, sender: cell)
    }
}

extension BookmarksViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.bookmarks.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: BookmarksCollectionViewCell.identifier,
                for: indexPath) as? BookmarksCollectionViewCell,
            let cellViewModel = viewModel.createViewModelForCell(indexOfArticle: indexPath.row)
        else {
            print("Couldn't create table cell")
            return UICollectionViewCell()
        }
        cell.viewModel = cellViewModel
        return cell
    }
}
