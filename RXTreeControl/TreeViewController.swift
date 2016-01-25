// Copyright (c) 22.01.16. Ramotion Inc. (http://ramotion.com)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.


import UIKit
import RxSwift
import RxCocoa

class TreeViewController: BaseViewController,RXReorderTableViewDelegate {
   
    
    @IBOutlet weak var tableView: RXReorderTableView!
    let treeController =                                                                                          TreeController(treeModel: TreeModel())
       var itemTrees:Variable <[TreeModelView]>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.longPressReorderDelegate = self
        //tableView.allowsSelectionDuringEditing = true
     // let treeController =                                                                                          TreeController(treeModel: TreeModel())
        
        let tree = Tree()
        tree.title = "ee"
        
        let treeModelView = TreeModelView()
        treeModelView.treeObject = tree
        
        itemTrees = Variable(treeController.treeArray as [TreeModelView])
        

        
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
                self.treeController.openOrCloseSubasset(value)
                self.itemTrees.value = self.treeController.treeArray as [TreeModelView]
                self.tableView.reloadData()
               // DefaultWireframe.presentAlert("Tapped `\(value)`")
            }
            .addDisposableTo(disposeBag)
        
        tableView.rx_itemMoved.subscribeNext { (sourceIndex: NSIndexPath, destinationIndex: NSIndexPath) -> Void in
          //  self.treeController.moveInTreeFromAssetIndex(sourceIndex.row,toIndex:destinationIndex.row)
            
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
        treeController.openTreeByIndex(sourceIndexPath.row)
        self.tableView.insertRowsAtIndexPaths([], withRowAnimation: .Left)
         self.tableView.reloadData()
        self.itemTrees.value = self.treeController.treeArray as [TreeModelView]
       
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
