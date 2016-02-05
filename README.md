#RXTreeControl

# RXTreeControl
[![CocoaPods](https://img.shields.io/cocoapods/p/RXTreeControl.svg)](https://cocoapods.org/pods/RXTreeControl)
[![CocoaPods](https://img.shields.io/cocoapods/v/RXTreeControl.svg)](http://cocoapods.org/pods/RXTreeControl)
[![Twitter](https://img.shields.io/badge/Twitter-@Ramotion-blue.svg?style=flat)](http://twitter.com/Ramotion)
[![Travis](https://img.shields.io/travis/Ramotion/tree-view.svg)](https://travis-ci.org/Ramotion/tree-view)


## Requirements

- iOS 8.0+
- Xcode 7.2

## Installation

Just add the RXTreeContol folder to your project.

or use [CocoaPods](https://cocoapods.org) with Podfile:
``` ruby
pod 'RXTreeControl', '~> 0.0.2'
```
    

## Solution
![Solution](/Tutorial-resources/Solution.png)
## Usage
For using this library you need   install 'RxSwift',  'RxCocoa', 'RxBlocking', 

``` swift
 let itemTrees:Variable  = Variable(treeController.treeArray as [TreeModelView])
        
        
        itemTrees
            .bindTo(tableView.rx_itemsWithCellIdentifier("Cell0")) { (row, element, cell) in
                let tcell = cell as! TableViewCell
                tcell.titleLabel?.text = "\(element.treeObject.title ) @ Level \(element.level)"
                let colorRed = CGFloat(200 - element.level*10  ) / CGFloat(255.0)
                let colorGreen = CGFloat(element.level*10 + 20) / CGFloat(255.0)
                let colorBlue = CGFloat(100 - element.level*10 + 20) / CGFloat(255.0)
              
                tcell.backgroundColor =  UIColor(red: colorRed,
                    green: colorGreen,
                    blue: colorBlue,
                    alpha: CGFloat(1.0)
                )
                tcell.setNeedsLayout()
            }
            .addDisposableTo(disposeBag)
```         
       

``` swift
     tableView
            .rx_modelSelected(TreeModelView)
            .subscribeNext {value in
                self.treeController.openOrCloseSubasset(value)
                itemTrees.value = self.treeController.treeArray as [TreeModelView]
                self.tableView.reloadData()
               }
            .addDisposableTo(disposeBag)
``` 


``` swift
    tableView.rx_itemMoved.subscribeNext { (sourceIndex: NSIndexPath, destinationIndex: NSIndexPath) -> Void in
	
	
         }.addDisposableTo(disposeBag)
``` 
     
``` swift
    tableView.rx_itemSubRowOpen.subscribeNext { (sourceIndex: NSIndexPath) -> Void in  
    
        }.addDisposableTo(disposeBag)
```     

```swift 
	tableView.rx_itemSubRowClosed
	.subscribeNext { (sourceIndex: NSIndexPath) -> Void in

}.addDisposableTo(disposeBag)
```
        
``` swift 
	tableView.rx_itemRowMoved
.subscribeNext { (sourceIndex: NSIndexPath, destinationIndex: NSIndexPath) -> Void in

                      }.addDisposableTo(disposeBag)
```
 
``` swift 
tableView.rx_itemSubRowMovedToRoot
.subscribeNext { (sourceIndex: NSIndexPath, destinationIndex: NSIndexPath) -> Void in

}.addDisposableTo(disposeBag)

```
        
 ``` swift
  tableView.rx_itemSubRowMoved
.subscribeNext { (sourceIndex: NSIndexPath, destinationIndex: NSIndexPath) -> Void in
 
            }.addDisposableTo(disposeBag)
```
        
        
``` swift 
	tableView.rx_itemSubRowMove
	.subscribeNext { (sourceIndex: NSIndexPath, destinationIndex: NSIndexPath) -> Void in
 
    }.addDisposableTo(disposeBag)
```
 
 
``` swift 
		tableView.rx_itemMoveToRoot
		.subscribeNext { (sourceIndex: NSIndexPath, destinationIndex: NSIndexPath) -> Void in  

       }.addDisposableTo(disposeBag)
```
        
``` swift 
		tableView.rx_dataSource.viewBlock =  { (cell:UITableViewCell, destinationIndex: NSIndexPath) -> UIView in
            let view = UIView(frame: CGRectMake(0,cell.frame.height - 2 ,self.tableView.frame.width,2))
            view.backgroundColor = UIColor.blueColor();
            return view           
}
```


## Licence

Adaptive tab bar is released under the MIT license.
See [LICENSE](./LICENSE) for details.


## About
The project maintained by [app development agency](https://ramotion.com?utm_source=gthb&utm_medium=special&utm_campaign=foolding-cell) [Ramotion Inc.](https://ramotion.com?utm_source=gthb&utm_medium=special&utm_campaign=foolding-cell)
See our other [open-source projects](https://github.com/ramotion) or [hire](https://ramotion.com?utm_source=gthb&utm_medium=special&utm_campaign=foolding-cell) us to design, develop, and grow your product.

[![Twitter URL](https://img.shields.io/twitter/url/http/shields.io.svg?style=social)](https://twitter.com/intent/tweet?text=https://github.com/ramotion/foolding-cell)
[![Twitter Follow](https://img.shields.io/twitter/follow/ramotion.svg?style=social)](https://twitter.com/ramotion)
