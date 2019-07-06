//
//  MainViewController.swift
//  RunloopAssignment
//
//  Created by LightSide on 7/6/19.
//  Copyright © 2019 LightSide. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblSelectedFeedName: UILabel!
    
    private var dateTimer: Timer!
    private let dateFormat = "EEEE, MMM d, yyyy"
    private let timeFormat = "HH:mm:ss"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        startTimeTracking()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        dateTimer.invalidate()
    }
    
    private func startTimeTracking() {
        dateTimer = Timer(timeInterval: 1.0,
                          target: self,
                          selector: #selector(updateTimer),
                          userInfo: nil,
                          repeats: true)
        
        RunLoop.current.add(dateTimer, forMode: .common)
        
        dateTimer.fire()
    }
    
    @objc
    private func updateTimer() {
        let date = Date()
        lblDate.text = date.toString(format: dateFormat)
        lblTime.text = date.toString(format: timeFormat)
    }
    
}
