//
//  PauseGameView.swift
//  Typing
//
//  Created by wangyunwen on 18/5/17.
//  Copyright © 2018年 YunwenWang. All rights reserved.
//

import Foundation
import UIKit

class PauseGameView: UIView {
    let SCREEN_WIDTH = UIScreen.main.bounds.width
    
    fileprivate var maskDarkView: UIView?
    fileprivate var confirmView: UIView?
    
//    fileprivate var cnCarAction: (() -> Void)?
    fileprivate var resumeGameAction: (() -> Void)?
    
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

extension PauseGameView {
    func setupElements() {
        
        self.alpha = 0
        
        let maskDarkView = UIButton(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: UIScreen.main.bounds.height))
        maskDarkView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        maskDarkView.alpha = 0
        self.maskDarkView = maskDarkView
//        let maskDarkView = UIButton()
//            layout { (make) in
//                make.width.equalTo(SCREEN_WIDTH)
//                make.height.equalTo(UIScreen.main.bounds.height)
//        }.config { (maskDarkView) in
//            maskDarkView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
//            maskDarkView.alpha = 0
//        }
//        self.maskDarkView = maskDarkView
        
        self.isUserInteractionEnabled = true
//        self.addGestureRecognizer(UITapGestureRecognizer(actionBlock: { (sender) in
//            self.hide()
//        }))
        
        let confirmView = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH * 0.5, height: 150))
        confirmView.backgroundColor = .white
        confirmView.layer.cornerRadius = 8
        confirmView.layer.masksToBounds = true
//        let confirmView = UIView().add(to: self)
//            layout { (make) in
//                make.width.equalTo(SCREEN_WIDTH)
//                make.height.equalTo(150)
//        }.config { (confirmView) in
//            confirmView.backgroundColor = .white
//            confirmView.layer.cornerRadius = 8
//            confirmView.layer.masksToBounds = true
//        }
        let image = UIButton(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH * 0.5, height: 87))
        image.imageView?.image = UIImage(named: "pause_btn")
        confirmView.addSubview(img)
        
        let cnCarBtn = UIButton(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH * 0.5, height: 87))
        cnCarBtn.setTitle("继续游戏", for: .normal)
        cnCarBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)

        cnCarBtn.titleEdgeInsets = UIEdgeInsetsMake(5, 0, 0, 0)
        cnCarBtn.tintColor = .gray
        cnCarBtn.titleLabel?.textColor = .gray
        cnCarBtn.addTarget(self, action: #selector(PauseGameView.btnTapped), for: .touchUpInside)
        
        confirmView.addSubview(cnCarBtn)

        self.addSubview(confirmView)
        
        self.confirmView = confirmView
    }
    
    // MARK: - actions
    func btnTapped() {
        self.hide()
        self.resumeGameAction?()
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
    
    func show(in window: UIWindow? = UIApplication.shared.keyWindow, resumeGameAction: (() -> Void)? = nil) {
        
        window?.addSubview(self.maskDarkView!)
        window?.addSubview(self)
        
        self.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: SCREEN_WIDTH * 0.5, height: 175))
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
        
        self.resumeGameAction = resumeGameAction
    }
}


