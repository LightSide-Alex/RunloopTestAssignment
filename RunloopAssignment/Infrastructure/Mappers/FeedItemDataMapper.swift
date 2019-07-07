//
//  FeedItemDataMapper.swift
//  RunloopAssignment
//
//  Created by LightSide on 7/7/19.
//  Copyright © 2019 LightSide. All rights reserved.
//

import Foundation
import FeedKit

extension RSSFeedItem {
    func convert() -> FeedItem {
        return FeedItem(title: self.title,
                        publicationDate: self.pubDate?.toString(format: "E, d MMM yyyy HH:mm:ss"),
                        description: self.description?.stripOutHtml(),
                        link: self.link)
    }
}

extension Array where Element: RSSFeedItem {
    func convert() -> [FeedItem] {
        return self.map({ $0.convert() })
    }
}
