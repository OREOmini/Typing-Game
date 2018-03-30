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
