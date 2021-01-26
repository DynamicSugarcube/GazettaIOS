//
//  DailyNewsViewController.swift
//  GazettaIOS
//
//  Created by Vsevolod Sharov on 17.01.2021.
//

import UIKit

class DailyNewsViewController: UIViewController {
    
    @IBOutlet private weak var dailyNewsTableView: UITableView!
        
    private var dailyNewsViewModel: DailyNewsViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dailyNewsViewModel = DependencyProvider.getDailyNewsViewModel()
        
        dailyNewsTableView.register(FeedSectionHeaderView.nib, forHeaderFooterViewReuseIdentifier: FeedSectionHeaderView.identifier)
        
        dailyNewsTableView.register(TopStoryTableViewCell.nib, forCellReuseIdentifier: TopStoryTableViewCell.identifier)
        
        dailyNewsTableView.register(LatestNewsTableViewCell.nib, forCellReuseIdentifier: LatestNewsTableViewCell.identifier)
        
        dailyNewsTableView.delegate = self
        dailyNewsTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        dailyNewsViewModel.getTopStoriesOverNetwork { [unowned self] in
            let sections = IndexSet(arrayLiteral: 0)
            self.dailyNewsTableView.reloadSections(sections, with: .automatic)
        }
        
        dailyNewsViewModel.getLatestNewsOverNetwork { [unowned self] in
            let sections = IndexSet(arrayLiteral: 1)
            self.dailyNewsTableView.reloadSections(sections, with: .automatic)
        }
    }
}

extension DailyNewsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Do nothing
    }
}

extension DailyNewsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dailyNewsViewModel.sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dailyNewsViewModel.sections[section].numberOfRows
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = dailyNewsTableView.dequeueReusableHeaderFooterView(withIdentifier: FeedSectionHeaderView.identifier) as! FeedSectionHeaderView
        
        let dailyNewsSection = dailyNewsViewModel.sections[section]
        header.sectionLabel.text = dailyNewsSection.name
        header.sectionButton.setTitle(dailyNewsSection.buttonLabel, for: .normal)
        
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = dailyNewsTableView.dequeueReusableCell(withIdentifier: TopStoryTableViewCell.identifier, for: indexPath) as! TopStoryTableViewCell
            let viewModel = dailyNewsViewModel.createViewModelForTopStoryCell()
            cell.viewModel = viewModel
            return cell
        case 1:
            let cell = dailyNewsTableView.dequeueReusableCell(withIdentifier: LatestNewsTableViewCell.identifier, for: indexPath) as! LatestNewsTableViewCell
            let viewModel = dailyNewsViewModel.createViewModelForLatestNewsCell(indexOfArticle: indexPath.row)
            cell.viewModel = viewModel
            return cell
        default:
            return UITableViewCell()
        }
    }
}


