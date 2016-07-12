//
//  String+Extension.swift
//  MrWindDelivery
//
//  Created by SunCJ on 16/6/7.
//  Copyright © 2016年 Gezbox Inc. All rights reserved.
//

import Foundation

extension String {
    
    /**
     正则表达式适配
     
     - parameter patStr: 正则表达式
     
     - returns: isMatch: Bool
     */
    func matchPattern(patStr: String) -> Bool {
        var isMatch:Bool = false
        do {
            let regex = try NSRegularExpression(pattern: patStr, options: [.CaseInsensitive])
            let result = regex.firstMatchInString(self, options: NSMatchingOptions(rawValue: 0), range: NSMakeRange(0, characters.count))
            
            if (result != nil)
            {
                isMatch = true
            }
        }
        catch {
            isMatch = false
        }
        return isMatch
    }
    
    /**
     专门匹配手机手机号码 移动/联通/电信
     
     - returns: 是否符合三大巨头的电话号码格式 
     注意!!!: maybe以后需要扩充电话号码格式, 请按照原来的正则表达式思路填充
     */
    func matchTelphoneNumber() -> Bool {
        let CM_NUM = "^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$"
        let CU_NUM = "^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$"
        let CT_NUM = "^((133)|(153)|(177)|(18[0,1,9]))\\d{8}$"
        
        let isMatchCM = self.matchPattern(CM_NUM)
        let isMatchCU = self.matchPattern(CU_NUM)
        let isMatchCT = self.matchPattern(CT_NUM)
        
        return isMatchCM || isMatchCT || isMatchCU
    }
}