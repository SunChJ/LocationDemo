//
//  HomeSearchNoResultView.swift
//  WindThunder
//
//  Created by 孙超杰 on 16/7/11.
//  Copyright © 2016年 Gezbox Inc. All rights reserved.
//

import Foundation

class HomeSearchNoResultView: UIView {
    
    private var imageView = UIImageView()
    private var tipsLabel = UILabel()
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = MWDGlobalBackgroundColor
        
        imageView.image = UIImage(named: "im_icon")
        addSubview(imageView)
        
        tipsLabel.text = "暂无内容"
        tipsLabel.textColor = MWDTextGreyXColor
        tipsLabel.font = UIFont.systemFontOfSize(16)
        tipsLabel.textAlignment = .Center
        addSubview(tipsLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let imageWH: CGFloat = 70
        imageView.frame = CGRect(x: (width - imageWH) * 0.5, y: (height - imageWH) * 0.2, width: imageWH, height: imageWH)
        tipsLabel.sizeToFit()
        tipsLabel.frame = CGRect(x: (width - tipsLabel.width) * 0.5, y: (height - imageWH) * 0.2 + imageWH + 20, width: tipsLabel.width, height: tipsLabel.height)
    }
    
    func setText(text: String) {
        tipsLabel.text = text
    }
}