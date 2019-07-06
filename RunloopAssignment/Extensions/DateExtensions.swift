//
//  DateExtensions.swift
//  RunloopAssignment
//
//  Created by LightSide on 7/6/19.
//  Copyright © 2019 LightSide. All rights reserved.
//

import Foundation

extension Date {
    
    /// Return string representation of date with specific format
    func toString(format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        
        return dateFormatter.string(from: self)
    }
    
}
