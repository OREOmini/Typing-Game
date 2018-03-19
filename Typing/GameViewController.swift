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
import WHC_KeyboardManager

class GameViewController: UIViewController {
    var textField:UITextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setUpElement()
        WHC_KeyboardManager.share.addMonitorViewController(self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setUpElement() {
        let configuration = WHC_KeyboardManager.share.addMonitorViewController(self)
        
        self.view.backgroundColor = .white
        textField = UITextField()
            .add(to: self.view)
            .layout(snpMaker: { (make) in
                make.width.equalTo(200)
                make.centerY.centerX.equalToSuperview()
            })
            .config({ (view) in
//                view.delegate = self
                
            })
        
//        let manager:YYKeyboardManager? = YYKeyboardManager.default()
//        
//        view = manager?.keyboardView
    
    }
    
}
