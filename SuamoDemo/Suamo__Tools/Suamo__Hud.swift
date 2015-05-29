//
//  Suamo__Hud.swift
//  Hud
//
//  Created by kiddopal on 15/5/27.
//  Copyright (c) 2015年 孟钰丰. All rights reserved.
//

import UIKit

let Suamo__HUD_STATUS_FONT = UIFont.boldSystemFontOfSize(16)
let Suamo__HUD_STATUS_COLOR = UIColor.blackColor()
let Suamo__HUD_SPINNER_COLOR = UIColor(red: 185.0/255.0, green: 220.0/255.0, blue: 47.0/255.0, alpha: 1.0)
let Suamo__HUD_BACKGROUND_COLOR = UIColor(white: 0.0, alpha: 0.1)
let Suamo__HUD_WINDOW_COLOR = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.2)
let Suamo__HUD_IMAGE_SUCCESS = UIImage(named: "Suamo.bundle/progresshud-success.png")
let Suamo__HUD_IMAGE_ERROR = UIImage(named: "Suamo.bundle/progresshud-error.png")

public class Suamo__Hud: UIView {
    var label : UILabel! = nil
    var image: UIImageView! = nil
    var background : UIView! = nil
    var myWindow : UIWindow! = nil
    var interaction : Bool = false
    var hud :UIToolbar! = nil
    var spinner : UIActivityIndicatorView! = nil
    
    /**
    show Hud With status and can keep
    
    :param: x label.text
    */
    static public func show(States x:String){
        Suamo__Hud.sharedInstance.interaction = true
        Suamo__Hud.sharedInstance.makeHud(Status: x, image: nil, hide: false, spin: true)
    }
    
    /**
    show hud with status and background and can keep
    
    :param: x label.text
    :param: y background or not
    */
    static public func show(States x:String, interaction y:Bool){
        Suamo__Hud.sharedInstance.interaction = y
        Suamo__Hud.sharedInstance.makeHud(Status: x, image: nil, hide: false, spin: true)
    }
    
    /**
    show success hud with status,success image,background and no keep
    
    :param: x label.text
    */
    static public func showSuccess(Status x: String){
        Suamo__Hud.sharedInstance.interaction = true
        Suamo__Hud.sharedInstance.makeHud(Status: x, image: Suamo__HUD_IMAGE_SUCCESS, hide: true, spin: false)
    }
    
    /**
    show success hud with status,success image and no keep
    
    :param: x label.text
    :param: y background or not
    */
    static public func showSuccess(Status x:String, Interaction y:Bool){
        Suamo__Hud.sharedInstance.interaction = y
        Suamo__Hud.sharedInstance.makeHud(Status: x, image: Suamo__HUD_IMAGE_SUCCESS, hide: true, spin: false)
    }
    
    /**
    show error hud with status,error image and no keep
    
    :param: x label.text
    */
    static public func showError(Status x:String){
        Suamo__Hud.sharedInstance.interaction = true
        Suamo__Hud.sharedInstance.makeHud(Status: x, image: Suamo__HUD_IMAGE_ERROR, hide: true, spin: false)
    }
    
    /**
    show error hud with status,error image an no keep
    
    :param: x label.text
    :param: y background or not
    */
    static public func showError(Status x:String, Interaction y:Bool){
        Suamo__Hud.sharedInstance.interaction = y
        Suamo__Hud.sharedInstance.makeHud(Status: x, image: Suamo__HUD_IMAGE_ERROR, hide: true, spin: false)
    }
    
    /**
    dismiss the hud
    */
    static public func dismiss(){
        Suamo__Hud.sharedInstance.endingShowing()
    }

    
    //MARK: - private methods
    class var sharedInstance : Suamo__Hud {
        struct Static {
            static var sharedInstance : Suamo__Hud = Suamo__Hud()
            static var onceToken : dispatch_once_t = 0
        }
        dispatch_once(&Static.onceToken, { () -> Void in
            Static.sharedInstance = Suamo__Hud()
        })
        return Static.sharedInstance
    }
    
