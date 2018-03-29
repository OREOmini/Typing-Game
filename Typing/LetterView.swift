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
    var view:UIView?
    var timeInterval:Int? = 2
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        setupCircularProgress(frame: frame)
    }
    
    func setupCircularProgress(frame:CGRect) {
        let progress =  KDCircularProgress(frame: frame)
        progress.startAngle = 0
        progress.angle = 360
        progress.clockwise = true
        // use random color
        progress.set(colors: randomColor(hue: .random, luminosity: .dark))
        
        progress.roundedCorners = false
        progress.center = CGPoint(x: self.center.x, y: self.center.y + 25)
        
        // 旋转一圈时间
        progress.gradientRotateSpeed = 20
        progress.trackColor = UIColor.white
        
        self.addSubview(progress)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
