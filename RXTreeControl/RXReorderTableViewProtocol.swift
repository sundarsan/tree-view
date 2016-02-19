//
//  RXReorderTableViewProtocol.swift
//  RXTreeControl
//
//  Created by Arcilite on 19.02.16.
//  Copyright © 2016 Arcilite. All rights reserved.
//

import Foundation
import UIKit

@objc
public protocol RXReorderTableViewCellDelegate: NSObjectProtocol {
  optional func changeOpenStateByCell(cell: UITableViewCell)
}

@objc
public protocol RXReorderTableViewDelegate: NSObjectProtocol,RXReorderTableViewCellDelegate {
  
  
  optional func tableView(tableView: UITableView, movedCell cell: UITableViewCell, atIndexPath indexPath: NSIndexPath) -> UITableViewCell
  
  
  optional func tableView(tableView: UITableView, showMovedView view: UIView, atIndexPath indexPath: NSIndexPath)
  
  optional func tableView(tableView: UITableView, hideMovedView view: UIView, toIndexPath indexPath: NSIndexPath)
  
  optional func tableView(tableView: UITableView, movingSubRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexSubRowPath destinationSubRowIndexPath: NSIndexPath)
  
  optional func tableView(tableView: UITableView, movingRowAtIndexPath sourceIndexPath: NSIndexPath, toRootRowPath destinationSubRowIndexPath: NSIndexPath)
  
  optional func tableView(tableView: UITableView, movedSubRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexSubRowPath destinationSubRowIndexPath: NSIndexPath)
  
  optional func tableView(tableView: UITableView, movedRowAtIndexPath sourceIndexPath: NSIndexPath, toRootRowPath destinationSubRowIndexPath: NSIndexPath)
  
  optional func tableView(tableView: UITableView, movedRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexRowPath destinationRowIndexPath: NSIndexPath)
  
  optional func tableView(tableView: UITableView, openSubAssetAtIndexPath sourceIndexPath: NSIndexPath)
  
  optional func tableView(tableView: UITableView, closeSubAssetAtIndexPath sourceIndexPath: NSIndexPath)
  
}


@objc
public protocol RXReorderTableViewDatasource: NSObjectProtocol {
  
  
  optional func selectionViewForTableView(tableView: UITableView, destinitionCell cell: UITableViewCell, toIndexRowPath destinationRowIndexPath: NSIndexPath) -> UIView
  
  
}

