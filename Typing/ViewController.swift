//
//  ViewController.swift
//  Typing
//
//  Created by wangyunwen on 18/3/6.
//  Copyright © 2018年 YunwenWang. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setUpElement() {
        let startBtn = UIButton().add(to: self.view)
            .layout { (make) in
                make.centerX.centerY.equalToSuperview()
        }.config { (btn) in
            btn.setTitle("Start", for: .normal)
        }
        
    }
}

