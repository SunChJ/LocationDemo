//
//  HomeSenderInfoAddressCell.swift
//  WindThunder
//
//  Created by SunCJ on 16/7/2.
//  Copyright © 2016年 Gezbox Inc. All rights reserved.
//

import Foundation
class HomeSenderInfoAddressCell: UITableViewCell {
    private var addressLabel = UILabel()
    private var inputAddressField = UITextField()
    private var centerLineView = UIView()
    private var detailField = UITextView()
//    private var bottomLineView = UIView()
    private var placeHolder = UITextField()
    private var arrowImageView = UIImageView()
    
    static private let identifier = "HomeSenderInfoAddressCell"
    
    class func cellFor(tableView: UITableView) -> HomeSenderInfoAddressCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(identifier) as? HomeSenderInfoAddressCell
        if cell == nil {
            cell = HomeSenderInfoAddressCell(style: .Default, reuseIdentifier: identifier)
        }
        cell!.selectionStyle = .None
        return cell!
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addressLabel.text = "收货地址"
        addressLabel.textColor = MWDTextGreyXXColor
        addressLabel.font = UIFont.systemFontOfSize(16)
        addSubview(addressLabel)
        
        inputAddressField.placeholder = "小区/写字楼/学校等"
        inputAddressField.font = UIFont.systemFontOfSize(16)
        addSubview(inputAddressField)
        
        centerLineView.backgroundColor = MWDLineColor
        addSubview(centerLineView)
        
        detailField.font = UIFont.systemFontOfSize(16)
        
        detailField.delegate = self

        addSubview(detailField)
        
//        bottomLineView.backgroundColor = MWDLineColor
//        addSubview(bottomLineView)
        
        placeHolder.placeholder = "详细地址 (如门牌号码等)"
        placeHolder.enabled = false
        placeHolder.font = UIFont.systemFontOfSize(16)
        addSubview(placeHolder)
        
        arrowImageView.image = UIImage(named: "go")
        addSubview(arrowImageView)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let labelH: CGFloat = 50
        let marginLabel: CGFloat = 120
        let fieldH: CGFloat = 25
        let iconWH: CGFloat = 20

        addressLabel.sizeToFit()
        addressLabel.frame = CGRect(x: 20, y: (labelH - addressLabel.height) * 0.5, width: addressLabel.width, height: addressLabel.height)
        inputAddressField.frame = CGRect(x: marginLabel, y: (labelH - fieldH) * 0.5, width: width - 40 - marginLabel, height: fieldH)
        arrowImageView.frame = CGRect(x: width - iconWH - 20, y: (labelH - addressLabel.height) * 0.5, width: iconWH, height: iconWH)
        
        centerLineView.frame = CGRect(x: marginLabel, y: labelH - 1, width: width - marginLabel - 20, height: 1)
        
        detailField.frame = CGRect(x:marginLabel, y: labelH + 15, width: width - 20 - marginLabel, height: labelH * 2 - 30)
        
//        bottomLineView.frame = CGRect(x: 0, y: labelH * 3 - 1, width: width, height: 1)
        
        placeHolder.frame = CGRect(x: marginLabel + 2, y: labelH + 15 + 5, width: 200, height: 20)
        
    }
    
    func setFieldDelegate(delegate: UITextFieldDelegate) {
        self.inputAddressField.delegate = delegate
    }
    
    func getAddrName() -> String {
        return inputAddressField.text ?? ""
    }
    
    func getAddrDetail() -> String {
        return detailField.text
    }
    
    func setData(data: BMKPoiInfo) {
        inputAddressField.text = data.name
        detailField.text = data.address
        placeHolder.hidden = true
    }
    
//    func setData(data: SenderOrderModel) {
//        inputAddressField.text = data.getAddressName()
//        detailField.text = data.getAddressDetail()
//        placeHolder.hidden = true
//    }
    
    func setSenderAddr(addName: String?, addDetail: String?) {
        inputAddressField.text = addName
        detailField.text = addDetail
        placeHolder.hidden = (addDetail ?? "" != "")
    }
    
}

extension HomeSenderInfoAddressCell: UITextViewDelegate {
    func textViewDidChange(textView: UITextView) {
        if textView.text != "" {
            placeHolder.hidden = true
        } else {
            placeHolder.hidden = false
        }
    
    }
    
}
