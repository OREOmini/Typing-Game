//
//  CountDownView.swift
//  Typing
//
//  Created by wangyunwen on 18/4/15.
//  Copyright © 2018年 YunwenWang. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class CountDownView: UIView {
    var tensView:NumberMorphView?
    var onesView:NumberMorphView?
    
    init(number: Int, frame: CGRect) {
        let tens = number / 10
        let ones = number - tens * 10


        super.init(frame: frame)
        
        
        tensView = NumberMorphView().add(to: self)
            .layout { (make) in
                make.height.equalToSuperview()
                make.width.equalToSuperview().dividedBy(2)
                make.left.top.bottom.equalToSuperview()
                }.config { (view) in
                    view.currentDigit = tens
                    view.interpolator = NumberMorphView.SpringInterpolator()
                    view.fontSize = 14
            }
        
        onesView = NumberMorphView().add(to: self)
            .layout { (make) in
                make.height.equalToSuperview()
                make.width.equalToSuperview().dividedBy(2)
                make.top.right.bottom.equalToSuperview()
            }.config { (view) in
                view.currentDigit = ones
                view.interpolator = NumberMorphView.SpringInterpolator()
                view.fontSize = 14
            }

        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
