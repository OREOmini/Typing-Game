//
//  ViewController.swift
//  Typing
//
//  Created by wangyunwen on 18/3/6.
//  Copyright © 2018年 YunwenWang. All rights reserved.
//

import UIKit
import SnapKit
import TextFieldEffects

class ViewController: UIViewController, UITextFieldDelegate {
    var nameField:KaedeTextField?

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElement()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // 点击空白收回键盘
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    // 点击return收回键盘
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func setUpElement() {
        self.view.backgroundColor = UIColor(hex: "#f2ecde")
        
        nameField = KaedeTextField()
        nameField?.add(to: self.view)
            .layout(snpMaker: { (make) in
                make.width.equalToSuperview().dividedBy(2)
                make.height.equalTo(40)
                make.centerX.equalToSuperview()
                make.centerY.equalToSuperview().offset(40)
            }).config({ (view) in
                view.placeholderColor = .darkGray
                view.foregroundColor = .lightGray
                view.placeholder = "请输入姓名"
                view.delegate = self
//                view.textColor = .white
                
                view.backgroundColor = UIColor(hex: "#bfbfbf")
                
//                view.placeholderFontScale = 0.8
            })

        
        let startBtn = UIButton()
            .add(to: self.view)
            .layout { (make) in
                make.width.height.equalTo(100)
                make.centerX.equalToSuperview()
                make.top.equalTo((nameField?.snp.bottom)!).offset(40)
        }.config { (btn) in
            btn.setTitle("开始", for: .normal)
            btn.setTitleColor(.white, for: .normal)
            btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
            btn.backgroundColor = .gray
            btn.addTarget(self, action: #selector(startGame), for: .touchUpInside)
            btn.layer.cornerRadius = 50
        }
        
        let daImageView = UIImageView().add(to: self.view)
            .layout { (make) in
//                make.top.equalToSuperview().offset(100)
                make.bottom.equalTo(nameField!.snp.top).offset(-80)
                make.right.equalTo(nameField!.snp.centerX).offset(-10)
                make.width.height.equalTo(140)
        }.config { (view) in
            view.image = UIImage(named: "da_img.png")
            view.contentMode = .scaleToFill
        }
        UIImageView().add(to: self.view)
            .layout { (make) in
                make.top.equalTo(daImageView.snp.top)
                make.left.equalTo(startBtn.snp.centerX).offset(10)
                make.width.height.equalTo(140)
        }.config { (view) in
            view.image = UIImage(named: "zi_img.png")
            view.contentMode = .scaleToFill
        }
        
 
        
    }
    
    func startGame() {
        let gameView = GameViewController()
        self.present(gameView, animated: true, completion: nil)
//        self.navigationController!.pushViewController(gameView, animated: true)
    }
}

