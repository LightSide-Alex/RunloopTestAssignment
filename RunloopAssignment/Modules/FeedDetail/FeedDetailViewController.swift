//
//  FeedDetailViewController.swift
//  RunloopAssignment
//
//  Created by LightSide on 7/7/19.
//  Copyright © 2019 LightSide. All rights reserved.
//

import UIKit

class FeedDetailViewController: UIViewController {

    @IBOutlet weak var lblDescription: UILabel!

    var item: FeedItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = item.title
        lblDescription.text = item.description
        
        sendEvent(with: item.title ?? "No title")
    }
    
    deinit {
        sendEvent(with: "")
    }
    
    private func sendEvent(with title: String) {
        let userInfo = ["title" : title]
        NotificationCenter.default.post(Notification(name: .feedSelected, object: nil, userInfo: userInfo))
    }
    
}
