//
//  MWDCommonButton.swift
//  WindThunder
//
//  Created by 孙超杰 on 16/7/11.
//  Copyright © 2016年 Gezbox Inc. All rights reserved.
//

import Foundation

class MWDCommonButton: UIButton {
    
    var iconImageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        iconImageView = UIImageView()
        addSubview(iconImageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
        titleLabel?.sizeToFit()
        let titleLabelH: CGFloat = (titleLabel?.height ?? 0)
        let titleLabelW: CGFloat = (titleLabel?.width ?? 0)
        
        titleLabel?.frame = CGRectMake((width - titleLabelW) * 0.5, (height - titleLabelH) * 0.5, titleLabelW, titleLabelH)
        titleLabel?.textAlignment = .Center
        
        let iconWH: CGFloat = 30
        
        iconImageView.frame = CGRect(x: (width - titleLabelW) * 0.5 - iconWH - 15, y: (height - iconWH) * 0.5, width: iconWH, height: iconWH)
        iconImageView.contentMode = .Center
        imageView?.frame = CGRectMake(0, 0, width, height)
        
        layer.cornerRadius = 5
//        layer.borderWidth = 1
//        layer.borderColor = MWDLineColor.CGColor
        
        layer.masksToBounds = true
        //        imageView?.contentMode = UIViewContentMode.Center
        
    }
    
    func setButton(title: String, color: UIColor,backImagName: String?, iconImagName:String? = nil, borderWith: CGFloat, borderColor: UIColor,  font: CGFloat, backColor: UIColor? = UIColor.clearColor() ){
        backgroundColor = backColor
        setTitle(title, forState: .Normal)
        setTitleColor(color, forState: .Normal)
        if backImagName != nil {
            setImage(UIImage(named: backImagName!), forState: .Normal)
        }
        if iconImagName != nil {
            iconImageView.image = UIImage(named: iconImagName!)
        }
        titleLabel?.font = UIFont.systemFontOfSize(font)
        layer.borderWidth = borderWith
        layer.borderColor = borderColor.CGColor
        
    }

}