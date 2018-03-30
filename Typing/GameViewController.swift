//
//  GameViewController.swift
//  Typing
//
//  Created by wangyunwen on 18/3/16.
//  Copyright © 2018年 YunwenWang. All rights reserved.
//

import Foundation
import UIKit
import IQKeyboardManagerSwift
import KDCircularProgress

class GameViewController: UIViewController {
    
    var textField:UITextField?
    var gameView:UIView?
    var keyboardView:UIView?
    var infoView:UIView?
    var playView:UIView?
    var letterWidth:Double? = 20
        
    var timer:Timer?
    var timerLabel:UILabel?
    
    var manager:IQKeyboardManager? = IQKeyboardManager.sharedManager()
    
    override func viewWillAppear(_ animated: Bool) {
        // 让textField自动获取焦点，弹出键盘
        textField?.becomeFirstResponder()
        
        manager?.enable = true
        manager?.shouldResignOnTouchOutside = false
        manager?.keyboardAppearance = UIKeyboardAppearance.default
        manager?.enableAutoToolbar = false
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setUpElement()
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerCountDown), userInfo: nil, repeats: true)
        timer?.fire()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: 页面布局
    
    func setUpElement() {
        
        keyboardView = UIView()
            .add(to: self.view)
            .layout(snpMaker: { (make) in
                let keyboardHeight = 260
                let height = keyboardHeight + 30
//                let height = (manager?.accessibilityFrame.height)! + 30
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
                make.height.equalTo(70)
            }).config({ (view) in
                view.backgroundColor = .lightGray
            })
        playView = UIView()
            .add(to: self.gameView!)
            .layout(snpMaker: { (make) in
                make.width.left.right.bottom.equalToSuperview()
                make.top.equalTo((infoView?.snp.bottom)!)
            }).config({ (view) in
                view.backgroundColor = .white
            })
        
        timerLabel = UILabel().add(to: self.infoView!)
            .layout(snpMaker: { (make) in
                make.center.equalToSuperview()
            }).config({ (view) in
                view.text = "100"
                view.tag = 100
            })
        
        
        
        
//        UILabel().add(to: self.playView!)
//            .layout { (make) in
//                make.left.right.top.bottom.equalToSuperview()
//        }.config { (view) in
//            view.text = letterUtils.getRandomEasyLetter()
////            view.text = letterUtils.easyStr as String?
//            view.lineBreakMode = .byCharWrapping
//        }
        
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
    }
    
    // MARK: 倒计时
    func timerCountDown() {
        let num = (timerLabel?.tag)! - 1
        timerLabel?.text = String(num)
        timerLabel?.tag = num
        
        if (num == 95) {
            LetterView(frame: CGRect(x: 0, y: 0, width: 50, height: 50), easy: true).add(to: self.playView!)
        }
        
        // 每秒按几率出现文字
        if(ifShowNewLetter(percentage: 60)) {
            addNewLetterView()
        }
        // TODO: 倒计时完成跳转
    }
    
    // MARK: 游戏动态
    func addNewLetterView() {
        
    }
    
    func createLetterViewFrame() -> CGRect {
        //TODO: add new letter without collision
    }
    
//    func showNewLetter(letter:String) -> Bool {
//        let label = UILabel()
//            .add(to: self.playView!)
//            .layout { (make) in
//                make.right.equalToSuperview()
//                make.top.equalTo(30)
//                make.width.height.equalTo(20)
//        }.config { (view) in
//            view.layer.borderWidth = 2
//            view.layer.borderColor = UIColor.brown.cgColor
//            view.text = letterUtils.getRandomEasyLetter()
//            view.textAlignment = .center
//        }
//        
//        return true
//    }
    // MARK - 游戏功能
    
}
