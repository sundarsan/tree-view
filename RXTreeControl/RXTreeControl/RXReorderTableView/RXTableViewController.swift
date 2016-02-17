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

public class  RXReorderTableViewController: UITableViewController, RXReorderTableViewDelegate {
    
    public func selectionViewForTableView(tableView: UITableView, destinitionCell cell: UITableViewCell, toIndexRowPath destinationRowIndexPath: NSIndexPath) -> UIView {
        let view = UIView()
        view.backgroundColor = UIColor.blueColor()
        return view
    }
    
    
    public var longPressreorderTableView: RXReorderTableView! { return tableView as? RXReorderTableView }
    
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
    
    
    public func tableView(tableView: UITableView, showDraggingView view: UIView, atIndexPath indexPath: NSIndexPath) {
        // Empty implementation, just to simplify overriding (and to show up in code completion).
    }
    
    public func tableView(tableView: UITableView, hideDraggingView view: UIView, atIndexPath indexPath: NSIndexPath) {
        // Empty implementation, just to simplify overriding (and to show up in code completion).
    }
    //    func tableView(tableView: UITableView, moveSubRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexSubRowPath destinationSubRowIndexPath: NSIndexPath){
    //
    //    }
    //
    //    func tableView(tableView: UITableView, moveSubRowAtIndexPath sourceIndexPath: NSIndexPath, toRootRowPath destinationSubRowIndexPath: NSIndexPath){
    //
    //    }
    //
    //    func tableView(tableView: UITableView,openSubAssetAtIndexPath sourceIndexPath: NSIndexPath){
    //
    //        let indexRows = treeController.openTreeByIndex(sourceIndexPath.row)
    //        let indexesPaths = NSIndexPath.indexPathsFromSection(0,indexesArray:indexRows)
    //        self.tableView.insertRowsAtIndexPaths(indexesPaths, withRowAnimation: .Automatic)
    //        self.tableView.reloadData()
    //        self.itemTrees.value = self.treeController.treeArray as [TreeModelView]
    //
    //
    //    }
    
    //    func tableView(tableView: UITableView,closeSubAssetAtIndexPath sourceIndexPath: NSIndexPath){
    //
    //    }
    //
    //    func tableView(tableView: UITableView, movedSubRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexSubRowPath destinationSubRowIndexPath: NSIndexPath){
    //
    //    }
    //
    //    func tableView(tableView: UITableView, movedRowAtIndexPath sourceIndexPath: NSIndexPath, toRootRowPath destinationSubRowIndexPath: NSIndexPath){
    //
    //    }
    //
    //    func tableView(tableView: UITableView,movedRowAtIndexPath sourceIndexPath: NSIndexPath,toIndexRowPath destinationRowIndexPath: NSIndexPath) {
    //         self.treeController.moveInTreeFromAssetIndex(sourceIndexPath.row,toIndex:destinationRowIndexPath.row)
    //    
    //     }

}
