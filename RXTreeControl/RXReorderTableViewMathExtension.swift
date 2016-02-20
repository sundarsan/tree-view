//
//  RXReorderTableViewMathExtension.swift
//  RXTreeControl
//
//  Created by Arcilite on 19.02.16.
//  Copyright © 2016 Arcilite. All rights reserved.
//

import Foundation
import UIKit
extension RXReorderTableView {
  
// internal func scrollTableWithCell(sender: CADisplayLink) {
//    if let gesture = self.longPressGestureRecognizer {
//      
//      let location = gesture.locationInView(self)
//      
//      if !(location.y.isNaN || location.x.isNaN) {
//        
//        
//        contentOffset = getContentOffsetLocation(location)
//        
//        if let draggingView = movedView  where(location.y >= 0) && (location.y <= (contentSize.height + 50.0)) {
//          
//          draggingView.center = CGPointMake(location.x, location.y)
//          
//        }
//        
//        self.updateCurrentLocation(gesture)
//      }
//    }
//  }
//  
//  func directionRate(location: CGPoint) -> Double {
//    
//    var rate = 0.0
//    
//    if let draggingView = movedView {
//      // Update position of the moved view,
//      if (location.y >= 0.0) && (location.y <= contentSize.height + 50.0) {
//        draggingView.center = CGPointMake(location.x, location.y)
//      }
//    }
//    
//    var rect = bounds
//    
//    rect.size.height -= contentInset.top
//    
//    // Check if we should scroll, and in which direction.
//    let scrollZoneHeight = rect.size.height / 6.0
//    let bottomScrollBeginning = contentOffset.y + contentInset.top + rect.size.height - scrollZoneHeight
//    let topScrollBeginning = contentOffset.y + contentInset.top  + scrollZoneHeight
//    
//    //  bottom zone.
//    if location.y >= bottomScrollBeginning {
//      rate = Double(location.y - bottomScrollBeginning) / Double(scrollZoneHeight)
//    }
//      //  top zone.
//    else if location.y <= topScrollBeginning {
//      rate = Double(location.y - topScrollBeginning) / Double(scrollZoneHeight)
//    } else {
//      rate = 0.0
//    }
//    
//    return rate
//  }
//  
//  func getContentOffsetLocation(location:CGPoint) -> CGPoint{
//    
//    
//    let yOffset = Double(contentOffset.y) + scrollRate * 10.0
//    var newOffset = CGPointMake(contentOffset.x, CGFloat(yOffset))
//    
//    if newOffset.y < -contentInset.top {
//      newOffset.y = -contentInset.top
//    } else if (contentSize.height + contentInset.bottom) < frame.size.height {
//      newOffset = contentOffset
//    } else if newOffset.y > ((contentSize.height + contentInset.bottom) - frame.size.height) {
//      newOffset.y = (contentSize.height + contentInset.bottom) - frame.size.height
//    }
//    return newOffset
//  }
//  
//  func finishScrolingOperation() {
//    // remove scrolling CADisplayLink because scrolling operation was finshed
//    scrollDisplayLink?.invalidate()
//    scrollDisplayLink = nil
//    scrollRate = 0.0
//  }
  
  
  
}