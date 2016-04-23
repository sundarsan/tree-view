//
//  ReorderGestureHandler.swift
//  RXTreeControl
//
//  Created by Arcilite on 18.02.16.
//  Copyright © 2016 Arcilite. All rights reserved.
//

import UIKit

public class ReorderGestureHandler: NSObject {
  
  private var tableView : RXReorderTableView!
  private var scrollController:RXScrollController!
  private var movingViewAnimator:MovingViewAnimator!
  
  public init(tableView:RXReorderTableView) {
      self.tableView = tableView
      self.scrollController = RXScrollController(tableView: tableView)
      self.movingViewAnimator = MovingViewAnimator(tableView: tableView)
  }

  internal func longPress(gesture: UILongPressGestureRecognizer) {
    
    let location = gesture.locationInView(tableView)
    let indexPath = tableView.indexPathForRowAtPoint(location)
    let rows = tableView.countRows()
    
    let isStartMoving = gesture.state == UIGestureRecognizerState.Began && indexPath == nil
    let isMoving = gesture.state == UIGestureRecognizerState.Ended && tableView.currentLocationIndexPath == nil
    let isEndMoving = gesture.state == UIGestureRecognizerState.Began && !tableView.canMoveRowAt(indexPath: indexPath!)
    let isTouch =  isStartMoving || isMoving || isEndMoving
    
    if (rows == 0) || isTouch{
      tableView.cancelGesture()
      return
    }
    
    switch(gesture.state){
    case .Began:
      self.longPressBegan(indexPath, location: location)
    case .Changed:
      scrollController.scrollRate = scrollController.directionRate(location)
      updateCurrentLocation(gesture)
    case .Ended:
      self.longPressEnded()
    default:
      break;
    }
  }
  
  func updateCurrentLocation(gesture: UILongPressGestureRecognizer) {
    let location = gesture.locationInView(tableView)
    if var indexPath = tableView.indexPathForRowAtPoint(location) {
      
      if let iIndexPath = tableView.fromIndexPath,ip = tableView.delegate?
        .tableView?(tableView, targetIndexPathForMoveFromRowAtIndexPath: iIndexPath, toProposedIndexPath: indexPath) {
          indexPath = ip
      }
      if let clIndexPath = tableView.currentLocationIndexPath {
        let oldHeight = tableView.rectForRowAtIndexPath(clIndexPath).size.height
        let newHeight = tableView.rectForRowAtIndexPath(indexPath).size.height
        let isCurentIndexPath = indexPath != clIndexPath
        let isChnageCell = gesture.locationInView(tableView.cellForRowAtIndexPath(indexPath)).y > (newHeight - oldHeight)
        if isCurentIndexPath && isChnageCell && tableView.canMoveRowAt(indexPath: indexPath) {
            tableView.beginUpdates()
            tableView.selectionView?.removeFromSuperview()
            tableView.selectionView = nil
            if let cell =
              tableView.cellForRowAtIndexPath(indexPath),
              selectionView =  tableView.longPressReorderDatasource?
                .selectionViewForTableView?(tableView, destinitionCell: cell, toIndexRowPath: indexPath),
              movedView = tableView.movedView {
                self.selectionHiglighting(movedView, selectionView: selectionView, indexPath: indexPath, clIndexPath: clIndexPath, cell: cell)
          
              }
            tableView.currentLocationIndexPath = indexPath
            self.reorderRowByState(tableView.reorderingState , clIndexPath: clIndexPath, indexPath: indexPath)
            tableView.endUpdates()
        }
      }
    }
  }
  
  func selectionHiglighting(movedView:UIView,selectionView:UIView,indexPath:NSIndexPath,clIndexPath:NSIndexPath,cell:UITableViewCell){
    tableView.selectionView = selectionView
    
    if movedView.frame.origin.y <= 0 {
      tableView.clearMovedView()
    }else if  movedView.frame.origin.y  < 30 {
      tableView.selectionView?.frame.origin.y = 0
      cell.addSubview(selectionView)
      tableView.reorderingState = .Root
      tableView.longPressReorderDelegate?.tableView?(tableView, movingRowAtIndexPath: clIndexPath, toRootRowPath: indexPath)
    }else {
      if movedView.frame.origin.x > 20 {
        self.movingInSubusset(movedView, selectionView: selectionView, indexPath: indexPath)
        
      }else {
        self.movingToAsset(movedView,selectionView: selectionView, indexPath:  indexPath)
      }
      cell.addSubview(selectionView)
    }

  }
  
//  func movingToRootAsset(movedView:UIView,selectionView:UIView,indexPath:NSIndexPath,fromPath:NSIndexPath,cell:UITableViewCell){
//    tableView.selectionView?.frame.origin.y = 0
//    cell.addSubview(selectionView)
//    tableView.reorderingState = .Root
//    tableView.longPressReorderDelegate?.tableView?(tableView, movingRowAtIndexPath: fromPath, toRootRowPath: indexPath)
//  }
  
