//
//  DailyNewsViewController.swift
//  GazettaIOS
//
//  Created by Vsevolod Sharov on 17.01.2021.
//

import UIKit

fileprivate let NIB_NAME = "NewsTableViewCell"
fileprivate let CELL_ID = "newsCell"

fileprivate enum TableSection: Int {
    case topStories = 0, latestNews, total
}

class DailyNewsViewController: UIViewController {
    
    @IBOutlet private weak var dailyNewsTableView: UITableView!
    
    private var viewModel = DailyNewsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: NIB_NAME, bundle: nil)
        dailyNewsTableView.register(nib, forCellReuseIdentifier: CELL_ID)
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
        return TableSection.total.rawValue
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case TableSection.topStories.rawValue:
            return 1
        default:
            return viewModel.newsArray.count
        }
    }
    
    // MARK: - TODO: Make custom view for header
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case TableSection.topStories.rawValue:
            return "Top Stories"
        case TableSection.latestNews.rawValue:
            return "Latest News"
        default:
            return nil
        }
    }
    
    // MARK: - TODO: Make custom view for top story
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = dailyNewsTableView.dequeueReusableCell(withIdentifier: CELL_ID, for: indexPath) as! NewsTableViewCell
        
        switch indexPath.section {
        case TableSection.topStories.rawValue:
            cell.newsLabel.text = viewModel.topStory
        default:
            cell.newsLabel.text = viewModel.newsArray[indexPath.row]
        }
        
        return cell
    }
}


