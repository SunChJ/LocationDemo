//
//  SenderOrderModel.swift
//  WindThunder
//
//  Created by SunCJ on 16/6/29.
//  Copyright © 2016年 Gezbox Inc. All rights reserved.
//

import Foundation
/// 用于保存寄件人信息的Model
public class SenderOrderModel {
    private static let instance = SenderOrderModel()
    public class var sharedInstance: SenderOrderModel {
        return instance
    }

    
    private var addressName: String?
    private var addressDetail: String?
    private var name: String?
    private var tel: String?
    private var lng: CLLocationDegrees?
    private var lat: CLLocationDegrees?
//    private var isBuilded = false
    
    init () {
        self.addressName = ""
        self.addressDetail = ""
        self.name = ""
        self.tel = ""
        self.lat = 0
        self.lng = 0
//        self.isBuilded = false
    }
    
    public func setModel(addressName addrName: String?, addressDetail addrDetail: String?, name: String?, tel: String?) {
        self.addressName = addrName
        self.addressDetail = addrDetail
        self.name = name
        self.tel = tel
//        self.isBuilded = true
    }
    
    public func setLocation(lng: CLLocationDegrees, lat: CLLocationDegrees) {
        self.lng = lng
        self.lat = lat
    }
    
    
    public func getAddressName() -> String? {
        return self.addressName
    }
    
    public func getAddressDetail() -> String? {
        return self.addressDetail
    }
    
    public func getAddress() -> String {
        return self.addressName! + self.addressDetail!
    }
    
    public func getName() -> String? {
        return self.name
    }
    
    public func getTel() -> String? {
        return self.tel
    }
    
    public func getLoc() -> CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: self.lat ?? 0, longitude: self.lng ?? 0)
    }
    
    public func getIsBuilded() -> Bool {
        var flag = true
        [self.addressName, self.addressDetail, self.name, self.tel].forEach { str in
            if str ==  nil {
                flag = false
            } else if str! == "" {
                flag = false
            }
        }
        return flag
    }
    
    public func getParameters() -> [String: AnyObject] {
        return ["name": self.name!, "tel": self.tel!, "addr": self.addressName! + self.addressDetail!, "lng": self.lng!, "lat": self.lat!]
    }
}