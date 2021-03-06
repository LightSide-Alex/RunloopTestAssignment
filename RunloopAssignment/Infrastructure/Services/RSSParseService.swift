//
//  RSSParseService.swift
//  RunloopAssignment
//
//  Created by LightSide on 7/7/19.
//  Copyright © 2019 LightSide. All rights reserved.
//

import Foundation
import FeedKit

class RSSParseService {
    
    private var timers: [Timer] = []
    private var feedDictionary = ThreadSafeDictionary<Int, [RSSFeedItem]>()
    private var activeTasks: [Int] = [] {
        didSet {
            changeActivityIndicatorState()
        }
    }
    
    func subscribe(urls: [String], interval: TimeInterval, completitionHandler: @escaping ([RSSFeedItem]) -> Void) {
        invalidateTimers()
        feedDictionary.removeAll()
        timers.removeAll()
        
        // Creating tasks for each source
        for (index, value) in urls.enumerated() {
            let timer = self.createTask(index: index, url: value, interval: interval, completitionHandler: completitionHandler)
            
            RunLoop.current.add(timer, forMode: .common)
            timer.tolerance = 0.1
            timer.fire()
            
            self.timers.append(timer)
        }
    }
    
    private func createTask(index: Int, url: String, interval: TimeInterval, completitionHandler: @escaping ([RSSFeedItem]) -> Void) -> Timer {
        
        return Timer(timeInterval: interval, repeats: true, block: { [weak self] _ in
            self?.activeTasks.append(index)
            
            let feedURL = URL(string: url)!
            let parser = FeedParser(URL: feedURL)
            
            parser.parseAsync(queue: DispatchQueue.global(qos: .userInitiated)) { (result) in
                
                if let items = result.rssFeed?.items {
                    self?.feedDictionary.insert(value: items, forKey: index)
                }
                
                if let data = self?.getData() {
                    DispatchQueue.main.async {
                        completitionHandler(data)
                    }
                }
                
                // removing activity indicator on complete
                self?.activeTasks.removeAll(where: { $0 == index })
            }
        })
    }
    
    private func getData() -> [RSSFeedItem] {
        let sorted = feedDictionary.container.sorted(by: { $0.key < $1.key })
        
        // Translating into a single array
        return Array(sorted.map({ _, val in val }).joined())
    }
    
    private func invalidateTimers() {
        timers.forEach({ $0.invalidate() })
    }
    
    private func changeActivityIndicatorState() {
        DispatchQueue.main.async { [weak self] in
            let isEmpty = self?.activeTasks.isEmpty ?? true
            UIApplication.shared.isNetworkActivityIndicatorVisible = !isEmpty
        }
    }
    
    deinit {
        invalidateTimers()
    }
    
}
