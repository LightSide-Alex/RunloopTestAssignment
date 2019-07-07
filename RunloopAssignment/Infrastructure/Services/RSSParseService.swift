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
    
    private var subscriptions: [Timer] = []
    private var feedDictionary = ThreadSafeDictionary<Int, [RSSFeedItem]>()
    private var activeTasks: [Int] = [] {
        didSet {
            DispatchQueue.main.async { [weak self] in
                let isEmpty = self?.activeTasks.isEmpty ?? true
                UIApplication.shared.isNetworkActivityIndicatorVisible = !isEmpty
            }
        }
    }
    
    func subscribe(urls: [String], interval: TimeInterval, completitionHandler: @escaping ([RSSFeedItem]) -> Void) {
        invalidateTimers()
        feedDictionary.removeAll()
        
        // Creating tasks for each source
        for (index, value) in urls.enumerated() {
            let timer = createTask(index: index, url: value, interval: interval, completitionHandler: completitionHandler)
            RunLoop.current.add(timer, forMode: .common)
            timer.fire()
            
            subscriptions.append(timer)
        }
    }
    
    private func createTask(index: Int, url: String, interval: TimeInterval, completitionHandler: @escaping ([RSSFeedItem]) -> Void) -> Timer {
        
        return Timer(timeInterval: interval, repeats: true, block: { [weak self] timer in
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
        subscriptions.forEach({ $0.invalidate() })
    }
    
    deinit {
        invalidateTimers()
    }
    
}
