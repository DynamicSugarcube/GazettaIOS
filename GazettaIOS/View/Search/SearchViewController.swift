//
//  SearchViewController.swift
//  GazettaIOS
//
//  Created by Vsevolod Sharov on 28.01.2021.
//

import UIKit

class SearchViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel = DependencyProvider.getSearchViewModel()

        tableView.register(
            FoundNewsTableViewCell.nib,
            forCellReuseIdentifier: FoundNewsTableViewCell.identifier)

        tableView.delegate = self
        tableView.dataSource = self

        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = viewModel.searchPlaceholder
        searchController.definesPresentationContext = true

        navigationItem.searchController = searchController
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        searchController.isActive = true
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard
            segue.identifier == viewModel.showNewsDetailsSegueId,
            let data = (sender as? FoundNewsTableViewCell)?.data,
            let controller = segue.destination as? NewsDetailsViewController
        else {
            print("Couldn't prepare for segue \(viewModel.showNewsDetailsSegueId)")
            return
        }
        controller.data = data
    }

    @IBOutlet private weak var tableView: UITableView!

    private var viewModel: SearchViewModel!

    private let searchController = UISearchController()
}

// MARK: - UITableViewDelegate
extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) else {
            return
        }
        performSegue(withIdentifier: viewModel.showNewsDetailsSegueId, sender: cell)
    }
}

// MARK: - UITableViewDataSource
extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.foundArticles.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(
                withIdentifier: FoundNewsTableViewCell.identifier)
                as? FoundNewsTableViewCell,
            let cellData = viewModel.getDataForCell(at: indexPath.row)
        else {
            return UITableViewCell()
        }
        cell.data = cellData
        return cell
    }
}

// MARK: - UISearchResultsUpdating
extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        if let text = searchBar.text {
            viewModel.getArticles(for: text) { [weak self] in
                guard let self = self else {
                    return
                }
                self.tableView.reloadData()
            }
        }
    }
}

// MARK: - UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        navigationController?.popViewController(animated: true)
    }
}
