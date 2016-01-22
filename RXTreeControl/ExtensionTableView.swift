//
//  ExtensionTableView.swift
//  RXTreeControl
//
//  Created by Arcilite on 13.01.16.
//  Copyright © 2016 Arcilite. All rights reserved.
//

import Foundation
import UIKit

extension UITableView{
    //var k:Int!
    
    
    public func selectionViewForTableView(tableView: UITableView,destinitionCell cell:UITableViewCell,toIndexRowPath destinationRowIndexPath: NSIndexPath) -> UIView{
        let view = UIView()
        view.backgroundColor = UIColor.blueColor()
        return view
    }
    
    func tableView(tableView: UITableView, moveSubRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexSubRowPath destinationSubRowIndexPath: NSIndexPath){
        
    }
    
    func tableView(tableView: UITableView, moveSubRowAtIndexPath sourceIndexPath: NSIndexPath, toRootRowPath destinationSubRowIndexPath: NSIndexPath){
        
    }
}