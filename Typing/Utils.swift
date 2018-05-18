//
//  Utils.swift
//  Typing
//
//  Created by wangyunwen on 18/3/31.
//  Copyright © 2018年 YunwenWang. All rights reserved.
//

import Foundation
import UIKit


func ifShowNewLetter(percentage: Int) -> Bool {
    let temp = getRandomNum(length: 100)
    if(temp > percentage) {
        return false
    } else {
        return true
    }
}

func getRandomNum(length:Int) -> Int {
    return Int(arc4random_uniform(UInt32(length)))
}

func getRandomFrame(frame: CGRect, width: CGFloat) -> CGRect {
//    print("playFrame:" + (String(describing: frame)))
    
    let frameWidth = frame.width
    let frameHeight = frame.height
    
    let newX:CGFloat = (frameWidth - width) * CGFloat(Float(getRandomNum(length: 100)) / 100.0)
    let newY:CGFloat = (frameHeight - width) * CGFloat(Float(getRandomNum(length: 100)) / 100.0)
//    print("X:\(newX)  Y:\(newY)")
    
    return CGRect(x: newX, y: newY, width: width, height: width)
}

func isOverlap(frameA: CGRect, frameB: CGRect) -> Bool {
    if (fabsf(Float(frameA.origin.y - frameB.origin.y)) > Float(frameA.height)) {
        return false
    }
    if (fabsf(Float(frameA.origin.x - frameB.origin.x)) > Float(frameA.width)) {
        return false
    }
    
    return true
}
func separator (_ frame : CGRect, color : UIColor?, alpha : CGFloat) -> UIImageView
{
    let separator = UIImageView(frame: frame)
    separator.backgroundColor = color
    separator.alpha = alpha
    
    return separator
}
