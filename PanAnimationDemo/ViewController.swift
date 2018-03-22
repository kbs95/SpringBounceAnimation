//
//  ViewController.swift
//  PanAnimationDemo
//
//  Created by Karanbir Singh on 11/15/17.
//  Copyright © 2017 Abcplusd. All rights reserved.
//

import UIKit

class ViewController: UIViewController,CAAnimationDelegate {

    
    var lineShapLayer = CAShapeLayer()
    var wobbleView = UIView()
    var panGesture:UIPanGestureRecognizer!
    var touchEndPoint:CGPoint!
    var bounceCount:Int = 0
    var lastCGpoint:CGPoint!
    var bouncesTop:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpLineLayer()
        setUpPanGesture()
        view.addSubview(wobbleView)
    }

    func setUpLineLayer(){
        
        // setup initial line layer
        
        wobbleView.frame = view.frame
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: view.frame.height/2))
        path.addCurve(to: CGPoint(x: view.frame.width, y: view.frame.height/2), controlPoint1: CGPoint(x: view.frame.width/2, y: (view.frame.height/2)), controlPoint2: CGPoint(x: view.frame.width, y: view.frame.height/2))
        
        lineShapLayer.fillColor = UIColor.white.cgColor
        lineShapLayer.strokeColor = UIColor.blue.cgColor
        lineShapLayer.lineWidth = 3
        lineShapLayer.path = path.cgPath
        
