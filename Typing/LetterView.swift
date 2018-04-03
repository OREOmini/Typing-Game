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
//    var timeInterval:Int? = 2
    var isEasy:Bool
    var letter:String
    
    init(frame: CGRect, easy: Bool) {
        
//        progress = KDCircularProgress(frame: frame, colors: randomColor(hue: .random, luminosity: .light))
        
        progress = KDCircularProgress(frame: CGRect(x: 0, y: 0,
                                                    width: frame.width, height: frame.height))
        isEasy = easy
        if (isEasy) {
            letter = letterUtils.getRandomEasyLetter()
        } else {
            letter = letterUtils.getRandomHardLetter()
        }
        
        super.init(frame: frame)
        
        setupCircularProgress()
        
        

        UILabel()
            .add(to: self)
            .layout { (make) in
                make.center.equalToSuperview()
        }.config { (view) in
            view.text = letter
        }
        
        

    }
    
    func setupCircularProgress() {
        progress.clockwise = true
        // use random color
        progress.set(colors: randomColor(hue: .random, luminosity: .light))
        progress.glowMode = .forward
        progress.glowAmount = 0
        progress.trackColor = UIColor.white
        
        self.addSubview(progress)
        
        progress.animate(fromAngle: 0, toAngle: 360, duration: 10, completion: { completed in
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
