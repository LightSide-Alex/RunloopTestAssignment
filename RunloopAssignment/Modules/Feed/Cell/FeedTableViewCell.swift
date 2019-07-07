//
//  FeedTableViewCell.swift
//  RunloopAssignment
//
//  Created by LightSide on 7/6/19.
//  Copyright © 2019 LightSide. All rights reserved.
//

import UIKit
import FeedKit

class FeedTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "FeedTableViewCell"
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    
    var item: RSSFeedItem! {
        didSet {
            lblTitle.text = item.title
            lblDate.text = item.pubDate?.toString(format: "E, d MMM yyyy HH:mm:ss")
            lblDescription.text = item.description
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}
