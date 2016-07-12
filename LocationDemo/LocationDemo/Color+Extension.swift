//
//  Color+Extension.swift
//  MrWindDelivery
//
//  Created by 孙超杰 on 16/5/23.
//  Copyright © 2016年 Gezbox Inc. All rights reserved.
//
//  拓展UIColor自定义颜色和随机颜色
import UIKit

extension UIColor {
    class func colorWithCustom(r: CGFloat, g: CGFloat, b: CGFloat) -> UIColor {
        return UIColor(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: 1)
    }
    
    
    convenience init(hex: Int, alpha: CGFloat = 1) {
        
        let components = (
            R: CGFloat((hex >> 16) & 0xff) / 255,
            G: CGFloat((hex >> 08) & 0xff) / 255,
            B: CGFloat((hex >> 00) & 0xff) / 255
        )
        
        self.init(red: components.R, green: components.G, blue: components.B, alpha: alpha)
        
    }
    
//    class func randomColor() -> UIColor {
//        let r = CGFloat(arc4random_uniform(256))
//        let g = CGFloat(arc4random_uniform(256))
//        let b = CGFloat(arc4random_uniform(256))
//        return UIColor.colorWithCustom(r, g: g, b: b)
//    }
    
}
