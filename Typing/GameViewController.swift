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
    var timerView:UIView?
    var stopBtn:UIButton?
    
    var timer:Timer?
    var tensView:NumberMorphView?
    var onesView:NumberMorphView?

    
    var totalScore:Int = 0
    var leftTime:Int = 60
    
    var manager:IQKeyboardManager? = IQKeyboardManager.sharedManager()
    
    var name:String = ""
    
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
        setUpElement { 
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerCountDown), userInfo: nil, repeats: true)
            
            timer?.fire()

        }
        
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
    
    func setUpElement(completion: () -> Void) {
        self.view.backgroundColor = UIColor(hex: "#f2ecde")
        
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
                view.clipsToBounds = false
            })
        playView = UIView()
            .add(to: self.gameView!)
            .layout(snpMaker: { (make) in
                make.width.left.right.bottom.equalToSuperview()
                make.top.equalTo((infoView?.snp.bottom)!)
            }).config({ (view) in
                view.backgroundColor = .white
            })
        timerView = UIView()
            .add(to: self.infoView!)
            .layout(snpMaker: { (make) in
                make.width.equalTo(50)
                make.height.equalTo(40)
                make.height.centerX.equalToSuperview()
                make.bottom.equalToSuperview().offset(10)
            }).config({ (view) in
                view.backgroundColor = .white
                view.clipsToBounds = false
            })
        scoreView = UILabel().add(to: infoView!)
            .layout(snpMaker: { (make) in
                make.right.centerY.equalToSuperview()
                make.height.width.equalTo(50)
            }).config({ (view) in
                view.text = "0"
                view.font = UIFont.boldSystemFont(ofSize: 20)
            })
        stopBtn = UIButton().add(to: infoView!)
            .layout(snpMaker: { (make) in
                make.left.top.equalToSuperview().offset(20)
                make.height.width.equalTo(50)
            }).config({ (view) in
                view.setImage(UIImage(named: "pause_btn2"), for: .normal)
                view.addTarget(self, action: #selector(pauseGame), for: .touchUpInside)
            })
        
        
        // 显示倒计时数字
        
        tensView = NumberMorphView().add(to: timerView!)
            .layout { (make) in
                make.height.equalToSuperview()
                make.width.equalToSuperview().dividedBy(2)
                make.left.top.bottom.equalToSuperview()
            }.config { (view) in
                view.currentDigit = 6
                view.interpolator = NumberMorphView.SpringInterpolator()
                view.fontSize = 14
        }
        
        onesView = NumberMorphView().add(to: timerView!)
            .layout { (make) in
                make.height.equalToSuperview()
                make.width.equalToSuperview().dividedBy(2)
                make.top.right.bottom.equalToSuperview()
            }.config { (view) in
                view.currentDigit = 0
                view.interpolator = NumberMorphView.SpringInterpolator()
                view.fontSize = 14
        }

        
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
        
        completion()
    }
    // MARK: 暂停游戏
    func pauseGame() {
        timer?.invalidate()
        stopAllAnimation()
        
        let pauseView = PauseGameView()
        pauseView.show(in: self.playView?.window, resumeGameAction: {
            print("pausegame")
            self.startAllAnimation()
        })
    }
    func stopAllAnimation() {
        for view in (playView?.subviews)! {
            let viewLetter = (view as! LetterView)
            viewLetter.progress.pauseAnimation()
        }
    }
    func startAllAnimation() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerCountDown), userInfo: nil, repeats: true)
        timer?.fire()
        for view in (playView?.subviews)! {
            let viewLetter = (view as! LetterView)
            let angle = viewLetter.progress.angle
            let leftTime = (360 - angle) / (360 / 10)
            viewLetter.progress.animate(fromAngle: angle, toAngle: 360, duration: leftTime, completion: { (c) in
                view.removeFromSuperview()
            })
        }
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
        scoreView!.text = String(totalScore)
    }
    
    
    
    // MARK: 倒计时
    func timerCountDown() {
        // 倒计时完成跳转
        if (leftTime == 0) {
            timer?.invalidate()
            timer = nil
            
            asyncRemove {
                //保存player
                addNewPlayer(name: name, score: totalScore)
                
                
                let view = GameOverViewController()
                view.score = totalScore
                view.name = name
                self.present(view, animated: true, completion: nil)
            }
            
        } else {
            let number = leftTime - 1
//            let totalTime = 60
            
            let tens = number / 10
            let ones = number - tens * 10
            
            tensView?.nextDigit = tens
            onesView?.nextDigit = ones
            
            leftTime = number
            
            
            // 每秒按几率出现文字
            if(ifShowNewLetter(percentage: 100)) {
                addNewLetterView()
            }
        }
    }
    
    func asyncRemove(completion: () -> Void) {
        for view in (playView?.subviews)!{
            (view as! LetterView).progress.stopAnimation()
            view.removeFromSuperview()
            onesView?.removeFromSuperview()
        }
        completion()
    }
    
    // MARK: 生成并加入文字
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
        if (newFrame.minX < 0 || newFrame.minY < 0) {
            return nil
        }
        
        for subView in playView!.subviews {
            if (isOverlap(frameA: subView.frame, frameB: newFrame)) {
                return nil
            }
        }
        return newFrame
        
    }
    
    // MARK:文字消失
    func letterViewDisappear(view:LetterView) {
        view.curve = "fadeOut"
        view.duration = 0.5
        view.animate()
        view.animateToNext {
            view.removeFromSuperview()
        }
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
    
}
