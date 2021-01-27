//
//  DailyNewsViewController.swift
//  GazettaIOS
//
//  Created by Vsevolod Sharov on 17.01.2021.
//

import UIKit

class DailyNewsViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel = DependencyProvider.getDailyNewsViewModel()

        tableView.register(
            FeedSectionHeaderView.nib,
            forHeaderFooterViewReuseIdentifier: FeedSectionHeaderView.identifier)

        tableView.register(
            TopStoryTableViewCell.nib,
            forCellReuseIdentifier: TopStoryTableViewCell.identifier)

        tableView.register(
            LatestNewsTableViewCell.nib,
            forCellReuseIdentifier: LatestNewsTableViewCell.identifier)

        tableView.delegate = self
        tableView.dataSource = self

        configureRefreshControl()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        viewModel.getTopStoriesOverNetwork { [weak self] in
            guard let self = self else { return }
            self.tableView.reloadSections(
                [self.viewModel.topStoriesSectionId],
                with: .automatic)
        }

        viewModel.getLatestNewsOverNetwork { [weak self] in
            guard let self = self else { return }
            self.tableView.reloadSections(
                [self.viewModel.latestNewsSectionId],
                with: .automatic)
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard
            segue.identifier == viewModel.showNewsDetailsSegueId,
            let cell = sender as? DailyNewsTableViewCell,
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
        tableView.refreshControl = refreshControl
    }

    @objc private func handleRefreshControl() {
        viewModel.getTopStoriesOverNetwork { [weak self] in
            guard let self = self else { return }
            self.tableView.reloadSections(
                [self.viewModel.topStoriesSectionId],
                with: .automatic)
            // TODO: endRefreshing() should be called once for 2 closures
            self.tableView.refreshControl?.endRefreshing()
        }

        viewModel.getLatestNewsOverNetwork { [weak self] in
            guard let self = self else { return }
            self.tableView.reloadSections(
                [self.viewModel.latestNewsSectionId],
                with: .automatic)
            // TODO: endRefreshing() should be called once for 2 closures
            self.tableView.refreshControl?.endRefreshing()
        }
    }

    @IBOutlet private weak var tableView: UITableView!

    private var viewModel: DailyNewsViewModel!
}

// MARK: - UITableViewDelegate
extension DailyNewsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        performSegue(withIdentifier: viewModel.showNewsDetailsSegueId, sender: cell)
        tableView.deselectRow(at: indexPath, animated: false)
    }
}

// MARK: - UITableViewDataSource
extension DailyNewsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.numberOfSections
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.calculateNumberOfRows(for: section)
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard
            let header = tableView
                .dequeueReusableHeaderFooterView(withIdentifier: FeedSectionHeaderView.identifier)
                as? FeedSectionHeaderView,
            let attributes = viewModel.getAttributes(for: section)
        else {
            return nil
        }
        header.sectionLabel.text = attributes.sectionLabel
        header.sectionButton.setTitle(attributes.buttonLabel, for: .normal)
        return header
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(viewModel.headerSectionHeight)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var rawIdentifier: String?
        var rawCellViewModel: NewsCellViewModel?
        switch indexPath.section {
        case viewModel.topStoriesSectionId:
            rawIdentifier = TopStoryTableViewCell.identifier
            rawCellViewModel = viewModel.createViewModelForTopStoryCell()
        case viewModel.latestNewsSectionId:
            rawIdentifier = LatestNewsTableViewCell.identifier
            rawCellViewModel = viewModel.createViewModelForLatestNewsCell(
                indexOfArticle: indexPath.row)
        default:
            rawIdentifier = nil
            rawCellViewModel = nil
        }

        guard
            let identifier = rawIdentifier,
            let cellViewModel = rawCellViewModel,
            let cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        else {
            print("Couldn't create table cell")
            return UITableViewCell()
        }

        if let newsCell = cell as? DailyNewsTableViewCell {
            newsCell.viewModel = cellViewModel
        }
        return cell
    }
}
