//
//  FeedViewController.swift
//  RunloopAssignment
//
//  Created by LightSide on 7/6/19.
//  Copyright © 2019 LightSide. All rights reserved.
//

import UIKit
import FeedKit

class FeedViewController: UIViewController {
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    var items: [RSSFeedItem] = []
    
    private var rssService: RSSParseService?
    private let firstSegmentSources = [Constants.businessRSSLink]
    private let secondSegmentSources = [Constants.entertainmentRSSLink, Constants.environmentRSSLink]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.register(UINib(nibName: FeedTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: FeedTableViewCell.reuseIdentifier)

        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let row = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: row, animated: false)
        }
        
        rssService = RSSParseService()
        startLoadTask()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super .viewDidDisappear(animated)
        
        rssService = nil
    }

    @IBAction func valueChanged(_ sender: UISegmentedControl) {
        startLoadTask()
    }
    
    func startLoadTask() {
        items.removeAll()
        
        let urls = segmentedControl.selectedSegmentIndex == 0 ? firstSegmentSources : secondSegmentSources
        rssService?.subscribe(urls: urls, interval: 5, completitionHandler: { [weak self] feed in
            self?.items = feed
            self?.tableView.reloadData()
        })
    }
    
}
