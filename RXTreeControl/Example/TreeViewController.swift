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




class TreeViewController: BaseViewController,RXReorderTableViewDelegate,RXReorderTableViewDatasource {
   
  
    @IBOutlet weak var tableView: RXReorderTableView!
   
    let treeController = TreeController(treeModel: TreeModel())
    
    //var itemTrees:Variable <[TreeModelView]>!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        var itemTrees:Variable  = Variable(treeController.treeArray as [TreeModelView])
        
        
        
        itemTrees
            .bindTo(tableView.rx_itemsWithCellIdentifier("Cell0")) { (row, element, cell) in
                let tcell = cell as! TableViewCell
                tcell.titleLabel?.text = "\(element.treeObject.title ) @ Level \(element.level)"
                let colorRed = CGFloat(200 - element.level*10  ) / CGFloat(255.0)
                let colorGreen = CGFloat(element.level*10 + 20) / CGFloat(255.0)
                let colorBlue = CGFloat(100 - element.level*10 + 20) / CGFloat(255.0)
             //   tcell.delegate = self
                tcell.delegate = self.tableView.longPressReorderDelegate
                tcell.backgroundColor =  UIColor(red: colorRed,
                    green: colorGreen,
                    blue: colorBlue,
                    alpha: CGFloat(1.0)
                )
                tcell.openButton.selected  = element.isTreeOpen
                tcell.openButton.hidden = element.subobjects.count == 0
                tcell.setNeedsLayout()
            }
            .addDisposableTo(disposeBag)
        
       
   
//        let dataSource = RxTableViewSectionedReloadDataSource< SectionModel<String, TreeModelView>>()
//      
//        dataSource.cellFactory = { (tv, ip, element: TreeModelView) in
//            let identifier = "Cell" + "\(element.level)"
//            let cell = tv.dequeueReusableCellWithIdentifier(identifier)!
//            let tcell = cell as! TableViewCell
//            tcell.titleLabel?.text = "\(element.treeObject.title ) @ Level \(element.level)"
//            let colorRed = CGFloat(200 - element.level*10  ) / CGFloat(255.0)
//            let colorGreen = CGFloat(element.level*10 + 20) / CGFloat(255.0)
//            let colorBlue = CGFloat(100 - element.level*10 + 20) / CGFloat(255.0)
//            tcell.titleLabel?.frame.origin.x = CGFloat( 10 + 10 * element.level)
//            tcell.backgroundColor =  UIColor(red: colorRed,
//                green: colorGreen,
//                blue: colorBlue,
//                alpha: CGFloat(1.0)
//            )
//            tcell.setNeedsLayout()
//            return cell
//        }
        
//        itemTrees
//            .map { [ SectionModel(model: "ok", items: $0) ] }
//            .bindTo(tableView.rx_itemsWithDataSource(dataSource))
//            .addDisposableTo(disposeBag)
      //  itemTreesSections
      //      .bindTo(itemsDatasource)
      //      .addDisposableTo(disposeBag)
        
        
        tableView
            .rx_modelSelected(TreeModelView)
            .subscribeNext {value in
               
            }
            .addDisposableTo(disposeBag)
        
        tableView.rx_itemMoved.subscribeNext { (sourceIndex: NSIndexPath, destinationIndex: NSIndexPath) -> Void in
            
        }.addDisposableTo(disposeBag)
        
        tableView.rx_itemSubRowOpen.subscribeNext { (sourceIndex: NSIndexPath) -> Void in
            print("Opeben")
            self.tableView.reloadData()
            let indexRows = self.treeController.openTreeByIndex(sourceIndex.row)
            let indexesPaths = NSIndexPath.indexPathsFromSection(0,indexesArray:indexRows)
            self.tableView.beginUpdates()
            self.tableView.insertRowsAtIndexPaths(indexesPaths, withRowAnimation: .Automatic)
            self.tableView.endUpdates()
            
            
           // self.tableView.reloadData()
            
        }.addDisposableTo(disposeBag)
        
        tableView.rx_itemSubRowClosed.subscribeNext { (sourceIndex: NSIndexPath) -> Void in
            print("Closed")
           
        }.addDisposableTo(disposeBag)
        
        tableView.rx_itemRowMoved.subscribeNext { (sourceIndex: NSIndexPath, destinationIndex: NSIndexPath) -> Void in
             // self.treeController.moveInTreeFromAssetIndex(sourceIndex.row,toIndex:destinationIndex.row)
        }.addDisposableTo(disposeBag)
        
        tableView.rx_itemSubRowMovedToRoot.subscribeNext { (sourceIndex: NSIndexPath, destinationIndex: NSIndexPath) -> Void in
            
        }.addDisposableTo(disposeBag)
        
        
        tableView.rx_itemSubRowMoved.subscribeNext { (sourceIndex: NSIndexPath, destinationIndex: NSIndexPath) -> Void in
            
            }.addDisposableTo(disposeBag)
        
        
        tableView.rx_itemSubRowMove.subscribeNext { (sourceIndex: NSIndexPath, destinationIndex: NSIndexPath) -> Void in
            
        }.addDisposableTo(disposeBag)
        
        
        tableView.rx_itemMoveToRoot.subscribeNext { (sourceIndex: NSIndexPath, destinationIndex: NSIndexPath) -> Void in
            
        }.addDisposableTo(disposeBag)
        
        
        tableView.rx_changeOpenStateByCell(TreeModelView).subscribeNext { (cell,indexPath,value) -> Void in
            self.tableView.reloadData()
            let indexRows =  self.treeController.openOrCloseSubasset(value)
            let indexesPaths = NSIndexPath.indexPathsFromSection(0,indexesArray:indexRows)
            print(indexesPaths)
            // self.tableView.reloadData()
            itemTrees  = Variable(self.treeController.treeArray as [TreeModelView])
            self.tableView.reloadData()
            print(self.tableView.dataSource?.tableView( self.tableView, numberOfRowsInSection: 0))
            //itemTrees.value = self.treeController.treeArray
            
            if value.isTreeOpen{
               self.tableView.insertRowsAtIndexPaths(indexesPaths, withRowAnimation: .Automatic)
                
            }else{
                //self.tableView.insertRowsAtIndexPaths([], withRowAnimation: .Automatic)
              print(self.tableView.dataSource?.tableView( self.tableView, numberOfRowsInSection: 0))
              self.tableView.deleteRowsAtIndexPaths(indexesPaths, withRowAnimation: .Automatic)
                
                // self.tableView.insertRowsAtIndexPaths(indexesPaths, withRowAnimation: .Automatic)
            }
            itemTrees.value = self.treeController.treeArray as [TreeModelView]
            
        }.addDisposableTo(disposeBag)
        
        tableView.rx_dataSource.viewBlock =  { (cell:UITableViewCell, destinationIndex: NSIndexPath) -> UIView in
            let view = UIView(frame: CGRectMake(0,cell.frame.height - 2 ,self.tableView.frame.width,2))
            view.backgroundColor = UIColor.blueColor();
            return view
            
            
        }

        
        
}

    
}
