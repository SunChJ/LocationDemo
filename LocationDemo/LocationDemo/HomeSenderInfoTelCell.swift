//
//  HomeSenderInfoTelCell.swift
//  WindThunder
//
//  Created by SunCJ on 16/7/2.
//  Copyright © 2016年 Gezbox Inc. All rights reserved.
//

import Foundation
class HomeSenderInfoTelCell: UITableViewCell {
    private var telLabel = UILabel()
    private var inputTelField = UITextField()
    private var lineView = UIView()
    
    static private let identifier = "HomeSenderInfoTelCell"
    
    class func cellFor(tableView: UITableView) -> HomeSenderInfoTelCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(identifier) as? HomeSenderInfoTelCell
        if cell == nil {
            cell = HomeSenderInfoTelCell(style: .Default, reuseIdentifier: identifier)
        }
        cell!.selectionStyle = .None
        return cell!
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        telLabel.text = "联系电话"
        telLabel.textColor = MWDTextGreyXXColor
        telLabel.font = UIFont.systemFontOfSize(16)
        addSubview(telLabel)
        
        inputTelField.placeholder = "手机号"
        inputTelField.font = UIFont.systemFontOfSize(16)
        inputTelField.clearButtonMode = .WhileEditing
        inputTelField.keyboardType = .NumberPad
        inputTelField.delegate = self
        addSubview(inputTelField)
        
        lineView.backgroundColor = MWDLineColor
        addSubview(lineView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let marginLabel: CGFloat = 120
        let fieldH: CGFloat = 25
        
        telLabel.sizeToFit()
        telLabel.frame = CGRect(x: 20, y: (height - telLabel.height) * 0.5, width: telLabel.width, height: telLabel.height)
        
        inputTelField.frame = CGRect(x: marginLabel, y: (height - fieldH) * 0.5, width: width - 40 - marginLabel, height: fieldH)
        lineView.frame = CGRect(x: 20, y: height - 1, width: width - 40 , height: 1)
    }
    
    func getTel() -> String {
        return inputTelField.text ?? ""
    }
    
    func setTel(tel: String?) {
        inputTelField.text = tel
        
    }
    
}

extension HomeSenderInfoTelCell: UITextFieldDelegate {
    
    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        
        guard textField.text != nil else { return  true}
        
        if !(textField.text!.matchTelphoneNumber()) {
            MWDAlert().showAlert(subTitle: "请输入的正确的手机号")
            return false
        }
        return true
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else  { return true}
        let newLength = text.characters.count + string.characters.count - range.length
        return newLength <= 11
    }
}