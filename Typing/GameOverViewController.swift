//
//  GameOverViewController.swift
//  Typing
//
//  Created by wangyunwen on 18/4/15.
//  Copyright © 2018年 YunwenWang. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class GameOverViewController: UIViewController {
    var score:Int?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElement()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func setUpElement() {
        self.view.backgroundColor = UIColor(hex: "#f2ecde")
        
        UILabel().add(to: self.view)
            .layout(snpMaker: { (make) in
                make.center.equalToSuperview()
            })
            .config { (view) in
                view.text = String(score!)
        }
    }
}
