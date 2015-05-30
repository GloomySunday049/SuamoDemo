//
//  Suamo__WaveSpread.swift
//  SuamoDemo
//
//  Created by kiddopal on 15/5/29.
//  Copyright (c) 2015年 Suamo. All rights reserved.
//

import UIKit

let Suamo__WaveSpread_TransitionDuration = 0.65

extension UIView{
    
    static func Suamo__InflateWaveSpread(fromView x:UIView!, toView y:UIView!,originalPoint z:CGPoint!,duration w:NSTimeInterval!,completion :(() -> Void)){
        if x.superview != nil{
            var containerView : UIView = x.superview!
            var convertedPoint :CGPoint = x.convertPoint(z, fromView: x)
            
            containerView.layer.masksToBounds = true
            
            containerView.animatedAtPoint(point: convertedPoint, backgroundColor: y.backgroundColor!, duration: w * Suamo__WaveSpread_TransitionDuration, inflating: true, zTopPosition: true, shapelayer: nil, completion: { () -> Void in
                y.alpha = 0
                
                y.frame = x.frame
                containerView.addSubview(y)
                x.removeFromSuperview()
                
                var animationDuration :NSTimeInterval = (w - w * Suamo__WaveSpread_TransitionDuration)
                
                UIView.animateWithDuration(animationDuration, animations: { () -> Void in
                    y.alpha = 1
                }, completion: { (Bool) -> Void in
                    completion()
                })
                
            })
        }else{
            completion()
        }
        
    }
    
    static func Suamo__DeflateWaveSpread(fromView x:UIView!, toView y:UIView!,originalPoint z:CGPoint!,duration w:NSTimeInterval!,completion :(() -> Void)){
        if x.superview != nil{
            var containerView : UIView = x.superview!
            containerView.insertSubview(y, belowSubview: x)
            y.frame = x.frame
            
            var convertedPoint : CGPoint = y.convertPoint(z, fromView: x)
            
            var layer : CAShapeLayer = y.shaperLayerForAnimationAtPoint(point: convertedPoint)
            layer.fillColor = x.backgroundColor?.CGColor
            y.layer.addSublayer(layer)
            y.layer.masksToBounds = true
            
            var animationDuration = (w - w * Suamo__WaveSpread_TransitionDuration)
            UIView.animateWithDuration(animationDuration, animations: { () -> Void in
                x.alpha = 0
            }, completion: { (Bool) -> Void in
                y.animatedAtPoint(point: convertedPoint, backgroundColor: x.backgroundColor!, duration: w * Suamo__WaveSpread_TransitionDuration, inflating: false, zTopPosition: true, shapelayer: layer, completion: { () -> Void in
                    completion()
                })
            })
        }else{
            completion()
        }
    }
    
    
    func inflateAnimatedFromPoint(point x:CGPoint,backgroundcolor y:UIColor,duration z:NSTimeInterval,completion :(()->Void)){
        self.animatedAtPoint(point: x, backgroundColor: y, duration: z, inflating: true, zTopPosition: false, shapelayer: nil) { () -> Void in
            completion()
        }

    }
    
    func deflateAnimatedToPoint(point x:CGPoint,backgroundcolor y:UIColor,duration z:NSTimeInterval,completion :(()->Void)){
        self.animatedAtPoint(point: x, backgroundColor: y, duration: z, inflating: false, zTopPosition: false, shapelayer: nil) { () -> Void in
            completion()
        }
    }
    
