//
//  HomeSenderInfoTableCell.swift
//  WindThunder
//
//  Created by 孙超杰 on 16/7/5.
//  Copyright © 2016年 Gezbox Inc. All rights reserved.
//

import Foundation
class HomeSenderInfoTableCell: UITableViewCell {
    private lazy var leftImageView = UIImageView()
    private var currentLocButton = MWDCommonButton()
    
    private lazy var addressLabel = UILabel()
    private lazy var nameLabel = UILabel()
//    private lazy var telLabel = UILabel()
    private lazy var lineView = UIView()
    
    static private let identifier = "MWDLeftImageTopBottomLabelRightArrowCell"
    
    class func cellFor(tableView: UITableView, address: String = "", name: String = "", isShowIcon: Bool = false, isShowLine: Bool = true) -> HomeSenderInfoTableCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(identifier) as? HomeSenderInfoTableCell
        if cell == nil {
            cell = HomeSenderInfoTableCell(style: .Default, reuseIdentifier: identifier)
        }
        
        cell!.addressLabel.text = address
        cell!.nameLabel.text = name
        cell!.currentLocButton.hidden = !isShowIcon
        cell!.lineView.hidden = !isShowLine
        return cell!
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        currentLocButton.setButton("当前定位", color: UIColor(hex: 0x4E91DE), backImagName: nil, iconImagName: nil, borderWith: 1, borderColor: .clearColor(), font: 12, backColor: UIColor(hex: 0xBCE5FE))
        addSubview(currentLocButton)
        
        addressLabel.textColor = MWDTextGreyXColor
        addressLabel.font = UIFont.systemFontOfSize(14)
        addSubview(addressLabel)
        
        nameLabel.textColor = MWDTextGreyXXColor
        nameLabel.font = UIFont.systemFontOfSize(16)
        addSubview(nameLabel)
        
        leftImageView.image = UIImage(named: "add3")
        leftImageView.contentMode = .ScaleAspectFill
        addSubview(leftImageView)
        
        lineView.backgroundColor = MWDGlobalBackgroundColor
        addSubview(lineView)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let imageWH: CGFloat = 18
        let labelH: CGFloat = 17
        let iconW: CGFloat = 54
        leftImageView.frame = CGRect(x: 20, y: (height - imageWH) * 0.5, width: imageWH, height: imageWH)
        
        
        nameLabel.sizeToFit()
        nameLabel.frame = CGRect(x: 20 + imageWH + 10, y: 15, width: nameLabel.width, height: labelH)
        currentLocButton.frame = CGRect(x: 20 + imageWH + 10 + nameLabel.width + 10, y: 15, width: iconW, height: labelH)
        
        addressLabel.sizeToFit()
        addressLabel.frame = CGRect(x: 20 + imageWH + 10 , y: height - 15 - labelH, width: addressLabel.width, height: labelH)
        
        lineView.frame = CGRect(x: 20, y: height - 1, width: width - 40, height: 1)
    }
    
    
}