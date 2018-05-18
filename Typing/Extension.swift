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
import CoreData


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

// MARK: 数据库处理
let app = UIApplication.shared.delegate as! AppDelegate
let context = app.persistentContainer.viewContext

func getHighestPlayer() -> Player {
    let fetchRequest = NSFetchRequest<Player>(entityName:"Player")
    var hScore = 0
    var hPlayer = Player()
    
    do {
        let fetchedObjects = try context.fetch(fetchRequest)
        
        //遍历查询的结果
        for info in fetchedObjects{
            print(info)
            let score = Int(info.score)
            if (score > hScore) {
                hScore = score
                hPlayer = info
            }
        }
    }catch {
        fatalError("Error：\(error)")
    }
    return hPlayer
}


func getHighestScore() -> Int {
    let fetchRequest = NSFetchRequest<Player>(entityName:"Player")
    var hScore = 0
    
    do {
        let fetchedObjects = try context.fetch(fetchRequest)
        
        //遍历查询的结果
        for info in fetchedObjects{
            print(info)
            let score = Int(info.score)
            if (score > hScore) {
                hScore = score
            }
        }
    }catch {
        fatalError("Error：\(error)")
    }
    return hScore;
}

func addNewPlayer(name: String, score: Int) {
    // 判断是否存在
    let fetchRequest = NSFetchRequest<Player>(entityName:"Player")
    
    do {
        let fetchedObjects = try context.fetch(fetchRequest)
        
        //遍历查询的结果
        for info in fetchedObjects{
            if (name == info.name) {
                if (Int16(score) > info.score) {
                    info.score = Int16(score)
                    try context.save()
                }
                // 直接返回
                return
            }
        }
    }catch {
        fatalError("Error：\(error)")
    }

    //创建User对象
    let player = NSEntityDescription.insertNewObject(forEntityName: "Player",
                                                     into: context) as! Player
    
    //对象赋值
    player.name = name
    player.score = Int16(score)
    
    //保存
    do {
        try context.save()
        print("保存成功！")
    } catch {
        fatalError("不能保存：\(error)")
    }
}


//func getDrinkingPlayer() -> Int {
//    
//    let fetchRequest = NSFetchRequest<Player>(entityName:"Player")
//    var num = 0
//    
//    do {
//        let fetchedObjects = try context.fetch(fetchRequest)
//        
//        //遍历查询的结果
//        for info in fetchedObjects{
//            num = Int(info.drinkingPlayer)
//        }
//    }
//    catch {
//        fatalError("不能保存：\(error)")
//    }
//    
//    return num
//}
//
//func getTotalPlayer() -> Int {
//    
//    let fetchRequest = NSFetchRequest<Player>(entityName:"Player")
//    var num = 0
//    
//    do {
//        let fetchedObjects = try context.fetch(fetchRequest)
//        
//        //遍历查询的结果
//        for info in fetchedObjects{
//            print("id=\(info.drinkingPlayer)")
//            num = Int(info.totalPlayer)
//        }
//    }
//    catch {
//        fatalError("不能保存：\(error)")
//    }
//    
//    return num
//}
//
//func changeCoreDataDrinkingPlayerTo(newPlayer: Int?) {
//    let fetchRequest = NSFetchRequest<Player>(entityName:"Player")
//    
//    do {
//        let fetchedObjects = try context.fetch(fetchRequest)
//        for info in fetchedObjects{
//            info.drinkingPlayer = Int16(newPlayer!)
//            try context.save()
//        }
//        
//    } catch {
//        fatalError("不能保存：\(error)")
//    }
//}
//
//func changeCoreDataTotalPlayerTo(newPlayer: Int?) {
//    
//    let fetchRequest = NSFetchRequest<Player>(entityName:"Player")
//    
//    do {
//        let fetchedObjects = try context.fetch(fetchRequest)
//        for info in fetchedObjects{
//            print("id=\(info.totalPlayer)")
//            
//            info.totalPlayer = Int16(newPlayer!)
//            try context.save()
//        }
//        
//    } catch {
//        fatalError("不能保存：\(error)")
//    }
//}
//
//func deleteAll() {
//    let fetchRequest = NSFetchRequest<Player>(entityName:"Player")
//    
//    do {
//        let fetchedObjects = try context.fetch(fetchRequest)
//        for info in fetchedObjects{
//            context.delete(info)
//            try context.save()
//        }
//        
//    } catch {
//        fatalError("不能删除：\(error)")
//    }
//}
//
//func hasData() -> Bool {
//    let fetchRequest = NSFetchRequest<Player>(entityName:"Player")
//    var f = false
//    
//    do {
//        let fetchedObjects = try context.fetch(fetchRequest)
//        for _ in fetchedObjects{
//            f = true
//            print("hasData")
//        }
//        
//    } catch {
//        fatalError("不能删除：\(error)")
//    }
//    return f
//}
//
//