    private func animatedAtPoint(point x:CGPoint,backgroundColor y:UIColor,duration z:NSTimeInterval,inflating u:Bool,zTopPosition v:Bool,shapelayer w:CAShapeLayer?,completion :(()->Void)){
        if  w == nil {
            var shapeLayer : CAShapeLayer = shaperLayerForAnimationAtPoint(point: x)
            self.layer.masksToBounds = true
            
            if v{
                self.layer.addSublayer(shapeLayer)
            }else{
                self.layer.insertSublayer(shapeLayer, atIndex: 0)
            }
            
            if u{
                shapeLayer.fillColor = y.CGColor
            }else{
                shapeLayer.fillColor = self.backgroundColor?.CGColor
                self.backgroundColor = y
            }
            
            
            var scale : CGFloat = 1.0 / shapeLayer.frame.size.width
            var timeingFunctionName : String = kCAMediaTimingFunctionDefault
            var animation : CABasicAnimation = shapeAnimationWithTimingFunction(timeingFuncation: CAMediaTimingFunction(name: timeingFunctionName), scale: scale, inflating: u)
            
            animation.duration = z
            shapeLayer.transform = animation.toValue.CATransform3DValue
            
            CATransaction.begin()
            CATransaction.setCompletionBlock({ () -> Void in
                if u{
                    self.backgroundColor = y
                }
                shapeLayer.removeFromSuperlayer()
                completion()
            })
            
            shapeLayer.addAnimation(animation, forKey: "shapeBackgroundAnimation")
            CATransaction.commit()
            
        }else{
            var scale : CGFloat = 1.0 / w!.frame.size.width
            var timeingFunctionName : String = kCAMediaTimingFunctionDefault
            var animation : CABasicAnimation = shapeAnimationWithTimingFunction(timeingFuncation: CAMediaTimingFunction(name: timeingFunctionName), scale: scale, inflating: u)
            
            animation.duration = z
            w!.transform = animation.toValue.CATransform3DValue
            
            CATransaction.begin()
            CATransaction.setCompletionBlock({ () -> Void in
                if u{
                    self.backgroundColor = y
                }
                w!.removeFromSuperlayer()
                completion()
            })
            
            w!.addAnimation(animation, forKey: "shapeBackgroundAnimation")
            CATransaction.commit()
        }
    }
    
    private func shapeAnimationWithTimingFunction(timeingFuncation x:CAMediaTimingFunction,scale y:CGFloat,inflating z:Bool)->CABasicAnimation{
        var animation :CABasicAnimation = CABasicAnimation()
        animation.keyPath = "transform"
        
        if z{
            animation.toValue = NSValue(CATransform3D: CATransform3DMakeScale(1.0, 1.0, 1.0))
            animation.fromValue = NSValue(CATransform3D: CATransform3DMakeScale(y, y, 1.0))
        }else{
            animation.toValue = NSValue(CATransform3D: CATransform3DMakeScale(y, y, 1.0))
            animation.fromValue = NSValue(CATransform3D: CATransform3DMakeScale(1.0, 1.0, 1.0))
        }
        
        animation.timingFunction = x
        animation.removedOnCompletion = true
        return animation
    }
    
    private func shaperLayerForAnimationAtPoint(point x:CGPoint!)->CAShapeLayer{
        var shaperLayer : CAShapeLayer = CAShapeLayer()
        var diameter : CGFloat = shapeDiameterForPoint(point: x)
        shaperLayer.frame = CGRectMake(floor(x.x - diameter * 0.5), floor(x.y - diameter * 0.5), diameter, diameter)
        shaperLayer.path = UIBezierPath(ovalInRect: CGRectMake(0, 0, diameter, diameter)).CGPath
        
        return shaperLayer
    }
    
    private func shapeDiameterForPoint(point x:CGPoint)->CGFloat{
        var cornerPoints : [CGPoint] = [CGPointMake(0, 0),CGPointMake(0, self.bounds.size.height),CGPointMake(self.bounds.size.width, self.bounds.size.height),CGPointMake(self.bounds.size.width, 0)]
        var radius : CGFloat = 0
        
        for (var index = 0; index < 4; index++){
            var p :CGPoint = cornerPoints[index]
            var d : CGFloat = sqrt(pow(p.x - x.x, 2) + pow(p.y - x.y, 2.0))
            
            if d > radius{
                radius = d;
            }
        }
        
        return radius * 2.0
    }
    
    private func fuck(x:NSString!){
        println("\(x)")
        
    }
    
    
    
    
}
