//
//  RXReorderViewExtension.swift
//  RXTreeControl
//
//  Created by Arcilite on 19.02.16.
//  Copyright © 2016 Arcilite. All rights reserved.
//

import Foundation
import UIKit

extension UIView{
  
//  func addPulseAnimationDuration(duration:CFTimeInterval = 1.0 ,repeatDuration:CFTimeInterval = 0.1,fromValue:Double = 0.0,toValue:Double = 1.0 ,timingFunction:String = kCAMediaTimingFunctionEaseInEaseOut,autoreverses :Bool = true,repeatCount:Float = 30,key:String? = nil){
//    let pulseAnimationCell: CABasicAnimation = CABasicAnimation(keyPath: "opacity")
//    pulseAnimationCell.duration =  duration
//    pulseAnimationCell.repeatDuration = repeatDuration
//    pulseAnimationCell.fromValue = (fromValue)
//    pulseAnimationCell.toValue = (toValue)
//    pulseAnimationCell.timingFunction = CAMediaTimingFunction(name: timingFunction)
//    pulseAnimationCell.autoreverses = autoreverses
//    pulseAnimationCell.repeatCount = repeatCount
//    
//    self.layer.addAnimation(pulseAnimationCell, forKey: key)
//    
//  }
  
  func addShadowOnView(){
    self.layer.masksToBounds = false
    self.layer.shadowColor = UIColor.blackColor().CGColor
    self.layer.shadowOffset = CGSize.zero
    self.layer.shadowRadius = 4.0
    self.layer.shadowOpacity = 0.7
    self.layer.opacity = 0.55
  }
  
  func unscaleView(scaleWidth:CGFloat = 0.6 ,scaleHeight:CGFloat = 0.6){
    UIView.beginAnimations("unscale", context: nil)
    self.transform = CGAffineTransformMakeScale(scaleWidth, scaleHeight)
    UIView.commitAnimations()
  }
  
  func scaleView(scaleWidth:CGFloat = 1.0, scaleHeight:CGFloat = 1.0){
    UIView.beginAnimations("scale", context: nil)
    self.transform = CGAffineTransformMakeScale(scaleWidth, scaleHeight)
    UIView.commitAnimations()
  }
  
  func viewImage() -> UIImage {
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, 0.0)
    self.layer.renderInContext(UIGraphicsGetCurrentContext()!)
    let cellImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return cellImage
  }
}