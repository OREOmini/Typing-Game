//
//  Extension.swift
//  Typing
//
//  Created by wangyunwen on 18/3/6.
//  Copyright © 2018年 YunwenWang. All rights reserved.
//

import Foundation
import UIKit
import SnapKit


protocol ViewChainable: class { }

extension ViewChainable where Self: UIView {
    @discardableResult
    func config(_ config: (Self) -> Void) -> Self {
        config(self)
        return self
    }
}

extension UIView: ViewChainable {
    
    @discardableResult
    func add(to targetView: UIView) -> Self {
        targetView.addSubview(self)
        return self
    }
    
    @discardableResult
    func layout(snpMaker: (ConstraintMaker) -> Void) -> Self {
        self.snp.makeConstraints { (make) in
            snpMaker(make)
        }
        return self
    }
    
    @discardableResult
    func updateLayout(snpMaker: (ConstraintMaker) -> Void) -> Self {
        self.snp.updateConstraints { (make) in
            snpMaker(make)
        }
        return self
    }
    
    @discardableResult
    func reLayout(snpMaker: (ConstraintMaker) -> Void) -> Self {
        self.snp.remakeConstraints { (make) in
            snpMaker(make)
        }
        return self
    }
}
