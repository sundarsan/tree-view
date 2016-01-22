//
//  TreeViewController.swift
//  RXTreeControl
//
//  Created by Arcilite on 15.12.15.
//  Copyright © 2015 Arcilite. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class TreeViewController: BaseViewController,RXReorderTableViewDelegate {
   
    
    @IBOutlet weak var tableView: RXReorderTableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.longPressReorderDelegate = self
        //tableView.allowsSelectionDuringEditing = true
      let treeController =                                                                                          TreeController(treeModel: TreeModel())
        
        let tree = Tree()
        tree.title = "ee"
        
        let treeModelView = TreeModelView()
        treeModelView.treeObject = tree
        
        let itemTrees = Variable(treeController.treeArray as [TreeModelView])
        

        
        itemTrees
            .bindTo(tableView.rx_itemsWithCellIdentifier("Cell")) { (row, element, cell) in
                let tcell = cell as! TableViewCell
               // tcell.indentationLevel = element.level
                tcell.titleLabel?.text = "\(element.treeObject.title ) @ Level \(element.level)"
                tcell.titleLabel?.frame.origin.x = CGFloat(30 + element.level * 20)
                tcell.setNeedsLayout()
            }
            .addDisposableTo(disposeBag)
        
        
//         let treeItems = Variable(treeController.treeaArray)
//        treeItems
        //tableView.editing = true
        tableView
            .rx_modelSelected(TreeModelView)
            .subscribeNext {value in
                treeController.openOrCloseSubasset(value)
                itemTrees.value = treeController.treeArray as [TreeModelView]
                self.tableView.reloadData()
               // DefaultWireframe.presentAlert("Tapped `\(value)`")
            }
            .addDisposableTo(disposeBag)
        
        tableView.rx_itemMoved.subscribeNext { (sourceIndex: NSIndexPath, destinationIndex: NSIndexPath) -> Void in
            treeController.moveInTreeFromAssetIndex(sourceIndex.row,toIndex:destinationIndex.row)
            
        }.addDisposableTo(disposeBag)
        //tableView.rx_itemMoved(String).r
    }
    
    func selectionViewForTableView(tableView: UITableView,destinitionCell cell:UITableViewCell,toIndexRowPath destinationRowIndexPath: NSIndexPath) -> UIView{
        let view = UIView(frame: CGRectMake(0,cell.frame.height - 2 ,self.tableView.frame.width,2))
        view.backgroundColor = UIColor.blueColor();
        return view
    }
    
    func tableView(tableView: UITableView, moveSubRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexSubRowPath destinationSubRowIndexPath: NSIndexPath){
        
    }
    
    func tableView(tableView: UITableView, moveSubRowAtIndexPath sourceIndexPath: NSIndexPath, toRootRowPath destinationSubRowIndexPath: NSIndexPath){
        
    }
    
    func tableView(tableView: UITableView,openSubAssetAtIndexPath sourceIndexPath: NSIndexPath){
    
    }
    
    func tableView(tableView: UITableView,closeSubAssetAtIndexPath sourceIndexPath: NSIndexPath){
        
    }
    
    func tableView(tableView: UITableView, movedSubRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexSubRowPath destinationSubRowIndexPath: NSIndexPath){
        
    }
    
    func tableView(tableView: UITableView, movedRowAtIndexPath sourceIndexPath: NSIndexPath, toRootRowPath destinationSubRowIndexPath: NSIndexPath){
        
    }
    
    func tableView(tableView: UITableView,movedRowAtIndexPath sourceIndexPath: NSIndexPath,toIndexRowPath destinationRowIndexPath: NSIndexPath) {
    
     }
    
}
