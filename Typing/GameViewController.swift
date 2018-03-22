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
import IQKeyboardManagerSwift

class GameViewController: UIViewController {
    
    var textField:UITextField?
    var gameView:UIView?
    var keyboardView:UIView?
    var infoView:UIView?
    var playView:UIView?
    var letterUtils = ChineseLetterUtils()
    
    var manager:IQKeyboardManager? = IQKeyboardManager.sharedManager()
    
    override func viewWillAppear(_ animated: Bool) {
        // 让textField自动获取焦点，弹出键盘
        textField?.becomeFirstResponder()
        
        manager?.enable = true
        manager?.shouldResignOnTouchOutside = false
        manager?.keyboardAppearance = UIKeyboardAppearance.default
    
//        manager.enableAutoToolbar = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setUpElement()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setUpElement() {
//        let configuration = WHC_KeyboardManager.share.addMonitorViewController(self)
        
//        let manager:IQKeyboardManager = IQKeyboardManager.sharedManager()
//        manager.enable = true
//        manager.shouldResignOnTouchOutside = false
//        manager.keyboardAppearance = UIKeyboardAppearance.default
//        manager.enableAutoToolbar = false
        
        keyboardView = UIView()
            .add(to: self.view)
            .layout(snpMaker: { (make) in
                let height = (manager?.accessibilityFrame.height)! + 30
                print(height)
                make.width.equalToSuperview()
                make.height.equalTo(height)
                make.bottom.right.left.equalToSuperview()
            }).config({ (view) in
                view.backgroundColor = .gray
            })
        gameView = UIView()
            .add(to: self.view)
            .layout(snpMaker: { (make) in
                make.width.equalToSuperview()
                make.top.left.right.equalToSuperview()
                make.bottom.equalTo((keyboardView?.snp.top)!)
            }).config({ (view) in
                view.backgroundColor = .yellow
            })
        infoView = UIView()
            .add(to: self.gameView!)
            .layout(snpMaker: { (make) in
                make.width.equalToSuperview()
                make.top.left.right.equalToSuperview()
                make.height.equalTo(50)
            }).config({ (view) in
                view.backgroundColor = .lightGray
            })
        playView = UIView()
            .add(to: self.gameView!)
            .layout(snpMaker: { (make) in
                make.width.left.right.bottom.equalToSuperview()
                make.top.equalTo((infoView?.snp.bottom)!)
            }).config({ (view) in
                view.backgroundColor = .red
            })
        
        
        UILabel().add(to: self.gameView!)
            .layout { (make) in
                make.left.right.top.bottom.equalToSuperview()
        }.config { (view) in
            view.text = letterUtils.getRandomEasyLetter() + letterUtils.getRandomHardLetter()
//            view.text = letterUtils.easyStr as String?
            view.lineBreakMode = .byCharWrapping
        }
        
        self.view.backgroundColor = .white
        textField = UITextField()
            .add(to: self.keyboardView!)
            .layout(snpMaker: { (make) in
                make.width.equalTo(200)
                make.top.centerX.equalToSuperview()
            })
            .config({ (view) in
                view.borderStyle = .line
                view.returnKeyType = .send
            })
        
//        let manager:YYKeyboardManager? = YYKeyboardManager.default()
//        
//        view = manager?.keyboardView
    
    }
    
}
