//
//  FoldingCell.swift
//
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


import Foundation
import UIKit
import RxSwift
import RxCocoa

public typealias ItemSelectedViewBlock = (cell: UITableViewCell, destinationIndex: NSIndexPath)->UIView
public typealias ItemSubRowEvent = (NSIndexPath)
public typealias ItemCellOpenedChangeStateEvent = (UITableViewCell,NSIndexPath?,AnyObject)

public typealias ItemWillViewCellBlock = (cell: UITableViewCell, destinationIndex: NSIndexPath)



public class  RxReorderTableViewDataSourceProxy: RxTableViewDataSourceProxy, RXReorderTableViewDatasource {
    
    var viewBlock: ((cell: UITableViewCell, destinationIndex: NSIndexPath) -> UIView)!

    public required init(parentObject: AnyObject) {
       
        super.init(parentObject: parentObject)
        (self.tableView as? RXReorderTableView)?.longPressReorderDatasource = self
       
    }

    public func selectionViewForTableView(tableView: UITableView, destinitionCell cell: UITableViewCell, toIndexRowPath destinationRowIndexPath: NSIndexPath) -> UIView {
       
        return self.viewBlock(cell: cell, destinationIndex: destinationRowIndexPath)
    }
 
    
}

public class RxReorderTableViewDelegateProxy: RxTableViewDelegateProxy,
  RXReorderTableViewDelegate,
  RXReorderTableViewCellDelegate {
    
       //We need a way to read the current delegate
    override public class func currentDelegateFor(object: AnyObject) -> AnyObject? {
        let tableView: RXReorderTableView = (object as? RXReorderTableView)!
        return tableView.longPressReorderDelegate
    }
    
    //We need a way to set the current delegate
    override public class func setCurrentDelegate(delegate: AnyObject?, toObject object: AnyObject) {
        let tableView: RXReorderTableView = (object as? RXReorderTableView)!
        tableView.delegate = (delegate as? UITableViewDelegate)
        tableView.longPressReorderDelegate = delegate as? RXReorderTableViewDelegate
        super.setCurrentDelegate(delegate, toObject: object)
      
    }

}
    
extension RXReorderTableView {
  

    public override func rx_createDataSourceProxy() -> RxReorderTableViewDataSourceProxy {
        return RxReorderTableViewDataSourceProxy(parentObject: self)
    }
    
    public override func rx_createDelegateProxy() -> RxScrollViewDelegateProxy {
        return RxReorderTableViewDelegateProxy(parentObject: self)
    }

    public override  var rx_dataSource: RxReorderTableViewDataSourceProxy {
         return  proxyForObject(RxReorderTableViewDataSourceProxy.self, self)
    }

