//
//  FirstViewController.swift
//  SuamoDemo
//
//  Created by kiddopal on 15/5/29.
//  Copyright (c) 2015年 Suamo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var hudBtn: UIButton!
    @IBOutlet weak var wsBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Suamo__Hud.showSuccess(Status: "Welcome to Suamo", Interaction: true)
        
        self.view.backgroundColor = randomColor()
        
        hudBtn.backgroundColor = randomColor()
        hudBtn.layer.masksToBounds = true
        hudBtn.layer.cornerRadius = 10.0
        hudBtn.addTarget(self, action: "showOtherView:event:", forControlEvents: UIControlEvents.TouchUpInside)
        
        wsBtn.backgroundColor = randomColor()
        wsBtn.layer.masksToBounds = true
        wsBtn.layer.cornerRadius = 10.0
        wsBtn.addTarget(self, action: "showOtherView:event:", forControlEvents: UIControlEvents.TouchUpInside)

    }
    
    @IBAction func changeViewByTap(sender: AnyObject) {
        var tap : UIGestureRecognizer = sender as! UIGestureRecognizer
        var touchPosition : CGPoint = tap.locationInView(self.view)
        
        if randomNumber0_i(endNumber: nil) > 0.5 {
            self.view.inflateAnimatedFromPoint(point: touchPosition, backgroundcolor: randomColor(), duration: 0.75, completion: { () -> Void in
                
            })
        }else{
            self.view.deflateAnimatedToPoint(point: touchPosition, backgroundcolor: randomColor(), duration: 0.75, completion: { () -> Void in
                
            })
        }

    }

    func showOtherView(sender:UIButton, event:UIEvent){
        if sender.tag == 10001{
            self.performSegueWithIdentifier("hudAction", sender: nil)
        }else if sender.tag == 10002{
            self.performSegueWithIdentifier("wsAction", sender: nil)
        }
//        var touchePosition : CGPoint  = (event.allTouches()!.first as! UITouch).locationInView(self.view)
//        if sender.tag == 1{
//            UIView.Suamo__InflateWaveSpread(fromView: self.backgroundView, toView: self.WsView, originalPoint: touchePosition, duration: 1.5) { () -> Void in
//                println("O~houhou^^^^")
//            }
//        }else{
//            UIView.Suamo__DeflateWaveSpread(fromView: self.WsView, toView: self.backgroundView, originalPoint: touchePosition, duration: 1.5, completion: { () -> Void in
//                println("O~houhou^^^^")
//            })
////            UIView.Suamo__InflateWaveSpread(fromView: self.view2, toView: self.view1, originalPoint: touchePosition, duration: 1.5) { () -> Void in
////                println("O~houhou^^^^")
////            }
//        }
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
