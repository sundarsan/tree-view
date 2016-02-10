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

public typealias ItemSelectedViewBlock = (cell:UITableViewCell, destinationIndex: NSIndexPath)->UIView
public typealias ItemSubRowEvent = (NSIndexPath)
public typealias ItemCellOpenedChangeStateEvent = (UITableViewCell,NSIndexPath?)



public class  RxReorderTableViewDataSourceProxy:RxTableViewDataSourceProxy,RXReorderTableViewDatasource{
    
    var viewBlock : ((cell: UITableViewCell, destinationIndex: NSIndexPath)->UIView)!

    public required init(parentObject: AnyObject) {
       
        super.init(parentObject: parentObject)
        (self.tableView as! RXReorderTableView).longPressReorderDatasource = self
       
    }

    public func selectionViewForTableView(tableView: UITableView,destinitionCell cell:UITableViewCell,toIndexRowPath destinationRowIndexPath: NSIndexPath) -> UIView{
       
        return self.viewBlock(cell: cell,destinationIndex: destinationRowIndexPath)
    }
 
    
}

public class RxReorderTableViewDelegateProxy: RxTableViewDelegateProxy,RXReorderTableViewDelegate,RXReorderTableViewCellDelegate {
    
       //We need a way to read the current delegate
    override public class func currentDelegateFor(object: AnyObject) -> AnyObject? {
        let tableView: RXReorderTableView = object as! RXReorderTableView
        return tableView.longPressReorderDelegate
    }
    
    //We need a way to set the current delegate
    override public class func setCurrentDelegate(delegate: AnyObject?, toObject object: AnyObject) {
        let tableView: RXReorderTableView = object as! RXReorderTableView
        tableView.delegate = (delegate as! UITableViewDelegate)
        tableView.longPressReorderDelegate = delegate as! RXReorderTableViewDelegate
        super.setCurrentDelegate(delegate, toObject: object)
      
    }
    
  
    
    /**
     Typed parent object.
     */
}
    
extension RXReorderTableView{
  

    public override func rx_createDataSourceProxy() -> RxReorderTableViewDataSourceProxy {
        return RxReorderTableViewDataSourceProxy(parentObject: self)
    }
    
    public override func rx_createDelegateProxy() -> RxScrollViewDelegateProxy {
        return RxReorderTableViewDelegateProxy(parentObject: self)
    }

    

     public override  var rx_dataSource: RxReorderTableViewDataSourceProxy {
         return  proxyForObject(RxReorderTableViewDataSourceProxy.self, self)//RxReorderTableViewDataSourceProxy(parentObject: self)
     }

    public override var rx_delegate: DelegateProxy {
        return proxyForObject(RxReorderTableViewDelegateProxy.self, self)//RxReorderTableViewDelegateProxy(parentObject: self)//
    }

    
    public var rx_itemSubRowOpen: ControlEvent<ItemSubRowEvent> {
        let source: Observable<ItemSubRowEvent> = rx_delegate.observe("tableView:openSubAssetAtIndexPath:")
            .map { a in
                return ((a[1] as! NSIndexPath))
        }
        
        return ControlEvent(events: source)
    }
    
  
    
    public var rx_itemSubRowClosed: ControlEvent<ItemSubRowEvent> {
        let source: Observable<ItemSubRowEvent> = rx_delegate.observe("tableView:closeSubAssetAtIndexPath:")
            .map { a in
                return ((a[1] as! NSIndexPath))
        }
        
        return ControlEvent(events: source)
    }
    
    
    
    public var rx_itemRowMoved: ControlEvent<ItemMovedEvent> {
        let source: Observable<ItemMovedEvent> = rx_delegate.observe("tableView:movedRowAtIndexPath:toIndexRowPath:")
            .map { a in
                return ((a[1] as! NSIndexPath), (a[2] as! NSIndexPath))
        }
        
        return ControlEvent(events: source)
    }
    
    /*
    Reactive wrapper for `delegate` message `tableView:movedRowAtIndexPath:toIndexPath:`.
    */
    
    public var rx_itemSubRowMovedToRoot: ControlEvent<ItemMovedEvent> {
        let source: Observable<ItemMovedEvent> = rx_delegate.observe("tableView:movedRowAtIndexPath:toRootRowPath:")
            .map { a in
                return ((a[1] as! NSIndexPath), (a[2] as! NSIndexPath))
        }
        
        return ControlEvent(events: source)
    }

    
    
    /*
    func tableView(tableView: UITableView, movedSubRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexSubRowPath destinationSubRowIndexPath: NSIndexPath)
    */
    
    
    public var rx_itemSubRowMoved: ControlEvent<ItemMovedEvent> {
        let source: Observable<ItemMovedEvent> = rx_delegate.observe("tableView:movedSubRowAtIndexPath:toIndexSubRowPath:")
            .map { a in
                return ((a[1] as! NSIndexPath), (a[2] as! NSIndexPath))
        }
        
        return ControlEvent(events: source)
    }
    
    
    /*
    Reactive wrapper for `delegate` message  func tableView(tableView: UITableView, moveSubRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexSubRowPath destinationSubRowIndexPath: NSIndexPath).
    */
    
    public var rx_itemSubRowMove: ControlEvent<ItemMovedEvent> {
        let source: Observable<ItemMovedEvent> = rx_delegate.observe("tableView:movingSubRowAtIndexPath:toIndexSubRowPath:")
            .map { a in
                return ((a[1] as! NSIndexPath), (a[2] as! NSIndexPath))
        }
        
        return ControlEvent(events: source)
    }
    // func tableView(tableView: UITableView, moveSubRowAtIndexPath sourceIndexPath: NSIndexPath, toRootRowPath destinationSubRowIndexPath: NSIndexPath)
    public var rx_itemMoveToRoot: ControlEvent<ItemMovedEvent> {
        let source: Observable<ItemMovedEvent> = rx_delegate.observe("tableView:movingRowAtIndexPath:toRootRowPath:")
            .map { a in
                return ((a[1] as! NSIndexPath), (a[2] as! NSIndexPath) ) //; (a[3] as! UIView)
        }
               return ControlEvent(events: source)
    }
    // public func rx_changeOpenStateByCell <T> (modelType:T.Type) -> ControlEvent<ItemCellOpenedChangeStateEvent>
    public func rx_changeOpenStateByCell () -> ControlEvent<ItemCellOpenedChangeStateEvent> {
        
        let source: Observable<ItemCellOpenedChangeStateEvent> = rx_delegate.observe("changeOpenStateByCell:")
            .map { a in
              //  let indexPath = self.indexPathForCell(a[0] as! UITableViewCell)!
                //let object = just(try self.rx_modelAtIndexPath(indexPath))
                return ((a[0] as! UITableViewCell),self.indexPathForCell(a[0] as! UITableViewCell) )
        }
        
        return ControlEvent(events: source)
    }
    
    
      
}