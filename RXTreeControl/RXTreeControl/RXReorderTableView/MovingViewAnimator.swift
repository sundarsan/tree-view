//
//  MovingViewAnimator.swift
//  RXTreeControl
//
//  Created by Arcilite on 20.02.16.
//  Copyright © 2016 Arcilite. All rights reserved.
//

import UIKit

class MovingViewAnimator: NSObject {
  
  private var tableView: RXReorderTableView
  
  init(tableView:RXReorderTableView){
    self.tableView = tableView
  }
  
  func beginAnimationCellImage(viewImage: UIImage, indexPath: NSIndexPath, location: CGPoint, view:((view: UIImageView) -> Void)) {
    
    let movedView = UIImageView(image:viewImage)
    tableView.addSubview(movedView)
    let rect =  tableView.rectForRowAtIndexPath(indexPath)
    movedView.frame = CGRectOffset(movedView.bounds, rect.origin.x, rect.origin.y)
    
    UIView.beginAnimations("ReorderMovedView", context: nil)
    view(view: movedView)
    UIView.commitAnimations()
    movedView.addShadowOnView()
  }
  
  func endMoveAnimationMovedView(movedView: UIView, currentLocationIndexPath: NSIndexPath, animation: (() -> Void), complete:(() -> Void) ) {
    // Animate the drag view to the newly hovered cell.
    tableView.selectionView?.removeFromSuperview()
    tableView.selectionView = nil
    
    
    UIView.animateWithDuration(0.3, animations: { [unowned self] in
      
      UIView.beginAnimations("Reorder-HideMovedView", context: nil)
      animation()
      UIView.commitAnimations()
      let rect =  self.tableView.rectForRowAtIndexPath(currentLocationIndexPath)
      movedView.transform = CGAffineTransformIdentity
      movedView.frame = CGRectOffset(movedView.bounds, rect.origin.x, rect.origin.y)
      
      }, completion: {  (finished: Bool) in
        movedView.removeFromSuperview()
        // Reload the rows that were affected just to be safe.
        if let visibleRows =  self.tableView.indexPathsForVisibleRows {
          self.tableView.reloadRowsAtIndexPaths(visibleRows, withRowAnimation: .None)
        }
        
        complete()
    })
  }
  
}
