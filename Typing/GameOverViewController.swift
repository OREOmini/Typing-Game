//
//  GameOverViewController.swift
//  Typing
//
//  Created by wangyunwen on 18/4/15.
//  Copyright © 2018年 YunwenWang. All rights reserved.
//


import Foundation
import UIKit
import SnapKit

class GameOverViewController: UIViewController {
    var score:Int?
    var name:String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElement()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func setUpElement() {
        let THEME_RED = UIColor(hex: "#a98175")
        let THEME_BLUE = UIColor(hex: "#50616d")

        self.view.backgroundColor = UIColor(hex: "#f2ecde")
        
        
        let scoreLabel = UILabel().add(to: self.view)
            .layout(snpMaker: { (make) in
                make.center.equalToSuperview()
            })
            .config { (view) in
                view.textColor = THEME_RED
                view.font = UIFont.boldSystemFont(ofSize: 120)
                view.text = String(score!)
        }
        
        
        UILabel().add(to: self.view)
            .layout(snpMaker: { (make) in
                make.centerX.equalToSuperview()
                make.bottom.equalTo(scoreLabel.snp.top).offset(-30)
            })
            .config { (view) in
                view.text = "您一分钟打字数目为"
//                view.text = name
                view.font = UIFont.boldSystemFont(ofSize: 24)
                view.textColor = THEME_BLUE
        }
        UILabel().add(to: self.view)
            .layout(snpMaker: { (make) in
                make.centerX.equalToSuperview()
                make.bottom.equalTo(scoreLabel.snp.bottom).offset(10)
            })
            .config { (view) in
                //                view.text = "您一分钟打字数目为"
                view.text = "最高分为：" + String(getHighestScore())
                view.font = UIFont.boldSystemFont(ofSize: 18)
                view.textColor = THEME_BLUE
        }
        UIButton().add(to: self.view)
            .layout { (make) in
                make.centerX.equalToSuperview()
                make.top.equalTo(scoreLabel.snp.bottom).offset(30)
                make.width.equalTo(120)
                make.height.equalTo(40)
        }.config { (btn) in
//            view.setImage(UIImage(named: "restart_btn"), for: .normal)
            btn.addTarget(self, action: #selector(restartGame), for: .touchUpInside)
            btn.setTitle("重新开始", for: .normal)
            btn.setTitleColor(.white, for: .normal)
            btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
            btn.backgroundColor = .gray
            btn.layer.cornerRadius = 8

//            view.backgroundColor = .white
//            view.layer.cornerRadius = 30
        }
        UIButton().add(to: self.view)
            .layout { (make) in
                make.centerX.equalToSuperview()
                make.top.equalTo(scoreLabel.snp.bottom).offset(80)
                make.width.equalTo(70)
                make.height.equalTo(70)
            }.config { (btn) in
                //            view.setImage(UIImage(named: "restart_btn"), for: .normal)
                btn.addTarget(self, action: #selector(showRanking), for: .touchUpInside)
//                btn.setTitle("重新开始", for: .normal)
//                btn.setTitleColor(.white, for: .normal)
//                btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
//                btn.backgroundColor = .gray
//                btn.layer.cornerRadius = 8
                btn.setImage(UIImage(named: "ranking"), for: .normal)
                //            view.backgroundColor = .white
                //            view.layer.cornerRadius = 30
        }

    }
    func restartGame() {
        let gameView = GameViewController()
        gameView.name = name!
        self.present(gameView, animated: true, completion: nil)
    }
    func showRanking() {
        let scoreView = ScoreRankingView()
        scoreView.show(in: self.view.window)
    }
}