    override public init(frame: CGRect) {
        super.init(frame: UIScreen.mainScreen().bounds)
        
        var delegate : UIApplicationDelegate = UIApplication.sharedApplication().delegate!
        if delegate.respondsToSelector("window"){
            myWindow = delegate.window!
        }else{
            myWindow = UIApplication.sharedApplication().keyWindow
        }
        
        self.alpha = 0
    }
    
    required public init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func makeHud(Status x: String?,image y: UIImage?,hide z: Bool,spin w:Bool){
        createHud()
        
        label.text = x
        label.hidden = (x == nil) ? true : false
        
        image.image = y
        image.hidden = (y == nil) ? true : false
        
        if w{
            spinner.startAnimating()
        }else{
            spinner.stopAnimating()
        }
        
        setSize()
        
        setPosition(nil)
        
        endingShowing()
        
        if z {
            NSThread.detachNewThreadSelector("timeRun:", toTarget: self, withObject: nil)
        }
        
    }
    
    private func createHud(){
        if hud == nil{
            hud = UIToolbar(frame: CGRectZero)
            hud.translucent = true
            hud.backgroundColor = Suamo__HUD_BACKGROUND_COLOR
            hud.layer.cornerRadius = 10
            hud.layer.masksToBounds = true
            registerNotifications()
        }
        if hud.superview == nil{
            if interaction{
                myWindow.addSubview(hud)
            }else{
                background = UIView(frame: myWindow.frame)
                background.backgroundColor = Suamo__HUD_WINDOW_COLOR
                myWindow.addSubview(background)
                background.addSubview(hud)
            }
        }
        
        if label == nil{
            label = UILabel(frame: CGRectZero)
            label.font = Suamo__HUD_STATUS_FONT
            label.textColor = Suamo__HUD_STATUS_COLOR
            label.backgroundColor = UIColor.clearColor()
            label.textAlignment = NSTextAlignment.Center
            label.baselineAdjustment = UIBaselineAdjustment.AlignCenters
            label.numberOfLines = 0
        }
        if label.superview == nil{
            hud.addSubview(label)
        }
        
        if spinner == nil{
            spinner = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.WhiteLarge)
            spinner.color = Suamo__HUD_SPINNER_COLOR
            spinner.hidesWhenStopped = true
        }
        if spinner.superview == nil{
            hud.addSubview(spinner)
        }
        
