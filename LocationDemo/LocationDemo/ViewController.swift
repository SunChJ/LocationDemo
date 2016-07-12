//
//  ViewController.swift
//  LocationDemo
//
//  Created by 孙超杰 on 16/7/12.
//  Copyright © 2016年 SamsonCJ. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private var label = UILabel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        label.text = "click me, click me, click me!"
        label.numberOfLines = 0
        label.lineBreakMode = .ByCharWrapping
        label.frame = CGRect(x: 20, y: 300, width: 400, height: 20)
        label.userInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(ViewController.segueToVC(_:)))
        label.addGestureRecognizer(tap)
        
        view.addSubview(label)
        
        if Model.sharedInstance.getIsBuilded() {
            print(JSON(Model.sharedInstance.getParameters()))
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func segueToVC(tap: UITapGestureRecognizer) {
        self.navigationController?.pushViewController(HomeSenderInfoViewController(), animated: true)
    }


}

