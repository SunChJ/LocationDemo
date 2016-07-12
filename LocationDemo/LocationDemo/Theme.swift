//
//  Theme.swift
//  MrWindDelivery
//
//  Created by 孙超杰 on 16/5/23.
//  Copyright © 2016年 Gezbox Inc. All rights reserved.
//

import UIKit
//  MARK: - 全局常用属性
public let NavigationH: CGFloat = 64
public let ScreenWidth: CGFloat = UIScreen.mainScreen().bounds.size.width
public let ScreenHeight: CGFloat = UIScreen.mainScreen().bounds.size.height
public let ScreenBounds: CGRect = UIScreen.mainScreen().bounds
public let ScreenBoundsWithNav: CGRect = CGRectMake(0, 64, ScreenWidth, ScreenHeight - 64)
public let MWDNavigationBarWhiteBackgoundColor = UIColor.colorWithCustom(255, g: 255, b: 255)



// MARK: - Cache路径
public let MWDCachePath: String = NSSearchPathForDirectoriesInDomains(.CachesDirectory, .UserDomainMask, true).last!

// MARK: - 常用颜色
///最底层背景色
public let MWDGlobalBackgroundColor = UIColor(hex: 0xEEEEEE)
///红色按钮等背景色
public let MWDButtonBackColor = UIColor(hex: 0xFB464A)
public let MWDButtonLineColor = UIColor(hex: 0xEA3939)
///黑色背景下白色字体
public let MWDTextWhiteColor = UIColor(hex: 0xfafafa)
///底部 TAB 黑色背景；最深的色字体
public let MWDTextGreyXXXColor = UIColor(hex: 0x201F1F)
///常规黑色字体
public let MWDTextGreyXXColor = UIColor(hex: 0x565656)
///备注黑色字体；次要黑色字体
public let MWDTextGreyXColor = UIColor(hex: 0x8b8b8b)
///黑背景灰色字体（底部 TAB 字体）
public let MWDTextGreySSColor = UIColor(hex: 0xb7b7b7)

/// 所有常规边线，分隔线
public let MWDLineColor = UIColor(hex: 0xDDDDDD)
/// mask遮掩层配色
public let MWDMaskColor = UIColor(hex: 0x201F1F, alpha: 0.9)

public let BAIDU_KEY = "91sVbO4AQQhDEKBp5pRAD1MZL86Lm7ZR"
