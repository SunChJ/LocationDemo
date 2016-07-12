//
//  UIView+Extension.swift
//  MrWindDelivery
//
//  Created by SunCJ on 16/5/24.
//  Copyright © 2016年 Gezbox Inc. All rights reserved.
//
//  对UIView进行扩展

import UIKit

extension UIView {

    var x: CGFloat {
        return self.frame.origin.x
    }
    
    var y: CGFloat {
        return self.frame.origin.y
        
    }
    
    var width: CGFloat {
        return self.frame.size.width
    }
    
    var height: CGFloat {
        return self.frame.size.height
    }
    
    var size: CGSize {
        return self.frame.size
    }
    
    var point: CGPoint {
        return self.frame.origin
    }
    
    public override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.endEditing(true)
    }
}
