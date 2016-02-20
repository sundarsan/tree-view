//
//  RXReorderTableViewExtension.swift
//  RXTreeControl
//
//  Created by Arcilite on 19.02.16.
//  Copyright © 2016 Arcilite. All rights reserved.
//

import Foundation
import UIKit

extension RXReorderTableView{
  
  func countRows() -> Int {
    let sections = numberOfSections
    var rows = 0
    for i in 0..<sections {
      rows += numberOfRowsInSection(i)
    }
    return rows
  }
  
 
//  
//  internal func longPress(gesture: UILongPressGestureRecognizer) {
//    
//    let location = gesture.locationInView(self)
//    let indexPath = indexPathForRowAtPoint(location)
//    
//    let rows = countRows()
//    
//    let isStartMoving = (gesture.state == UIGestureRecognizerState.Began) && (indexPath == nil)
//    let isMoving = (gesture.state == UIGestureRecognizerState.Ended) && (currentLocationIndexPath == nil)
//    let isEndMoving = (gesture.state == UIGestureRecognizerState.Began) && !canMoveRowAt(indexPath: indexPath!)
//    
//    if (rows == 0) || isStartMoving || isMoving || isEndMoving{
//      cancelGesture()
//      return
//    }
//    
//    // Started.
//    if gesture.state == .Began {
//      self.longPressBegan(indexPath, location: location)
//    } else if gesture.state == .Changed {
//      // Dragging.
//      scrollRate = self.directionRate(location)
//      updateCurrentLocation(gesture)
//      
//    } else if gesture.state == .Ended {
//      //Dropped.
//      self.longPressEnded()
//    }
//    
//  }
//
//  func updateCurrentLocation(gesture: UILongPressGestureRecognizer) {
//    let location = gesture.locationInView(self)
//    if var indexPath = indexPathForRowAtPoint(location) {
//      
//      if let iIndexPath = fromIndexPath,ip = delegate?
//        .tableView?(self, targetIndexPathForMoveFromRowAtIndexPath: iIndexPath, toProposedIndexPath: indexPath) {
//        indexPath = ip
//      }
//      
//      if let clIndexPath = currentLocationIndexPath {
//        let oldHeight = rectForRowAtIndexPath(clIndexPath).size.height
//        let newHeight = rectForRowAtIndexPath(indexPath).size.height
//        
//        if ((indexPath != clIndexPath) &&
//          (gesture.locationInView(cellForRowAtIndexPath(indexPath)).y > (newHeight - oldHeight))) &&
//          canMoveRowAt(indexPath: indexPath) {
//            beginUpdates()
//            selectionView?.removeFromSuperview()
//            selectionView = nil
//            if let cell =
//              cellForRowAtIndexPath(indexPath),
//              selectionView =  self.longPressReorderDatasource?
//                .selectionViewForTableView?(self, destinitionCell: cell, toIndexRowPath: indexPath),
//              movedView = self.movedView {
//                self.selectionView = selectionView
//                
//                if movedView.frame.origin.y <= 0 {
//                  self.clearMovedView()
//                }else if  movedView.frame.origin.y  < 30 {
//                  self.selectionView?.frame.origin.y = 0
//                  cell.addSubview(selectionView)
//                  
//                  self.longPressReorderDelegate?.tableView?(self, movingRowAtIndexPath: clIndexPath, toRootRowPath: indexPath)
//                }else {
//                  
//                  if movedView.frame.origin.x > 20 {
//                    
//                    selectionView.frame.origin.x = 30
//                    movedView.unscaleView()
//                    
//                    reorderingState = .Submenu
//                    CATransaction.begin()
//                    movedView.addPulseAnimationDuration(key:"animateOpacity")
//                   // cell.addPulseAnimationDuration()
//                    CATransaction.setCompletionBlock({ () -> Void in
//                      self.longPressReorderDelegate.tableView?(self, openSubAssetAtIndexPath: indexPath)
//                    })
//                    
//                    CATransaction.flush()
//                  }else {
//                    selectionView.frame.origin.x = 0
//                    movedView.scaleView()
//                    reorderingState = .Flat
//                    longPressReorderDelegate.tableView?(self, closeSubAssetAtIndexPath: indexPath)
//                    
//                    
//                  }
//                  cell.addSubview(selectionView)
//                }
//            }
//            currentLocationIndexPath = indexPath
//            self.reorderRowByState(self.reorderingState , clIndexPath: clIndexPath, indexPath: indexPath)
//            
//            endUpdates()
//        }
//      }
//    }
//  }
//  
//  
//  func longPressBegan(indexPath:NSIndexPath?,location:CGPoint){
//    if let indexPath = indexPath, var cell = cellForRowAtIndexPath (indexPath) {
//      
//      cell.setSelected(false, animated: false)
//      cell.setHighlighted(false, animated: false)
//      
//      // Create the view that will be dragged around the screen.
//      if movedView == nil {
//        
//        if let draggingCell = longPressReorderDelegate?.tableView?(self, movedCell: cell, atIndexPath: indexPath) {
//          cell = draggingCell
//        }
//        
//        beginAnimationCellImage(cell.viewImage(), indexPath:indexPath, location: location, view: {[unowned self] (view) -> Void in
//          self.longPressReorderDelegate?.tableView?(self, showMovedView: view, atIndexPath: indexPath)
//          self.movedView = view
//          
//          })
//        
//      }
//      
//      currentLocationIndexPath = indexPath
//      fromIndexPath = indexPath
//      
//      // Enable scrolling for cell.
//      scrollDisplayLink = CADisplayLink(target: self, selector: "scrollTableWithCell:")
//      scrollDisplayLink?.addToRunLoop(NSRunLoop.mainRunLoop(), forMode: NSDefaultRunLoopMode)
//    }
//    
//  }
//  
//  func longPressEnded(){
//    self.finishScrolingOperation()
//    
//    if let draggingView = self.movedView, currentLocationIndexPath = self.currentLocationIndexPath {
//      self.endMoveAnimationMovedView(draggingView, currentLocationIndexPath: currentLocationIndexPath, animation: { [unowned self] () in
//        
//        self.longPressReorderDelegate?.tableView?(self, hideMovedView: draggingView, toIndexPath: currentLocationIndexPath)
//        }, complete: {[unowned self]() in
//          self.clearMovedView()
//          self.currentLocationIndexPath = nil
//          
//          
//          if self.fromIndexPath != currentLocationIndexPath {
//            switch(self.reorderingState) {
//            case .Flat:
//              self.longPressReorderDelegate?.tableView!(self, movedRowAtIndexPath: self.fromIndexPath!, toIndexRowPath: currentLocationIndexPath)
//              break
//              
//            case .Submenu:
//              self.longPressReorderDelegate?.tableView?(self, movingSubRowAtIndexPath: self.fromIndexPath!, toIndexSubRowPath: currentLocationIndexPath)
//            case .Root:
//              self.longPressReorderDelegate?.tableView!(self, movedRowAtIndexPath: self.fromIndexPath!, toRootRowPath: currentLocationIndexPath)
//              break
//            }
//          }
//          
//          
//        })
//    }
//    
//  }
//  
//  func reorderRowByState(type:ReorderingState,clIndexPath: NSIndexPath,  indexPath:NSIndexPath){
//    if type == .Flat {
//      dataSource?.tableView?(self, moveRowAtIndexPath: clIndexPath, toIndexPath: indexPath)
//    }else if (type == .Submenu) {
//      longPressReorderDelegate.tableView?(self, movingSubRowAtIndexPath: clIndexPath, toIndexSubRowPath: indexPath)
//    }
//  }
//
  
}
