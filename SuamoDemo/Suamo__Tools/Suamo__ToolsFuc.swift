//
//  Suamo__ToolsFuc.swift
//  SuamoDemo
//
//  Created by kiddopal on 15/5/30.
//  Copyright (c) 2015年 Suamo. All rights reserved.
//

import UIKit

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

