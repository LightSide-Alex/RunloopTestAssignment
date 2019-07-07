//
//  StringExtensions.swift
//  RunloopAssignment
//
//  Created by LightSide on 7/7/19.
//  Copyright © 2019 LightSide. All rights reserved.
//

import Foundation

extension String {
    
    /// Removes HTML tags from string
    func stripOutHtml() -> String? {
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
}
