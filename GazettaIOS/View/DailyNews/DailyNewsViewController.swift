//
//  DailyNewsViewController.swift
//  GazettaIOS
//
//  Created by Vsevolod Sharov on 17.01.2021.
//

import UIKit

class DailyNewsViewController: UIViewController {
    
    @IBOutlet private weak var dailyNewsTableView: UITableView!
        
    private var topStoriesViewModel = TopStoriesViewModel()
    private var latestNewsViewModel = LatestNewsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dailyNewsTableView.register(FeedSectionHeaderView.nib, forHeaderFooterViewReuseIdentifier: FeedSectionHeaderView.identifier)
        
        dailyNewsTableView.register(TopStoryTableViewCell.nib, forCellReuseIdentifier: TopStoryTableViewCell.identifier)
        
        dailyNewsTableView.register(LatestNewsTableViewCell.nib, forCellReuseIdentifier: LatestNewsTableViewCell.identifier)
        
        dailyNewsTableView.delegate = self
        dailyNewsTableView.dataSource = self
    }
}

extension DailyNewsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Do nothing
    }
}

extension DailyNewsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return TableSectionIdentifier.total.rawValue
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case topStoriesViewModel.sectionIdentifier:
            return topStoriesViewModel.rowCount
        case latestNewsViewModel.sectionIdentifier:
            return latestNewsViewModel.rowCount
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = dailyNewsTableView.dequeueReusableHeaderFooterView(withIdentifier: FeedSectionHeaderView.identifier) as! FeedSectionHeaderView
        
        switch section {
        case topStoriesViewModel.sectionIdentifier:
            header.sectionLabel.text = topStoriesViewModel.sectionName
            header.sectionButton.setTitle(topStoriesViewModel.sectionButtonName, for: .normal)
        case latestNewsViewModel.sectionIdentifier:
            header.sectionLabel.text = latestNewsViewModel.sectionName
            header.sectionButton.setTitle(latestNewsViewModel.sectionButtonName, for: .normal)
        default:
            return nil
        }
        
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case topStoriesViewModel.sectionIdentifier:
            let cell = dailyNewsTableView.dequeueReusableCell(withIdentifier: TopStoryTableViewCell.identifier, for: indexPath) as! TopStoryTableViewCell
            let news = topStoriesViewModel.currentTopStory
            cell.newsLabel.text = news.label
            cell.newsPublisherAndDateLabel.text = news.publisherAndDate
            return cell
        case latestNewsViewModel.sectionIdentifier:
            let cell = dailyNewsTableView.dequeueReusableCell(withIdentifier: LatestNewsTableViewCell.identifier, for: indexPath) as! LatestNewsTableViewCell
            let news = latestNewsViewModel.dataSet[indexPath.row]
            cell.newsLabel.text = news.label
            cell.newsPublisherAndDateLabel.text = news.publisherAndDate
            return cell
        default:
            return UITableViewCell()
        }
    }
}


