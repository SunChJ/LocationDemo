//
//  NSRange+Extesion.swift
//  WindThunder
//
//  Created by SunCJ on 16/6/24.
//  Copyright © 2016年 Gezbox Inc. All rights reserved.
//

import Foundation
extension NSRange {
    func toRange(string: String) -> Range<String.Index> {
        let startIndex = string.startIndex.advancedBy(self.location)
        let endIndex = startIndex.advancedBy(self.length)
        
        return startIndex..<endIndex
    }
}