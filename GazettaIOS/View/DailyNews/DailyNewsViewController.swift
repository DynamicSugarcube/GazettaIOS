//
//  DailyNewsViewController.swift
//  GazettaIOS
//
//  Created by Vsevolod Sharov on 17.01.2021.
//

import UIKit

fileprivate let NIB_NAME = "NewsTableViewCell"
fileprivate let CELL_ID = "newsCell"

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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.newsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = dailyNewsTableView.dequeueReusableCell(withIdentifier: CELL_ID, for: indexPath) as! NewsTableViewCell
        
        cell.newsLabel.text = viewModel.newsArray[indexPath.row]
        
        return cell
    }
}


