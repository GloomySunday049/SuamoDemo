//
//  FirstViewController.swift
//  SuamoDemo
//
//  Created by kiddopal on 15/5/29.
//  Copyright (c) 2015年 Suamo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var goToWsBtn: UIButton!
    @IBOutlet var backgroundView: UIView!
    @IBOutlet weak var WsView: UIView!
    @IBOutlet weak var goBackBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBarHidden = true
        
        Suamo__Hud.showSuccess(Status: "Welcome to Suamo", Interaction: true)
        
        goToWsBtn.addTarget(self, action: "showOtherView:event:", forControlEvents: UIControlEvents.TouchUpInside)
        goBackBtn.addTarget(self, action: "showOtherView:event:", forControlEvents: UIControlEvents.TouchUpInside)
//        
//        view1 = UIView(frame: CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height))
//        view1.backgroundColor = UIColor.redColor()
//        var btn1 : UIButton = UIButton(frame: CGRectMake(200, 200, 100, 100))
//        btn1.tag = 1
//        btn1.backgroundColor = UIColor.whiteColor()
//        view1.addSubview(btn1)
//        
//        btn1.addTarget(self, action: "showOtherView:event:", forControlEvents: UIControlEvents.TouchUpInside)
//        
//        
//        
//        view2 = UIView(frame: CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height))
//        view2.backgroundColor = UIColor.blueColor()
//        var btn2 : UIButton = UIButton(frame: CGRectMake(200, 400, 100, 50))
//        btn2.tag = 2
//        btn2.backgroundColor = UIColor.blackColor()
//        view2.addSubview(btn2)
//        
//        btn2.addTarget(self, action: "showOtherView:event:", forControlEvents: UIControlEvents.TouchUpInside)
//        
//        self.view.addSubview(view1)
        
        // Do any additional setup after loading the view.
    }
    
    
    
    func showOtherView(sender:UIButton, event:UIEvent){
        var touchePosition : CGPoint  = (event.allTouches()!.first as! UITouch).locationInView(self.view)
        if sender.tag == 1{
            UIView.Suamo__InflateWaveSpread(fromView: self.backgroundView, toView: self.WsView, originalPoint: touchePosition, duration: 1.5) { () -> Void in
                println("O~houhou^^^^")
            }
        }else{
            UIView.Suamo__DeflateWaveSpread(fromView: self.WsView, toView: self.backgroundView, originalPoint: touchePosition, duration: 1.5, completion: { () -> Void in
                println("O~houhou^^^^")
            })
//            UIView.Suamo__InflateWaveSpread(fromView: self.view2, toView: self.view1, originalPoint: touchePosition, duration: 1.5) { () -> Void in
//                println("O~houhou^^^^")
//            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
