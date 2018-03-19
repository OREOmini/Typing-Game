//
//  GameViewController.swift
//  Typing
//
//  Created by wangyunwen on 18/3/16.
//  Copyright © 2018年 YunwenWang. All rights reserved.
//

import Foundation
import UIKit
import YYKeyboardManager

class GameViewController: UIViewController {
    var textField:UITextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setUpElement() {
        textField = UITextField()
            .add(to: self.view)
            .layout(snpMaker: { (make) in
                make.centerY.centerX.equalToSuperview()
            })
            .config({ (view) in
//                view.delegate = self
            })
    
    }
    
//    YYKeyboardManager *manager = YYKeyboardManager()
}
