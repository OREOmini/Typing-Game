//
//  ScoreRankingView.swift
//  Typing
//
//  Created by wangyunwen on 18/5/18.
//  Copyright © 2018年 YunwenWang. All rights reserved.
//

import Foundation
import UIKit

class ScoreRankingView: UIView {
    let SCREEN_WIDTH = UIScreen.main.bounds.width
    
    fileprivate var maskDarkView: UIView?
    fileprivate var confirmView: UIView?
    
    //    fileprivate var cnCarAction: (() -> Void)?
//    fileprivate var resumeGameAction: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupElements()
    }
    
    convenience init() {
        self.init(frame: .zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension ScoreRankingView {
    func setupElements() {
        
        self.alpha = 0
        
        let maskDarkView = UIButton(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: UIScreen.main.bounds.height))
        maskDarkView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        maskDarkView.alpha = 0
        maskDarkView.addTarget(self, action: #selector(ScoreRankingView.btnTapped), for: .touchUpInside)
        self.maskDarkView = maskDarkView

        
        self.isUserInteractionEnabled = true

        
        let confirmView = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH * 0.6, height: 180))
        confirmView.backgroundColor = .white
        confirmView.layer.cornerRadius = 18
        confirmView.layer.masksToBounds = true
        confirmView.layer.borderColor = UIColor(hex: "#D6C6D4").cgColor
        confirmView.layer.borderWidth = 9

        
        self.addSubview(confirmView)
        
        self.confirmView = confirmView
        
        addNewLabel(y: 0, text: "王韵文: 37分")
        addSeparator(y: 60)
        addNewLabel(y: 60, text: "肖凯欣: 36分")
        addSeparator(y: 120)
        addNewLabel(y: 120, text: "哈哈哈: 20分")
    }
    
    func addNewLabel(y: Int, text: String) {
        let label = UILabel(frame: CGRect(x: 0, y: y, width: Int(SCREEN_WIDTH * 0.6), height: 50))
        label.textColor = .gray
        label.textAlignment = .center
        label.text = text
        label.font = UIFont.boldSystemFont(ofSize: 23)
        
        confirmView?.addSubview(label)
    }
    func addSeparator(y: Int) {
        confirmView?.addSubview(separator(CGRect.init(x: 10, y: y, width: Int(SCREEN_WIDTH * 0.6 - 20), height: 1), color: UIColor(hex: "e1e1e1"), alpha: 1))    }
    
    // MARK: - actions
    func btnTapped() {
        self.hide()
//        self.resumeGameAction?()
    }
    
    
    // MARK: - pubilc methods
    func hide() {
        self.transform = CGAffineTransform.init(scaleX: 1, y: 1)
        UIView.animate(withDuration: 1.0,
                       delay: 0,
                       usingSpringWithDamping: 8,
                       initialSpringVelocity: 0.0,
                       options: UIViewAnimationOptions.curveEaseOut,
                       animations: { () -> Void in
                        self.alpha = 0
                        self.transform = CGAffineTransform.init(scaleX: 1, y: 1)
                        self.maskDarkView?.alpha = 0
        }, completion: { (finished) -> Void in
            //            self.removeAllSubviews()
            self.removeFromSuperview()
            self.maskDarkView?.removeFromSuperview()
        })
    }
    
    func show(in window: UIWindow? = UIApplication.shared.keyWindow) {
        
        window?.addSubview(self.maskDarkView!)
        window?.addSubview(self)
        
        self.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: SCREEN_WIDTH * 0.6, height: 180))
            make.center.equalTo((window?.center)!)
        }
        
        self.transform = CGAffineTransform.init(scaleX: 0, y: 0)
        UIView.animate(withDuration: 0.2,
                       delay: 0,
                       usingSpringWithDamping: 8,
                       initialSpringVelocity: 0.0,
                       options: UIViewAnimationOptions.curveEaseOut,
                       animations: { () -> Void in
                        self.alpha = 1
                        self.transform = CGAffineTransform.init(scaleX: 1, y: 1)
                        self.maskDarkView?.alpha = 1
        }, completion: { (finished) -> Void in
            
        })
        
//        self.resumeGameAction = resumeGameAction
    }
}
