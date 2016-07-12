//
//  UpImageDownTextButton.swift
//  MrWindDelivery
//
//  Created by 孙超杰 on 16/5/24.
//  Copyright © 2016年 Gezbox Inc. All rights reserved.
//

import UIKit

class UpImageDownTextButton: UIButton {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let marginLeft: CGFloat = 20
        let imageViewWH: CGFloat = 30
        let labelMarginImage: CGFloat = 15
        
        let imageMarginTop: CGFloat = 10
        let labelMarginTop: CGFloat = 15
        let labelW: CGFloat = 60
        titleLabel?.sizeToFit()
        titleLabel?.frame = CGRectMake(marginLeft + imageViewWH + labelMarginImage, labelMarginTop, labelW, (titleLabel?.height)!)
        titleLabel?.textAlignment = .Center
        
        imageView?.frame = CGRectMake(marginLeft, imageMarginTop, imageViewWH, imageViewWH)
        imageView?.contentMode = UIViewContentMode.Center
        
    }
    
}

class TopLeftIconCenterText: UIButton {
    private var topLeftIcon = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        topLeftIcon.hidden = true
        addSubview(topLeftIcon)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel?.sizeToFit()
        titleLabel?.frame = CGRect(x: 15, y: (height - (titleLabel?.height)!) * 0.5, width: width - 30, height: (titleLabel?.height)!)
        titleLabel?.textAlignment = .Center
        topLeftIcon.frame = CGRect(x: 0, y: 0, width: 15, height: 15)
        topLeftIcon.contentMode = .TopLeft
    }
    
    func setIconImage(image: UIImage?) {
        topLeftIcon.image = image
    }
    
    func isHiddenIconImage(isHidden: Bool) {
        topLeftIcon.hidden = isHidden
    }
}

class LeftImageRightTextButton: UIButton {
    private var topLeftIcon = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        topLeftIcon.hidden = true
        addSubview(topLeftIcon)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let marginLeft: CGFloat = 15
        let imageWH: CGFloat = imageView?.height ?? 0
        let labelMarginImage: CGFloat = 5
        
//        let imageMarginTop: CGFloat = 10
        let labelMarginTop: CGFloat = 15
//        let labelW: CGFloat = 100
        titleLabel?.font = UIFont.systemFontOfSize(16)
        titleLabel?.sizeToFit()
        titleLabel?.frame = CGRect(x: marginLeft + imageWH + labelMarginImage, y: labelMarginTop, width: (titleLabel?.width)!,height: (titleLabel?.height)!)
        titleLabel?.textAlignment = .Center
        
        imageView?.frame = CGRect(x: marginLeft, y: (height - imageWH) * 0.5 , width: imageWH, height: imageWH)
        imageView?.contentMode = UIViewContentMode.Center
        
        topLeftIcon.frame = CGRect(x: 0, y: 0, width: 15, height: 15)
        topLeftIcon.contentMode = .TopLeft
    }
    
    func setIconImage(image: UIImage?) {
        topLeftIcon.image = image
    }
    
    func isHiddenIconImage(isHidden: Bool) {
        topLeftIcon.hidden = isHidden
    }
}


class ItemLeftButton: UIButton {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let Offset: CGFloat = 15
        
        titleLabel?.sizeToFit()
        titleLabel?.frame = CGRectMake(-Offset, height - 15, width - Offset, (titleLabel?.height)!)
        titleLabel?.textAlignment = .Center
        
        imageView?.frame = CGRectMake(-Offset, 0, width - Offset, height - 15)
        imageView?.contentMode = UIViewContentMode.TopLeft
    }
}

class ItemRightButton: UIButton {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let Offset: CGFloat = 15
        
        titleLabel?.sizeToFit()
        titleLabel?.frame = CGRectMake(Offset, height - 15, width + Offset, (titleLabel?.height)!)
        titleLabel?.textAlignment = .Center
        
        imageView?.frame = CGRectMake(Offset, 0, width + Offset, height - 15)
        imageView?.contentMode = UIViewContentMode.Center
    }
}

class ItemLeftImageButton: UIButton {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imageView?.frame = bounds
        imageView?.frame.origin.x = -15
    }
    
}