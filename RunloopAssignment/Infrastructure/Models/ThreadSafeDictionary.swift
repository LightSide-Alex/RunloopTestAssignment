//
//  ThreadSafeDictionary.swift
//  RunloopAssignment
//
//  Created by LightSide on 7/7/19.
//  Copyright © 2019 LightSide. All rights reserved.
//

import Foundation

class ThreadSafeDictionary<Key: Hashable, Value> {
    
    private var internalDictionary: Dictionary<Key, Value> = [:]
    let isolationQueue = DispatchQueue(label: "LSA.RunloopAssignment.isolatedDictionary", qos: .userInteractive, attributes: .concurrent)
    
    var container: Dictionary<Key, Value> {
        var returnValue: Dictionary<Key, Value>!
        isolationQueue.sync {
            returnValue = internalDictionary
        }
        
        return returnValue
    }
    
    func insert(value: Value, forKey key: Key) {
        isolationQueue.async(flags: .barrier) {
            self.internalDictionary[key] = value
        }
    }
    
}
