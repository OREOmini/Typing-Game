//
//  LetterView.swift
//  Typing
//
//  Created by wangyunwen on 18/3/28.
//  Copyright © 2018年 YunwenWang. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import KDCircularProgress
import RandomColorSwift

class LetterView:UIView {
    
    var letterUtils = ChineseLetterUtils()
    var progress:KDCircularProgress
    var timeInterval:Int? = 2
    var isEasy:Bool
    
    init(frame: CGRect, easy: Bool) {
        
        progress =  KDCircularProgress(frame: frame)
        isEasy = easy
        super.init(frame: frame)
        
        
        setupCircularProgress(frame: frame)
        
        UILabel()
            .add(to: self)
            .layout { (make) in
                make.center.equalToSuperview()
        }.config { (view) in
            if (isEasy) {
                view.text = letterUtils.getRandomEasyLetter()
            } else {
                view.text = letterUtils.getRandomHardLetter()
            }
        }
        
        

    }
    
    func setupCircularProgress(frame:CGRect) {
        progress.startAngle = -90
//        progress.angle = 360
        progress.clockwise = true
        // use random color
        progress.set(colors: randomColor(hue: .random, luminosity: .light))
        
        progress.roundedCorners = false
        progress.glowMode = .forward
        progress.glowAmount = 0
        progress.center = CGPoint(x: self.center.x, y: self.center.y)
        
        // 旋转一圈时间
        progress.gradientRotateSpeed = 2
        progress.trackColor = UIColor.white
        
        
        self.addSubview(progress)
        
        progress.animate(fromAngle: 0, toAngle: 360, duration: 5, completion: { completed in
            if completed {
                print("animation stopped, completed")
                self.removeFromSuperview()
            } else {
                print("animation stopped, was interrupted")
            }
        })
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
