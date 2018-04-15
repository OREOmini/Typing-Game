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
    var scoreView:NumberMorphView?
    
    var timer:Timer?
    var timerLabel:NumberMorphView?
//    var timeLabel
    
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
                view.backgroundColor = .white
            })
        infoView = UIView()
            .add(to: self.gameView!)
            .layout(snpMaker: { (make) in
                make.width.equalToSuperview()
                make.top.left.right.equalToSuperview()
                make.height.equalTo(70)
            }).config({ (view) in
                view.backgroundColor = .clear
            })
        playView = UIView()
            .add(to: self.gameView!)
            .layout(snpMaker: { (make) in
                make.width.left.right.bottom.equalToSuperview()
                make.top.equalTo((infoView?.snp.bottom)!)
            }).config({ (view) in
                view.backgroundColor = .white
            })
//        scoreView = UILabel().add(to: infoView!)
//            .layout(snpMaker: { (make) in
//                make.left.centerY.equalToSuperview()
//                make.height.width.equalTo(50)
//            }).config({ (view) in
//                view.text = "0"
//            })
        
        // 用NumberMorphView显示分数
        scoreView = NumberMorphView()
            .add(to: infoView!)
            .layout(snpMaker: { (make) in
                make.left.centerY.equalToSuperview()
                make.height.width.equalTo(50)
            }).config({ (view) in
                view.interpolator = NumberMorphView.SpringInterpolator()
                view.lineWidth = 3
            })
        scoreView?.fontSize = 15
        scoreView?.currentDigit = 0
        let preferedSize = scoreView!.intrinsicContentSize
        scoreView?.frame = CGRect(x: 10, y: 10, width: preferedSize.width, height: preferedSize.height)
        
        
        
        timerLabel = NumberMorphView()
            .add(to: infoView!)
            .layout(snpMaker: { (make) in
                make.centerX.equalToSuperview()
                make.bottom.equalToSuperview()
                make.height.width.equalTo(50)
                
            }).config({ (view) in
                view.interpolator = NumberMorphView.SpringInterpolator()
                view.lineWidth = 3
                view.fontSize = 15
                view.currentDigit = 60
                view.tag = 60

            })
        
        
        
//        timerLabel = UILabel().add(to: self.infoView!)
//            .layout(snpMaker: { (make) in
//                make.center.equalToSuperview()
//            }).config({ (view) in
//                view.text = "100"
//                view.tag = 100
//            })
//        
        
        
        
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
                }
                textField.text = ""

            }
        }
        return true
    }
    
    func addScore(score:Int) {
        totalScore += score
        scoreView!.nextDigit = totalScore
//        scoreView!.text = String(totalScore)
    }
    
    
    
    // MARK: 倒计时
    func timerCountDown() {
        let num = (timerLabel?.tag)! - 1
        timerLabel?.nextDigit = num
        timerLabel?.tag = num

        
        // 每秒按几率出现文字
        if(ifShowNewLetter(percentage: 100) && num <= 98) {
            addNewLetterView()
        }
        // TODO: 倒计时完成跳转
        if (num == 0) {
            let view = GameOverViewController()
            view.score = totalScore
            self.present(view, animated: true, completion: nil)
        }
    }
    
    // MARK: 游戏动态
    func addNewLetterView() {
        var frame:CGRect?
        for i in 0...2000 {
            frame = createLetterViewFrame()
            if (frame != nil) {
                let view = LetterView(frame: frame!, easy: true)
                letterViewAppearAnimation(view: view)
                view.add(to: self.playView!)
                
                print("\(i)")
                return
            }
        }
    }
    
    func createLetterViewFrame() -> CGRect? {
        let newFrame = getRandomFrame(frame: playView!.frame, width: letterWidth!)
//        print("newframe:\(newFrame)")
        for subView in playView!.subviews {
            if (isOverlap(frameA: subView.frame, frameB: newFrame)) {
                return nil
            }
        }
        return newFrame
        
    }
    
    func letterViewDisappear(view:LetterView) {
        view.curve = "fadeOut"
        view.duration = 0.5
        view.animate()
        view.animateToNext {
            view.removeFromSuperview()
        }
        //        view.removeFromSuperview()
        
        //        let bounds = view.bounds
        //        view.animateWithDuration(0.5, delay: 0.0, usingSpringWithDamping: 0.1, initialSpringVelocity: 10, options: nil, animations: {
        //            self.loginButton.bounds = CGRect(x: bounds.origin.x - 20, y: bounds.origin.y, width: bounds.size.width + 60, height: bounds.size.height)
        //            self.loginButton.enabled = false
        //        }, completion: {_ in
        //            view.removeFromSuperview()
        //        })
    }
    
    func letterViewAppearAnimation(view:LetterView) {
        view.animation = "pop"
        view.curve = "zoomIn"
        view.duration = 2
        view.animate()
        view.animateToNext(completion: {
//            print("Spring animate complete")
        })

    }
    // MARK - 游戏功能
    
}
