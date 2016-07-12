//
//  HomeSenderInfoTableViewController.swift
//  WindThunder
//
//  Created by 孙超杰 on 16/7/5.
//  Copyright © 2016年 Gezbox Inc. All rights reserved.
//

import Foundation

class HomeSenderInfoTableViewController: BaseViewController {
    private var tableView: MWDTableView?
    var dataArr = [AnyObject]() {
        didSet {
            tableView?.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView = MWDTableView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight - 350))
        tableView!.delegate = self
        tableView!.dataSource = self
        tableView!.rowHeight = 70
        view.addSubview(tableView!)
    }
    
    
}

extension HomeSenderInfoTableViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        guard dataArr.count != 0 else { return UITableViewCell()}
        let index = indexPath.row
        let info = dataArr[index] as! BMKPoiInfo
        let addr = info.address
        let name = info.name
        let isShowIcon = (index == 0)
        let isShowLine = (index < (dataArr.count - 1))
        
        let cell = HomeSenderInfoTableCell.cellFor(tableView,address: addr,name: name,isShowIcon: isShowIcon, isShowLine: isShowLine)
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let index = indexPath.row
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let data = dataArr[index] as! BMKPoiInfo
        let locale = [data.pt.longitude, data.pt.latitude]
        print("[locale: \(locale)]")
        let instance = SenderOrderModel.sharedInstance
        //                        instance.setModel(addressName: data.name, addressDetail: data.address, name: "", tel: "")
        instance.setLocation(data.pt.longitude, lat: data.pt.latitude)
        
        self.navigationController?.popViewControllerAnimated(true)
        NSNotificationCenter.defaultCenter().postNotificationName(AppNotifications.HomeSenderInfoSearchPageMenuTableCellClick, object: data)
        
        
        
    }
}