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

        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = viewModel.searchPlaceholder
        searchController.definesPresentationContext = true
        navigationItem.searchController = searchController

        configureRefreshControl()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.getBookmarks { [weak self] in
            guard let self = self else { return }
            self.collectionView.reloadData()
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        searchController.isActive = false
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

    private func configureRefreshControl() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefreshControl), for: .valueChanged)
        collectionView.refreshControl = refreshControl
    }

    @objc private func handleRefreshControl() {
        viewModel.getBookmarks { [weak self] in
            guard let self = self else { return }
            self.collectionView.reloadData()
            self.collectionView.refreshControl?.endRefreshing()
        }
    }

    private func filterData(for searchText: String) {
        viewModel.filterBookmarks(for: searchText)
        collectionView.reloadData()
    }

    @IBOutlet private weak var collectionView: UICollectionView!

    private var viewModel: BookmarksViewModel!

    private let searchController = UISearchController(searchResultsController: nil)
    private var isSearchbarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    private var isFiltering: Bool {
        return searchController.isActive && !isSearchbarEmpty
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension BookmarksViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        performSegue(withIdentifier: viewModel.showNewsDetailsSegueId, sender: cell)
    }
}

// MARK: - UICollectionViewDataSource
extension BookmarksViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        isFiltering ? viewModel.filteredBookmarks.count : viewModel.bookmarks.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: BookmarksCollectionViewCell.identifier,
                for: indexPath) as? BookmarksCollectionViewCell,
            let cellViewModel = viewModel.createViewModelForCell(
                indexOfArticle: indexPath.row,
                isFiltering: isFiltering)
        else {
            print("Couldn't create table cell")
            return UICollectionViewCell()
        }
        cell.viewModel = cellViewModel
        return cell
    }
}

// MARK: - UISearchResultsUpdating
extension BookmarksViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        if let text = searchBar.text {
            filterData(for: text)
        }
    }
}
