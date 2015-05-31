//
//  Suamo__Tools(CaLayer).swift
//  SuamoDemo
//
//  Created by kiddopal on 15/5/31.
//  Copyright (c) 2015年 Suamo. All rights reserved.
//

import UIKit
//--------------------
//Tools Function
//--------------------
func randomNumber0_i(endNumber x:Int?)->CGFloat{
    if x != nil{
        return CGFloat(Int(arc4random()) % x!)
    }else{
        return CGFloat(arc4random() ) / 0xFFFFFFFF
    }
}

func randomColor()->UIColor{
    return UIColor(red: randomNumber0_i(endNumber: nil), green: randomNumber0_i(endNumber: nil), blue: randomNumber0_i(endNumber: nil), alpha: 1)
}

//--------------------
//CaLayer
//--------------------
extension CALayer{
    func shake(){
        var shaking : CAKeyframeAnimation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        var s : CGFloat = 16
        shaking.values = [-s,0,s,0,-s,0,s,0]
        shaking.duration = 0.1
        shaking.repeatCount = 2
        shaking.removedOnCompletion = true
        self.addAnimation(shaking, forKey: "shaking")
        
    }
}
