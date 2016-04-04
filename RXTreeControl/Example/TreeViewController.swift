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

      let itemTrees: Variable  = Variable(treeController.treeArray as [TreeModelView])

        itemTrees
            .bindTo(tableView.rx_itemsWithCellIdentifier("Cell0")) { (row, element, cell) in
                let tcell = cell as? TableViewCell
                tcell?.titleLabel?.text = "\(element.treeObject.title )"
                let colorRed = CGFloat(251 - element.level*2  ) / CGFloat(255.0)
                let colorGreen = CGFloat(248 - element.level*2) / CGFloat(255.0)
                let colorBlue = CGFloat( 246 - element.level*2) / CGFloat(255.0)
                tcell?.backgroundColor =  UIColor(red: colorRed, green: colorGreen, blue: colorBlue, alpha: CGFloat(1.0)
                )

                tcell?.delegate = self.tableView.longPressReorderDelegate
              
                tcell?.setOpenedMode(element.isTreeOpen)
              
                tcell?.openButton.selected  = element.isTreeOpen
                tcell?.openButton.hidden = element.subobjects.count == 0
                tcell?.setNeedsLayout()
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
            //let indexRows =
            self.treeController.openTreeByIndex(sourceIndex.row)
           // let indexesPaths = NSIndexPath.indexPathsFromSection(0,indexesArray:indexRows)
           // self.tableView.beginUpdates()
            //self.tableView.insertRowsAtIndexPaths(indexesPaths, withRowAnimation: .Fade)
           // self.tableView.endUpdates()
            itemTrees.value = self.treeController.treeArray
            
            
        }.addDisposableTo(disposeBag)
        
        tableView.rx_itemSubRowClosed.subscribeNext { (sourceIndex: NSIndexPath) -> Void in
            print("Closed")
           
        }.addDisposableTo(disposeBag)
        
        tableView.rx_itemRowMoved.subscribeNext { (sourceIndex: NSIndexPath, destinationIndex: NSIndexPath) -> Void in
            
        }.addDisposableTo(disposeBag)
        
        tableView.rx_itemSubRowMovedToRoot.subscribeNext { (sourceIndex: NSIndexPath, destinationIndex: NSIndexPath) -> Void in
            
        }.addDisposableTo(disposeBag)
        
        
        tableView.rx_itemSubRowMoved.subscribeNext { (sourceIndex: NSIndexPath, destinationIndex: NSIndexPath) -> Void in
            
            }.addDisposableTo(disposeBag)
        
        
        tableView.rx_itemSubRowMove.subscribeNext { (sourceIndex: NSIndexPath, destinationIndex: NSIndexPath) -> Void in
            
        }.addDisposableTo(disposeBag)
        
        
        tableView.rx_itemMoveToRoot.subscribeNext { (sourceIndex: NSIndexPath, destinationIndex: NSIndexPath) -> Void in
            
        }.addDisposableTo(disposeBag)
        
        
        tableView.rx_changeOpenStateByCell(TreeModelView).subscribeNext { (cell, indexPath, value) -> Void in
            let indexRows =  self.treeController.openOrCloseSubasset(value)
            let indexesPaths = NSIndexPath.indexPathsFromSection(0, indexesArray:indexRows)
 
            if value.isTreeOpen {
                itemTrees.value = self.treeController.treeArray
                self.tableView.reloadRowsAtIndexPaths(indexesPaths, withRowAnimation: .Automatic)
            }else {
                self.tableView.reloadRowsAtIndexPaths(indexesPaths, withRowAnimation: .Automatic)
                itemTrees.value = self.treeController.treeArray
            }
           
           

        }.addDisposableTo(disposeBag)
        
        tableView.rx_dataSource.viewBlock = { (cell: UITableViewCell, destinationIndex: NSIndexPath) -> UIView in
            let view = UIView(frame: CGRectMake(0, cell.frame.height - 2, self.tableView.frame.width,2))
            view.backgroundColor = rgb(234,colorGreen: 133,colorBlue: 49) //234 133 49
            return view
            
            
        }
        
        tableView.rx_viewWillDisplayCell
          .subscribeNext { (cell: UITableViewCell, destinationIndex: NSIndexPath) -> Void in
           
//            let pulseAnimationCell:CABasicAnimation = CABasicAnimation(keyPath: "opacityCell");
//            pulseAnimationCell.duration =  10.0;
//            pulseAnimationCell.repeatDuration = 0.1
//            pulseAnimationCell.fromValue = NSNumber(float: 1.0);
//            pulseAnimationCell.toValue = NSNumber(float: 0.0);
//            pulseAnimationCell.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut);
//            pulseAnimationCell.autoreverses = true;
//            pulseAnimationCell.repeatCount = 30;
            
            
            //cell.layer.addAnimation(pulseAnimationCell, forKey: "pulseAnimationCell")
        }.addDisposableTo(disposeBag)

        
        
}

    
}