        if image == nil{
            image = UIImageView(frame: CGRectMake(0, 0, 28, 28))
        }
        if image.superview == nil{
            hud.addSubview(image)
        }
    }
    
    private func registerNotifications(){
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "setPosition:", name: UIApplicationDidChangeStatusBarOrientationNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "setPosition:", name: UIKeyboardWillHideNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "setPosition:", name: UIKeyboardDidHideNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "setPosition:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "setPosition:", name: UIKeyboardDidShowNotification, object: nil)
    }
    private func setSize(){
        var labelRect : CGRect = CGRectZero
        var hudWidth : CGFloat = 100
        var hudHeight : CGFloat = 100
        
        if label.text != nil {
            var attributes : NSDictionary = NSDictionary(object: label.font, forKey: NSFontAttributeName)
            var options = NSStringDrawingOptions.UsesFontLeading | NSStringDrawingOptions.TruncatesLastVisibleLine | NSStringDrawingOptions.UsesLineFragmentOrigin
            
            labelRect = (label.text! as NSString).boundingRectWithSize(CGSizeMake(200, 300), options: options, attributes: attributes as [NSObject : AnyObject], context: nil)
            
            labelRect.origin.x = 12
            labelRect.origin.y = 66
            
            hudWidth = labelRect.size.width + 24
            hudHeight = labelRect.size.height + 80
            
            if hudWidth < 100 {
                hudWidth = 100
                labelRect.origin.x = 0
                labelRect.size.width = 100
            }
        }
        
        hud.bounds = CGRectMake(0, 0, hudWidth, hudHeight)
        label.frame = labelRect
        
        var imageX : CGFloat = hudWidth/2
        var imageY : CGFloat = (label.text == nil) ? hudHeight/2 : 36
        spinner.center = CGPointMake(imageX, imageY)
        image.center = CGPointMake(imageX, imageY)
        
    }
    
    func setPosition(sender : AnyObject?){
        var heightKeyboard : CGFloat = 0
        var duration : NSTimeInterval = 0
        
        if sender != nil{
            var notification : NSNotification = (sender as! NSNotification)
            var info : NSDictionary = notification.userInfo!
            var keyboard = info.valueForKey(UIKeyboardFrameEndUserInfoKey)!.CGRectValue()
            duration = info.valueForKey(UIKeyboardAnimationDurationUserInfoKey)!.doubleValue
            
            if notification.name == UIKeyboardWillShowNotification || notification.name == UIKeyboardDidShowNotification{
                heightKeyboard = keyboard.size.height
            }
        }else{
            heightKeyboard = keyboardHeight()
        }
        
        var screen : CGRect = UIScreen.mainScreen().bounds
        var center : CGPoint =  CGPointMake(screen.size.width/2, (screen.size.height - heightKeyboard)/2)
        
        UIView.animateWithDuration(duration, delay: 0, options: UIViewAnimationOptions.AllowUserInteraction, animations: { () -> Void in
            self.hud.center = CGPointMake(center.x, center.y)
            }) {(Bool) -> Void in
                
        }
        
        if background != nil{
            background.frame = myWindow.frame
        }
        
    }
    
    private func endingShowing(){
        if self.alpha == 0 {
            self.alpha = 1
            hud.alpha = 0
            
            hud.transform = CGAffineTransformScale(hud.transform, 1.4, 1.4)
            
            UIView.animateWithDuration(0.15, delay: 0, options: UIViewAnimationOptions.AllowUserInteraction, animations: { () -> Void in
                self.hud.transform = CGAffineTransformScale(self.hud.transform, 1/1.4, 1/1.4)
                self.hud.alpha = 1;
                }, completion: { (Bool) -> Void in
                    
            })
        }
    }
    
    func timeRun(sender : AnyObject){
        autoreleasepool { () -> () in
            var length : Double = Double(self.label!.text!.lengthOfBytesUsingEncoding(NSUTF8StringEncoding))
            var sleep : NSTimeInterval = 0.5 + 0.04 * length
            
            NSThread .sleepForTimeInterval(sleep)
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.showingEndind()
            })
        }
    }
    
    private func showingEndind(){
        if self.alpha == 1{
            UIView.animateWithDuration(0.15, delay: 0, options: UIViewAnimationOptions.AllowUserInteraction, animations: { () -> Void in
                self.hud.transform = CGAffineTransformScale(self.hud.transform, 0.7, 0.7)
                self.hud.alpha = 0
                }, completion: { (Bool) -> Void in
                    self.destoryMy()
                    self.alpha = 0
            })
        }
    }
    
    private func keyboardHeight()->CGFloat{
        for textWindow in UIApplication.sharedApplication().windows{
            if !textWindow.isKindOfClass(UIWindow){
                for possibleKeyBoard in textWindow.subviews{
                    if possibleKeyBoard.description.hasPrefix("<UIPeripheralHostView"){
                        return possibleKeyBoard.bounds.size.height
                    }else if possibleKeyBoard.description.hasPrefix("<UIInputSetContainerView"){
                        for hostKeyboard in possibleKeyBoard.subviews{
                            if hostKeyboard.description.hasPrefix("<UIInputSetHost"){
                                return hostKeyboard.frame.size.height
                            }
                        }
                    }
                }
            }
        }
        
        return 0
    }
    
    private func destoryMy(){
        NSNotificationCenter.defaultCenter().removeObserver(self)
        
        label.removeFromSuperview()
        label = nil
        image.removeFromSuperview()
        image = nil
        spinner.removeFromSuperview()
        spinner = nil
        hud.removeFromSuperview()
        hud = nil
        if !interaction {
            background.removeFromSuperview()
            background = nil
        }
    }
    
    
}
