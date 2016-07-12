//
//  Model.swift
//  LocationDemo
//
//  Created by 孙超杰 on 16/7/12.
//  Copyright © 2016年 SamsonCJ. All rights reserved.
//

import Foundation

public class Model {
    private static let instance = Model()
    public class var sharedInstance: Model {
        return instance
    }
    
    
    var addressName: String?
    var addressDetail: String?
    var name: String?
    var tel: String?
    var lng: CLLocationDegrees?
    var lat: CLLocationDegrees?
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