//        wobbleView.frame = CGRect(x: 0, y: Int(view.frame.height/2), width: Int(view.frame.width), height: 1000)
        wobbleView.layer.addSublayer(lineShapLayer)
        
        lastCGpoint = CGPoint(x: 0, y: view.frame.height/2)
    }
    
    func setUpPanGesture(){
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(didPanned))
        view.addGestureRecognizer(panGesture)
    }
    
    
    func didPanned(sender:UIPanGestureRecognizer){
        print(sender.translation(in: view))
        if sender.translation(in: view).y < 0{
            bouncesTop = false
        }else{
            bouncesTop = true
        }
        if sender.state == .ended{
            touchEndPoint = sender.location(in: view)
            performBounceBack(point: sender.location(in: view))
            return
        }
        performAnimation(point: sender.location(in: view))
    }
    
    
    func performAnimation(point:CGPoint){
        // perform movement and animation of layer
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: point.y))
        if point.y < (lastCGpoint.y){
            path.addCurve(to: CGPoint(x: view.frame.width, y: point.y), controlPoint1: CGPoint(x:point.x,y:point.y - 100), controlPoint2: CGPoint(x: view.frame.width, y: point.y))
        }else if point.y > (lastCGpoint.y){
            path.addCurve(to: CGPoint(x: view.frame.width, y: point.y), controlPoint1: CGPoint(x:point.x,y:point.y + 100), controlPoint2: CGPoint(x: view.frame.width, y: point.y))
        }else{
            path.addCurve(to: CGPoint(x: view.frame.width, y: point.y), controlPoint1: CGPoint(x:point.x,y:point.y), controlPoint2: CGPoint(x: view.frame.width, y: point.y))
        }
        
        // adding path animation
        
        let animation = CABasicAnimation(keyPath: "path")
        animation.duration = 0.3
        
        animation.toValue = path
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        
        animation.fillMode = kCAFillModeForwards
        animation.isRemovedOnCompletion = false
        
        lineShapLayer.add(animation, forKey: "path")
        lineShapLayer.path = path.cgPath
        lastCGpoint = point
    }
    
    func performBounceBack(point:CGPoint){
        
        
        // perform bouncing effect 
        let path1 = UIBezierPath()
        path1.move(to: CGPoint(x: 0, y: point.y))
       
        if bouncesTop {
            path1.addCurve(to: CGPoint(x: view.frame.width, y: point.y), controlPoint1: CGPoint(x:point.x,y:point.y - 40), controlPoint2: CGPoint(x: view.frame.width, y: point.y))
        }else{
            path1.addCurve(to: CGPoint(x: view.frame.width, y: point.y), controlPoint1: CGPoint(x:point.x,y:point.y + 40), controlPoint2: CGPoint(x: view.frame.width, y: point.y))
        }
        
        // adding path animation
        
        let animation1 = CABasicAnimation(keyPath: "path")
        animation1.duration = 0.25
        
        animation1.toValue = path1
        animation1.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        animation1.delegate = self
        
        animation1.fillMode = kCAFillModeForwards
        animation1.isRemovedOnCompletion = false
        
        lineShapLayer.add(animation1, forKey: "path")
        lineShapLayer.path = path1.cgPath
        
       /////////////////////////////////////////////////////////////////////////////////////////
        
        
    }
    
    func addNextAnimation(animNumber:Int){
        
        let point:CGPoint = touchEndPoint
        
        if animNumber == 1{
        
            let path2 = UIBezierPath()
            path2.move(to: CGPoint(x: 0, y: point.y))
            
            if bouncesTop {
                path2.addCurve(to: CGPoint(x: view.frame.width, y: point.y), controlPoint1: CGPoint(x:point.x,y:point.y + 20), controlPoint2: CGPoint(x: view.frame.width, y: point.y))
            }else{
                path2.addCurve(to: CGPoint(x: view.frame.width, y: point.y), controlPoint1: CGPoint(x:point.x,y:point.y - 20), controlPoint2: CGPoint(x: view.frame.width, y: point.y))
            }
            
            // adding path animation
            
            let animation2 = CABasicAnimation(keyPath: "path")
            animation2.duration = 0.25
            
            animation2.toValue = path2
            animation2.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
            animation2.delegate = self
            
            animation2.fillMode = kCAFillModeForwards
            animation2.isRemovedOnCompletion = false
            
            lineShapLayer.add(animation2, forKey: "path")
            lineShapLayer.path = path2.cgPath
        }
        
        /////////////////////////////////////////////////////////////////////////////////////////
        
        if animNumber == 2{
        
            let path3 = UIBezierPath()
            path3.move(to: CGPoint(x: 0, y: point.y))
            
            if bouncesTop {
                path3.addCurve(to: CGPoint(x: view.frame.width, y: point.y), controlPoint1: CGPoint(x:point.x,y:point.y - 5), controlPoint2: CGPoint(x: view.frame.width, y: point.y))
            }else{
                path3.addCurve(to: CGPoint(x: view.frame.width, y: point.y), controlPoint1: CGPoint(x:point.x,y:point.y + 5), controlPoint2: CGPoint(x: view.frame.width, y: point.y))
            }
            
            // adding path animation
            
            let animation3 = CABasicAnimation(keyPath: "path")
            animation3.duration = 0.25
            
            animation3.toValue = path3
            animation3.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
            animation3.delegate = self
            
            animation3.fillMode = kCAFillModeForwards
            animation3.isRemovedOnCompletion = false
            
            lineShapLayer.add(animation3, forKey: "path")
            lineShapLayer.path = path3.cgPath
        
        }
        /////////////////////////////////////////////////////////////////////////////////////////
        
        if animNumber == 3{
        
            let path4 = UIBezierPath()
            path4.move(to: CGPoint(x: 0, y: point.y))
            
            path4.addCurve(to: CGPoint(x: view.frame.width, y: point.y), controlPoint1: CGPoint(x:point.x,y:point.y), controlPoint2: CGPoint(x: view.frame.width, y: point.y))
            
            // adding path animation
            
            let animation4 = CABasicAnimation(keyPath: "path")
            animation4.duration = 0.25
            
            animation4.toValue = path4
            animation4.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
            
            animation4.fillMode = kCAFillModeForwards
            animation4.isRemovedOnCompletion = false
            
            lineShapLayer.add(animation4, forKey: "path")
            lineShapLayer.path = path4.cgPath
            bounceCount = 0
        }
        /////////////////////////////////////////////////////////////////////////////////////////

    }
    
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        bounceCount += 1
        addNextAnimation(animNumber: bounceCount)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

}

