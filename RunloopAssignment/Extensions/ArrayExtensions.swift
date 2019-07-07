//
//  ArrayExtensions.swift
//  RunloopAssignment
//
//  Created by LightSide on 7/7/19.
//  Copyright © 2019 LightSide. All rights reserved.
//

import Foundation

extension Array where Element: Equatable {
    
    @discardableResult
    mutating func replaceWith(_ array: Array) -> [Int] {
        var replacedIndexes: [Int] = []
        
        for (index, newValue) in array.enumerated() {
            if let oldValue = self[safe: index] {
                
                if oldValue != newValue {
                    replacedIndexes.append(index)
                }
                
                self[index] = newValue
            }
            else {
                self.append(newValue)
                replacedIndexes.append(index)
            }
        }
        
        return replacedIndexes
    }
    
}
