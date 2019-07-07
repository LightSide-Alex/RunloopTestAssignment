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
        let details = self.storyboard!.instantiateViewController(withIdentifier: "FeedDetailViewController") as! FeedDetailViewController
        details.item = items[indexPath.row]
        
        self.navigationController!.pushViewController(details, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FeedTableViewCell.reuseIdentifier, for: indexPath) as! FeedTableViewCell
        cell.item = items[indexPath.row]
        
        return cell
    }
    
}
