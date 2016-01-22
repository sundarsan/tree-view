//
//  RXTableViewController.swift
//  RXTreeControl
//
//  Created by Arcilite on 22.01.16.
//  Copyright © 2016 Arcilite. All rights reserved.
//

import UIKit

public class  RXReorderTableViewController: UITableViewController, RXReorderTableViewDelegate {
    
    public func selectionViewForTableView(tableView: UITableView,destinitionCell cell:UITableViewCell,toIndexRowPath destinationRowIndexPath: NSIndexPath) -> UIView{
        let view = UIView()
        view.backgroundColor = UIColor.blueColor()
        return view
    }
    
    
    public var longPressreorderTableView: RXReorderTableView! { return tableView as! RXReorderTableView }
    
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        initialize()
    }
    
    public override init(style: UITableViewStyle) {
        super.init(style: style)
        initialize()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    private func initialize() {
        tableView = RXReorderTableView()
        tableView.dataSource = self
        tableView.delegate = self
        registerClasses()
        longPressreorderTableView.longPressReorderDelegate = self
    }
    
 
    public func registerClasses() {
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    
    public func tableView(tableView: UITableView, draggingCell cell: UITableViewCell, atIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Empty implementation, just to simplify overriding (and to show up in code completion).
        return cell
    }
    
    
    public func tableView(tableView: UITableView, showDraggingView view: UIView, atIndexPath indexPath: NSIndexPath){
        // Empty implementation, just to simplify overriding (and to show up in code completion).
    }
    
    public func tableView(tableView: UITableView, hideDraggingView view: UIView, atIndexPath indexPath: NSIndexPath) {
        // Empty implementation, just to simplify overriding (and to show up in code completion).
    }
    
}
