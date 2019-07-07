//
//  FeedTableView.swift
//  RunloopAssignment
//
//  Created by LightSide on 7/6/19.
//  Copyright © 2019 LightSide. All rights reserved.
//

import Foundation
import UIKit

extension FeedViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        sendEvent(with: items[indexPath.row].title ?? "No title")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FeedTableViewCell.reuseIdentifier, for: indexPath) as! FeedTableViewCell
        cell.item = items[indexPath.row]
        
        return cell
    }
    
    private func sendEvent(with title: String) {
        let userInfo = ["title" : title]
        
        NotificationCenter.default.post(Notification(name: .feedSelected, object: nil, userInfo: userInfo))
    }
    
}
