//
//  HomeSenderInfoViewController.swift
//  WindThunder
//
//  Created by SunCJ on 16/7/2.
//  Copyright © 2016年 Gezbox Inc. All rights reserved.
//

import Foundation

class HomeSenderInfoViewController: BaseViewController {
    private var tableview: MWDTableView!
//    private var data:  BMKPoiInfo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableview = MWDTableView(frame: ScreenBounds)
        tableview.delegate = self
        tableview.dataSource = self
        view.addSubview(tableview)
        
//        tableview.reloadData()
        navigationItem.rightBarButtonItem = UIBarButtonItem.barButton("添加", titleColor: MWDButtonBackColor, target: self, action: #selector(HomeSenderInfoViewController.readyToPop))
        
        
    }
    
    override func viewWillAppear(animated: Bool) {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(HomeSenderInfoViewController.notiAction(_:)), name: AppNotifications.HomeSenderInfoSearchResultTableCellClick, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(HomeSenderInfoViewController.notiAction(_:)), name: AppNotifications.HomeSenderInfoSearchPageMenuTableCellClick, object: nil)
        navigationItem.title = "填写寄件人信息"
    }
    
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        
//        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func notiAction(noti: NSNotification) {
        let cell = tableview.cellForRowAtIndexPath(NSIndexPath(forRow: 2, inSection: 0)) as! HomeSenderInfoAddressCell
        let info = noti.object as! BMKPoiInfo
//        address = info.name
//        detail = info.address
//        loc = info.pt
//        let sender = SenderOrderModel.sharedInstance
        cell.setData(info)
//        tableview.reloadData()
//        cell.setData(sender)
        
    }
    

}

extension HomeSenderInfoViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let row = indexPath.row
        let sender = SenderOrderModel.sharedInstance
        switch row {
        case 0:
            let cell = HomeSenderInfoNameCell.cellFor(tableView)
            cell.setName(sender.getName())
            return cell
        case 1:
            let cell = HomeSenderInfoTelCell.cellFor(tableView)
            cell.setTel(sender.getTel())
            return cell
        case 2:
            let cell = HomeSenderInfoAddressCell.cellFor(tableView)
            cell.setSenderAddr(sender.getAddressName(), addDetail: sender.getAddressDetail())
            cell.setFieldDelegate(self)
            return cell
        default:
            break
        }
        return UITableViewCell()
    }
    
//    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 20
//    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let row = indexPath.row
        return (row == 2) ? 150 : 50
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func readyToPop() {
        
        let instance = SenderOrderModel.sharedInstance
        
        let nameCell = tableview.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0)) as! HomeSenderInfoNameCell
        let name = nameCell.getName()
        
        let telCell = tableview.cellForRowAtIndexPath(NSIndexPath(forRow: 1, inSection: 0)) as! HomeSenderInfoTelCell
        let tel = telCell.getTel()
        
        let addrCell = tableview.cellForRowAtIndexPath(NSIndexPath(forRow: 2, inSection: 0)) as! HomeSenderInfoAddressCell
        let addrName = addrCell.getAddrName()
        let addrDetail = addrCell.getAddrDetail()
        
        instance.setModel(addressName: addrName, addressDetail: addrDetail, name: name, tel: tel)
        guard instance.getIsBuilded() else {
            instance.setModel(addressName: "", addressDetail: "", name: "", tel: "")
            MWDAlert().showAlert(subTitle: "请填写完寄件人信息之后再确认!")
            return 
        }
        
        
        
//        instance.setModel(addressName: addrName, addressDetail: addrDetail, name: name, tel: tel)
//        let loc = data!.pt
//        SenderOrderModel.sharedInstance.setModel(addressName: data!.name, addressDetail: data!.address, name: name, tel: tel)
//        SenderOrderModel.sharedInstance.setLocation(loc.longitude, lat: loc.latitude)
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
}

extension HomeSenderInfoViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(textField: UITextField) {
        let vc = HomeSenderInfoSearchViewController()
//        if data != nil {
//            vc.setData(data!)
//        }
        self.navigationController?.pushViewController(vc, animated: true)

    }

}