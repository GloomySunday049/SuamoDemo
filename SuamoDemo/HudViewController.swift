//
//  HudViewController.swift
//  SuamoDemo
//
//  Created by kiddopal on 15/5/30.
//  Copyright (c) 2015年 Suamo. All rights reserved.
//

import UIKit

class HudViewController: UIViewController {
    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btn3: UIButton!
    @IBOutlet weak var btn5: UIButton!
    @IBOutlet weak var btn7: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = randomColor()
        
        btn1.backgroundColor = randomColor()
        btn1.layer.masksToBounds = true
        btn1.layer.cornerRadius = 10.0
        btn3.backgroundColor = randomColor()
        btn3.layer.masksToBounds = true
        btn3.layer.cornerRadius = 10.0
        btn5.backgroundColor = randomColor()
        btn5.layer.masksToBounds = true
        btn5.layer.cornerRadius = 10.0
        btn7.backgroundColor = randomColor()
        btn7.layer.masksToBounds = true
        btn7.layer.cornerRadius = 10.0
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(true)
        
        Suamo__Hud.dismiss()
    }
    @IBAction func show(sender: AnyObject) {
        Suamo__Hud.show(States: "show()")
    }
    
    @IBAction func showSuccess(sender: AnyObject) {
        Suamo__Hud.showSuccess(Status: "showSuccess()")
    }
    
    @IBAction func showError(sender: AnyObject) {
        Suamo__Hud.showError(Status: "showError()")
    }
    
    @IBAction func dismiss(sender: AnyObject) {
        Suamo__Hud.dismiss()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
