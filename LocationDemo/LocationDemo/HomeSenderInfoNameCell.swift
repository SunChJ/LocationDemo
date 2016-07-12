//
//  HomeSenderInfoNameCell.swift
//  WindThunder
//
//  Created by SunCJ on 16/7/2.
//  Copyright © 2016年 Gezbox Inc. All rights reserved.
//

import Foundation

class HomeSenderInfoNameCell: UITableViewCell {
    private var nameLabel = UILabel()
    private var inputNameField = UITextField()
    private var lineView = UIView()
    
    static private let identifer = "HomeSenderInfoNameCell"
    
    class func cellFor(tableView: UITableView) -> HomeSenderInfoNameCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(identifer) as? HomeSenderInfoNameCell
        if cell == nil {
            cell = HomeSenderInfoNameCell(style: .Default, reuseIdentifier: identifer)
        }
        cell!.selectionStyle = .None
        return cell!
    }
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        nameLabel.text = "收件人"
        nameLabel.textColor = MWDTextGreyXXColor
        nameLabel.font = UIFont.systemFontOfSize(16)
        addSubview(nameLabel)
        
        inputNameField.font = UIFont.systemFontOfSize(16)
        inputNameField.clearButtonMode = .WhileEditing
        inputNameField.placeholder = "姓名"
        addSubview(inputNameField)
        
        lineView.backgroundColor = MWDLineColor
        addSubview(lineView)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let marginLabel: CGFloat = 120
        let filedH: CGFloat = 25
        nameLabel.sizeToFit()
        nameLabel.frame = CGRect(x: 20, y: (height - nameLabel.height) * 0.5, width: nameLabel.width, height: nameLabel.height)
        inputNameField.frame = CGRect(x: marginLabel, y: (height - filedH) * 0.5, width: width - 40 - marginLabel, height: filedH)
        lineView.frame = CGRect(x: 20, y: height - 1, width: width - 40 , height: 1)
    }
    
    func getName() -> String {
        return inputNameField.text ?? ""
    }
    
    func setName(name: String?) {
        inputNameField.text = name
    }
}