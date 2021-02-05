//
//  BookmarksViewController.swift
//  GazettaIOS
//
//  Created by Vsevolod Sharov on 25.01.2021.
//

import UIKit

class BookmarksViewController: UIViewController {
    var presenter: BookmarksPresenter?

    override func viewDidLoad() {
        super.viewDidLoad()

        BookmarksConfigurator.configure(with: self)

        collectionView.register(
            BookmarksCollectionViewCell.nib,
            forCellWithReuseIdentifier: BookmarksCollectionViewCell.identifier)

        collectionView.delegate = self
        collectionView.dataSource = self

        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = viewModel.searchPlaceholder
        searchController.definesPresentationContext = true
        searchController.searchBar.isHidden = true

        navigationItem.searchController = searchController

        configureRefreshControl()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadBookmarks()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        searchController.isActive = false
    }

    func loadBookmarks() {
        presenter?.loadBookmarks(searchText: nil)
    }

    func filterBookmarks(for searchText: String) {
        presenter?.loadBookmarks(searchText: searchText)
    }

    func onBookmarksLoaded() {
        if collectionView.refreshControl?.isRefreshing == true {
            collectionView.refreshControl?.endRefreshing()
        }
        collectionView.reloadData()
    }

    private func configureRefreshControl() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefreshControl), for: .valueChanged)
        collectionView.refreshControl = refreshControl
    }

    @IBAction private func onSearchButtonClicked() {
        searchController.isActive = true
        searchController.searchBar.isHidden = false
        searchController.searchBar.becomeFirstResponder()
    }

    @objc private func handleRefreshControl() {
        loadBookmarks()
    }

    @IBOutlet private weak var collectionView: UICollectionView!

    private var viewModel = BookmarksViewModel()

    private let searchController = UISearchController(searchResultsController: nil)
    private var isFiltering: Bool {
        let isSearchBarEmpty = searchController.searchBar.text?.isEmpty ?? true
        return searchController.isActive && !isSearchBarEmpty
    }
}

// MARK: - BooksmarksPresenterOutputProtocol
extension BookmarksViewController: BooksmarksPresenterOutputProtocol {
    func didLoadBookmarks(_ bookmarks: [NewsArticle]) {
        viewModel.bookmarks = bookmarks
        collectionView.reloadData()
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension BookmarksViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.onClickCell(at: indexPath.row, isFiltering: isFiltering)
    }
}

// MARK: - UICollectionViewDataSource
extension BookmarksViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.bookmarks.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: BookmarksCollectionViewCell.identifier,
                for: indexPath) as? BookmarksCollectionViewCell,
            let delegate = presenter?.interactor as? BookmarksDelegate,
            let cellViewModel = viewModel.createViewModel(forCellAt: indexPath.row, delegate: delegate)
        else {
            print("Couldn't create table cell")
            return UICollectionViewCell()
        }
        cell.viewModel = cellViewModel
        cell.presenter = self
        return cell
    }
}

// MARK: - UISearchResultsUpdating
extension BookmarksViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        if let text = searchBar.text {
            filterBookmarks(for: text)
        }
    }
}

// MARK: - UISearchBarDelegate
extension BookmarksViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchController.searchBar.isHidden = true
    }
}