  func movingToAsset(movedView:UIView,selectionView:UIView,indexPath:NSIndexPath){
    selectionView.frame.origin.x = 0
    movedView.scaleView()
    tableView.reorderingState = .Flat
    tableView.longPressReorderDelegate.tableView?(tableView, closeSubAssetAtIndexPath: indexPath)
  }
  
  func  movingInSubusset(movedView:UIView,selectionView:UIView,indexPath:NSIndexPath){
    selectionView.frame.origin.x = 30
    movedView.unscaleView()
    tableView.reorderingState = .Submenu
    CATransaction.begin()
    //movedView.addPulseAnimationDuration(key:"animateOpacity")
    // cell.addPulseAnimationDuration()
    CATransaction.setCompletionBlock({ () -> Void in
      self.tableView.longPressReorderDelegate.tableView?(self.tableView, openSubAssetAtIndexPath: indexPath)
    })
    CATransaction.flush()
  }
  
  func longPressBegan(indexPath:NSIndexPath?,location:CGPoint){
    if let indexPath = indexPath, var cell = tableView.cellForRowAtIndexPath (indexPath) {
      cell.setSelected(false, animated: false)
      cell.setHighlighted(false, animated: false)
     
      if let draggingCell = tableView.longPressReorderDelegate?.tableView?(self.tableView, movedCell: cell, atIndexPath: indexPath) {
        cell = draggingCell
      }
      // Create the view that will be dragged around the screen.
     if tableView.movedView == nil {
      movingViewAnimator.beginAnimationCellImage(cell.viewImage(), indexPath:indexPath, location: location, view: {[unowned self] (view) -> Void in
        self.tableView.longPressReorderDelegate?.tableView?(self.tableView, showMovedView: view, atIndexPath: indexPath)
        self.tableView.movedView = view
        })
      }
      tableView.currentLocationIndexPath = indexPath
      tableView.fromIndexPath = indexPath
      self.startScrolingForCell()
    }
    
  }
  func startScrolingForCell (){
    // Enable scrolling for cell.
    scrollController.scrollDisplayLink = CADisplayLink(target: scrollController, selector: Selector("scrollTableWithCell:"))
    scrollController.scrollDisplayLink?.addToRunLoop(NSRunLoop.mainRunLoop(), forMode: NSDefaultRunLoopMode)
  }
  
  func longPressEnded(){
    scrollController.finishScrolingOperation()
    if let draggingView = tableView.movedView, currentLocationIndexPath = tableView.currentLocationIndexPath {
      movingViewAnimator.endMoveAnimationMovedView(draggingView, currentLocationIndexPath: currentLocationIndexPath, animation: { [unowned self] () in
        self.tableView.longPressReorderDelegate?.tableView?(self.tableView, hideMovedView: draggingView, toIndexPath: currentLocationIndexPath)
        }, complete: {[unowned self]() in
          self.tableView.clearMovedView()
          self.tableView.currentLocationIndexPath = nil
          self.didFinishMovedViewAnimation(currentLocationIndexPath)
          
        })
    }
    
  }
  
  func didFinishMovedViewAnimation(currentLocationIndexPath:NSIndexPath){
    if self.tableView.fromIndexPath != currentLocationIndexPath {
      switch(self.tableView.reorderingState) {
      case .Flat:
        self.tableView.longPressReorderDelegate?.tableView!(self.tableView, movedRowAtIndexPath: self.tableView.fromIndexPath!, toIndexRowPath: currentLocationIndexPath)
        break
      case .Submenu:
        self.tableView.longPressReorderDelegate?.tableView?(self.tableView, movingSubRowAtIndexPath: self.tableView.fromIndexPath!, toIndexSubRowPath: currentLocationIndexPath)
      case .Root:
        self.tableView.longPressReorderDelegate?.tableView!(self.tableView, movedRowAtIndexPath: self.tableView.fromIndexPath!, toRootRowPath: currentLocationIndexPath)
        break
      }
    }
  }
  
  func reorderRowByState(type:ReorderingState,clIndexPath: NSIndexPath,  indexPath:NSIndexPath){
    if type == .Flat {
      tableView.dataSource?.tableView?(tableView, moveRowAtIndexPath: clIndexPath, toIndexPath: indexPath)
    }else if (type == .Submenu) {
      tableView.longPressReorderDelegate.tableView?(tableView, movingSubRowAtIndexPath: clIndexPath, toIndexSubRowPath: indexPath)
    }
  }
}
