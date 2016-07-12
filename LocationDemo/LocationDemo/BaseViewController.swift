//
//  BaseViewController.swift
//  MrWindDelivery
//
//  Created by SunCJ on 16/5/24.
//  Copyright © 2016年 Gezbox Inc. All rights reserved.
//
//  自定义ViewController基类

import UIKit



class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = MWDGlobalBackgroundColor
        navigationController?.navigationBar.topItem?.title = ""
        navigationController?.navigationBar.backItem?.title = ""
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(BaseViewController.keyboardHide(_:)))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func keyboardHide(tapG: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
}
