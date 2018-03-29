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
        let easyPath = Bundle.main.path(forResource: "easyLetters", ofType: "txt")
        let hardPath = Bundle.main.path(forResource: "hardLetters", ofType: "txt")
        
        
        do {
            let easyData:NSData = try NSData(contentsOfFile: easyPath!)
            
            // 中文encoding http://www.maiziedu.com/article/10319/
            let enc = CFStringConvertEncodingToNSStringEncoding(UInt32(CFStringEncodings.GB_18030_2000.rawValue))
            
            easyStr = NSString(data: easyData as Data, encoding: enc)
            
            let hardData:NSData = try NSData(contentsOfFile: hardPath!)
            hardStr = NSString(data: hardData as Data, encoding: enc)
            
//            print(easyStr)
//            print("------")
        } catch  {
        }
        
    }
    
    
    func getRandomEasyLetter() -> String {
        let length = easyStr?.length
        let temp = getRandomNum(length: length!)
        print("temp = " + String(temp))
        
        let randomStr:String = (easyStr?.substring(with: NSMakeRange(temp, 1)))!
        
        return randomStr
    }
    
    func getRandomHardLetter() -> String {
        let length = hardStr?.length
        let temp = getRandomNum(length: length!)
        
        let randomStr:String = (hardStr?.substring(with: NSMakeRange(temp, 1)))!
        
        return randomStr
    }
    
    func getRandomNum(length:Int) -> Int {
        return Int(arc4random_uniform(UInt32(length)))
    }
    
    
}
