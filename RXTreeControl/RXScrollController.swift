//
//  RXScrollController.swift
//  RXTreeControl
//
//  Created by Arcilite on 20.02.16.
//  Copyright © 2016 Arcilite. All rights reserved.
//

import Foundation
import UIKit

class RXScrollController:NSObject{
  
  internal var scrollRate = 0.0
  
  internal var scrollDisplayLink: CADisplayLink?
  
  private var tableView: RXReorderTableView
  
  init(tableView:RXReorderTableView){
    self.tableView = tableView
  }
  
  
  func scrollTableWithCell(sender: CADisplayLink) {
    if let gesture = tableView.longPressGestureRecognizer {
      
      let location = gesture.locationInView(tableView)
      
      if !(location.y.isNaN || location.x.isNaN) {
        
        tableView.contentOffset = getContentOffsetLocation(location)
        self.setMovedViewLocation(location)
        tableView.getureHandler.updateCurrentLocation(gesture)
      }
    }
  }
  
  func directionRate(location: CGPoint) -> Double {
    
    var rate = 0.0
    
    self.setMovedViewLocation(location)
    
    var rect = tableView.bounds
    
    rect.size.height -= tableView.contentInset.top
    
    // Check if we should scroll, and in which direction.
    let scrollZoneHeight = rect.size.height / 6.0
    let bottomScrollBeginning = tableView.contentOffset.y + tableView.contentInset.top + rect.size.height - scrollZoneHeight                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            
    let topScrollBeginning = tableView.contentOffset.y + tableView.contentInset.top  + scrollZoneHeight
    
    //  bottom zone.
    if location.y >= bottomScrollBeginning {
      rate = Double(location.y - bottomScrollBeginning) / Double(scrollZoneHeight)
    }
      //  top zone.
    else if location.y <= topScrollBeginning {
      rate = Double(location.y - topScrollBeginning) / Double(scrollZoneHeight)
    } else {
      rate = 0.0
    }
    
    return rate
  }
  
  func setMovedViewLocation(location: CGPoint){
    if let draggingView = tableView.movedView  where(location.y >= 0) && (location.y <= (tableView.contentSize.height + 50.0)) {
      
      draggingView.center = CGPointMake(location.x, location.y)
      
    }

  }
  
  func getContentOffsetLocation(location:CGPoint) -> CGPoint{
    
    
    let yOffset = Double(tableView.contentOffset.y) + scrollRate * 10.0
    var newOffset = CGPointMake(tableView.contentOffset.x, CGFloat(yOffset))
    
    if newOffset.y < -tableView.contentInset.top {
      newOffset.y = -tableView.contentInset.top
    } else if (tableView.contentSize.height + tableView.contentInset.bottom) < tableView.frame.size.height {
      newOffset = tableView.contentOffset
    } else if newOffset.y > ((tableView.contentSize.height + tableView.contentInset.bottom) - tableView.frame.size.height) {
      newOffset.y = (tableView.contentSize.height + tableView.contentInset.bottom) - tableView.frame.size.height
    }
    return newOffset
  }
  
  func finishScrolingOperation() {
    // remove scrolling CADisplayLink because scrolling operation was finshed
    scrollDisplayLink?.invalidate()
    scrollDisplayLink = nil
    scrollRate = 0.0
  }
  
}