    public override var rx_delegate: DelegateProxy {
        return proxyForObject(RxReorderTableViewDelegateProxy.self, self)
    }

    
    public var rx_itemSubRowOpen: ControlEvent<ItemSubRowEvent> {
        let sourceSubRowOpen: Observable<ItemSubRowEvent> = rx_delegate.observe(#selector(RXReorderTableViewDelegate.tableView(_:openSubAssetAtIndexPath:)))
            .map { subRowOpenArguments in
                return ((subRowOpenArguments[1] as? NSIndexPath))!
        }
      
        return ControlEvent(events: sourceSubRowOpen)
    }

    public var rx_itemSubRowClosed: ControlEvent<ItemSubRowEvent> {
        let sourceSubRowClosed: Observable<ItemSubRowEvent> = rx_delegate.observe(#selector(RXReorderTableViewDelegate.tableView(_:closeSubAssetAtIndexPath:)))
            .map { arguments in
                return ((arguments[1] as? NSIndexPath))!
        }
        
        return ControlEvent(events: sourceSubRowClosed)
    }

    public var rx_itemRowMoved: ControlEvent<ItemMovedEvent> {
        let sourceRowMoved: Observable<ItemMovedEvent> = rx_delegate.observe(#selector(RXReorderTableViewDelegate.tableView(_:movedRowAtIndexPath:toIndexRowPath:)))
            .map { argumentseRowMoved in
                return ((argumentseRowMoved[1] as? NSIndexPath)!, (argumentseRowMoved[2] as? NSIndexPath)!)
        }
        
        return ControlEvent(events: sourceRowMoved)
    }
    

    public var rx_itemSubRowMovedToRoot: ControlEvent<ItemMovedEvent> {
        let sourceSubRowMovedToRoot: Observable<ItemMovedEvent> = rx_delegate.observe(#selector(RXReorderTableViewDelegate.tableView(_:movedRowAtIndexPath:toRootRowPath:)))
            .map { argumentsSubRowMoved in
                return ((argumentsSubRowMoved[1] as? NSIndexPath)!, (argumentsSubRowMoved[2] as? NSIndexPath)!)
        }
        
        return ControlEvent(events: sourceSubRowMovedToRoot)
    }


    public var rx_itemSubRowMoved: ControlEvent<ItemMovedEvent> {
      
        let sourceSubRowMoved: Observable <ItemMovedEvent> =
        rx_delegate.observe(#selector(RXReorderTableViewDelegate.tableView(_:movedSubRowAtIndexPath:toIndexSubRowPath:)))
            .map { subRowMovedArguments in
              
            return ((subRowMovedArguments[1] as? NSIndexPath)!, (subRowMovedArguments[2] as? NSIndexPath)!)
        }
        
        return ControlEvent(events: sourceSubRowMoved)
    }

    public var rx_itemSubRowMove: ControlEvent<ItemMovedEvent> {
        let sourceSubRowMove: Observable<ItemMovedEvent> = rx_delegate.observe(#selector(RXReorderTableViewDelegate.tableView(_:movingSubRowAtIndexPath:toIndexSubRowPath:)))
            .map { subRowMoveArguments in
                return ((subRowMoveArguments[1] as? NSIndexPath)!, (subRowMoveArguments[2] as? NSIndexPath)!)
        }
        
        return ControlEvent(events: sourceSubRowMove)
    }

    public var rx_itemMoveToRoot: ControlEvent<ItemMovedEvent> {
        let sourceMoveToRoot: Observable<ItemMovedEvent> = rx_delegate.observe(#selector(RXReorderTableViewDelegate.tableView(_:movingRowAtIndexPath:toRootRowPath:)))
            .map { argumentsMoveToRoot in
                return ((argumentsMoveToRoot[1] as? NSIndexPath)!, (argumentsMoveToRoot[2] as? NSIndexPath)! )
         }
               return ControlEvent(events: sourceMoveToRoot)
    }
    
 
    public func rx_changeOpenStateByCell <T>(modelType: T.Type) -> ControlEvent<(UITableViewCell,NSIndexPath?,T)> {
       
        let sourceOpenState: Observable<(UITableViewCell,NSIndexPath?,T)> = rx_delegate.observe(#selector(RXReorderTableViewCellDelegate.changeOpenStateByCell(_:)))
            .map { argumentsOpenState in
                let indexPath = self.indexPathForCell((argumentsOpenState[0] as? UITableViewCell)!)!
                //let object = just(try self.rx_modelAtIndexPath(indexPath))
                return ((argumentsOpenState[0] as? UITableViewCell)!,self.indexPathForCell((argumentsOpenState[0] as? UITableViewCell)!), try self.rx_modelAtIndexPath(indexPath) )
        }
        
        return ControlEvent(events: sourceOpenState)
    }
    
    
    public var rx_viewWillDisplayCell: ControlEvent<ItemWillViewCellBlock> {
        let sourceDisplayCell: Observable<ItemWillViewCellBlock> = rx_delegate.observe(#selector(UITableViewDelegate.tableView(_:willDisplayCell:forRowAtIndexPath:)))
            .map { argumentsDisplayCell in
                return ((argumentsDisplayCell[1] as? UITableViewCell)!, (argumentsDisplayCell[2] as? NSIndexPath)! )
        }
        return ControlEvent(events: sourceDisplayCell)
    }

}
