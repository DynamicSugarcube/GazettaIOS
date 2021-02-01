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

        onTopStoriesLoaded = { [weak self] in
            guard let self = self else { return }
            self.tableView.reloadSections(
                [self.viewModel.topStoriesSectionId],
                with: .automatic)
        }
        onLatestNewsLoaded = { [weak self] in
            guard let self = self else { return }
            self.tableView.reloadSections(
                [self.viewModel.latestNewsSectionId],
                with: .automatic)
        }
        onRefreshDone = { [weak self] in
            guard let self = self else { return }
            self.tableView.refreshControl?.endRefreshing()
        }

        configureRefreshControl()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard
            let onTopStoriesLoaded = onTopStoriesLoaded,
            let onLatestNewsLoaded = onLatestNewsLoaded
        else {
            return
        }
        viewModel.refreshDailyNews(
            onTopStroiesLoaded: onTopStoriesLoaded,
            onLatestNewsLoaded: onLatestNewsLoaded)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case viewModel.showNewsDetailsSegueId:
            guard
                let cell = sender as? DailyNewsTableViewCell,
                let controller = segue.destination as? NewsDetailsViewController
            else {
                print("Couldn't prepare for segue \(viewModel.showNewsDetailsSegueId)")
                return
            }
            controller.data = cell.viewModel?.article
        case viewModel.showSearchSegueId: break
        default:
            print("Wrong segue ID provided")
        }
    }

    @IBAction private func showSearch() {
        performSegue(withIdentifier: viewModel.showSearchSegueId, sender: self)
    }

    private func configureRefreshControl() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefreshControl), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }

    @objc private func handleRefreshControl() {
        guard
            let onTopStoriesLoaded = onTopStoriesLoaded,
            let onLatestNewsLoaded = onLatestNewsLoaded,
            let onRefreshDone = onRefreshDone
        else {
            return
        }
        viewModel.refreshDailyNews(
            onTopStroiesLoaded: onTopStoriesLoaded,
            onLatestNewsLoaded: onLatestNewsLoaded,
            onRefreshDone: onRefreshDone)
    }

    @IBOutlet private weak var tableView: UITableView!

    private var viewModel: DailyNewsViewModel!

    private var onTopStoriesLoaded: (() -> Void)?
    private var onLatestNewsLoaded: (() -> Void)?
    private var onRefreshDone: (() -> Void)?
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
