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


class GameViewController: UIViewController, UITextFieldDelegate{
    
    var textField:UITextField?
    var gameView:UIView?
    var keyboardView:UIView?
    var infoView:UIView?
    var playView:UIView?
    var letterWidth:CGFloat? = 70
    var keyboardHeight:CGFloat?
    var scoreView:UILabel?
    
    var timer:Timer?
    var timerLabel:UILabel?
    
    var totalScore:Int = 0
    
    var manager:IQKeyboardManager? = IQKeyboardManager.sharedManager()
    
    override func viewWillAppear(_ animated: Bool) {
        // 让textField自动获取焦点，弹出键盘
        textField?.becomeFirstResponder()
        
        manager?.enable = true
        manager?.shouldResignOnTouchOutside = false
        manager?.keyboardAppearance = UIKeyboardAppearance.default
        manager?.enableAutoToolbar = false
        manager?.keyboardDistanceFromTextField = 1
        
        NotificationCenter.default.addObserver(self, selector: #selector(keybordShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
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
    
    func keybordShow(notification:Notification)  {
        let userinfo: NSDictionary = notification.userInfo! as NSDictionary
        let nsValue = userinfo.object(forKey: UIKeyboardFrameEndUserInfoKey) as! NSValue
        let keyboardRec = nsValue.cgRectValue
        keyboardHeight = keyboardRec.size.height
        
        print("keybordShow:\(keyboardHeight)")
    }
    
    func setUpElement() {
        
        keyboardView = UIView()
            .add(to: self.view)
            .layout(snpMaker: { (make) in
                if (keyboardHeight == nil) {
                    keyboardHeight = 260
                }
                let height = keyboardHeight! + 40
                make.width.equalToSuperview()
                make.height.equalTo(height)
                make.bottom.right.left.equalToSuperview()
            }).config({ (view) in
                view.backgroundColor = .white
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
        scoreView = UILabel().add(to: infoView!)
            .layout(snpMaker: { (make) in
                make.left.centerY.equalToSuperview()
                make.height.width.equalTo(50)
            }).config({ (view) in
                view.text = "0"
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
                make.width.equalTo(100)
                make.height.equalTo(40)
                make.top.centerX.equalToSuperview()
            })
            .config({ (view) in
                view.borderStyle = .roundedRect
                view.returnKeyType = .send
                view.delegate = self
                view.textAlignment = .center
                view.layer.masksToBounds = true
                view.layer.cornerRadius = 12
                view.layer.borderWidth = 3
                view.layer.borderColor = UIColor.gray.cgColor
            })
    }
    
    // MARK: 键盘send点击后
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let char = textField.text
        
        if (!(char?.isEmpty)!) {
            for view in (playView?.subviews)!{
                let viewLetter = (view as! LetterView).letter
                if (viewLetter == char) {
                    addScore(score: 1)
                    letterViewDisappear(view: view as! LetterView)
                    textField.text = ""
                }
            }
        }
        return true
    }
    
    func addScore(score:Int) {
        totalScore += score
        scoreView!.text = String(totalScore)
    }
    
    func letterViewDisappear(view:LetterView) {
        view.removeFromSuperview()
    }
    
    // MARK: 倒计时
    func timerCountDown() {
        let num = (timerLabel?.tag)! - 1
        timerLabel?.text = String(num)
        timerLabel?.tag = num

        
        // 每秒按几率出现文字
        if(ifShowNewLetter(percentage: 80) && num <= 98) {
            addNewLetterView()
        }
        // TODO: 倒计时完成跳转
    }
    
    // MARK: 游戏动态
    func addNewLetterView() {
        for _ in 0...20 {
            let frame = createLetterViewFrame()
            if (frame != nil) {
                LetterView(frame: frame!, easy: true).add(to: self.playView!)
                return
            }
        }
    }
    
    func createLetterViewFrame() -> CGRect? {
        let newFrame = getRandomFrame(frame: playView!.frame, width: letterWidth!)
        for subView in playView!.subviews {
            if (isOverlap(frameA: subView.frame, frameB: newFrame)) {
                return nil
            }
        }
        return newFrame
        
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
