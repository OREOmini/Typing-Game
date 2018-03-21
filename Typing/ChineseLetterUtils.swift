//
//  ChineseLetterUtils.swift
//  Typing
//
//  Created by wangyunwen on 18/3/21.
//  Copyright © 2018年 YunwenWang. All rights reserved.
//

import Foundation

class ChineseLetterUtils {
    var easyStr:NSString?
    var hardStr:NSString?
    
    init() {
        var path = Bundle.main.path(forResource: "easyLetters", ofType: "txt")
        do {
            try easyStr = NSString(contentsOfFile: path!, encoding: String.Encoding.utf8.rawValue)
        } catch  {}
        
        path = Bundle.main.path(forResource: "hardLetters", ofType: "txt")
        do {
            try hardStr = NSString(contentsOfFile: path!, encoding: String.Encoding.utf8.rawValue)
        } catch  {}
    }
    
    
}
