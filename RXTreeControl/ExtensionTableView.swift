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

public typealias ItemSelectedViewEvent = (sourceIndex: NSIndexPath, destinationIndex: NSIndexPath) -> UIView




extension RxTableViewDataSourceProxy{
    
}

public class RxLongPressTableViewDelegateProxy
    : RxScrollViewDelegateProxy
, UITableViewDelegate, RXReorderTableViewDelegate {
    
    
    /**
     Typed parent object.
     */
    public weak private(set) var tableView: RXReorderTableView?
    
    /**
     Initializes `RxTableViewDelegateProxy`
     
     - parameter parentObject: Parent object for delegate proxy.
     */
    public required init(parentObject: AnyObject) {
        self.tableView = (parentObject as! RXReorderTableView)
        super.init(parentObject: parentObject)
    }
}

extension UITableView{
    //var k:Int!
    
    
    public func selectionViewForTableView(tableView: UITableView,destinitionCell cell:UITableViewCell,toIndexRowPath destinationRowIndexPath: NSIndexPath) -> UIView{
        let view = UIView()
        view.backgroundColor = UIColor.blueColor()
        return view
    }
    
   
    public override func rx_createDelegateProxy() -> RxScrollViewDelegateProxy {
        return RxTableViewDelegateProxy(parentObject: self)
    }


    
   
    
    public var rx_itemSubRowOpen: ControlEvent<ItemMovedEvent> {
        let source: Observable<ItemMovedEvent> = rx_dataSource.observe("tableView:openSubAssetAtIndexPath:toIndexSubRowPath:")
            .map { a in
                return ((a[1] as! NSIndexPath), (a[2] as! NSIndexPath))
        }
        
        return ControlEvent(events: source)
    }
    
    
    public var rx_itemSubRowClosed: ControlEvent<ItemMovedEvent> {
        let source: Observable<ItemMovedEvent> = rx_dataSource.observe("tableView:closeSubAssetAtIndexPath:toIndexSubRowPath:")
            .map { a in
                return ((a[1] as! NSIndexPath), (a[2] as! NSIndexPath))
        }
        
        return ControlEvent(events: source)
    }
    
    
    
    /*
    Reactive wrapper for `delegate` message `tableView:moveRowAtIndexPath:toIndexPath:`.
    func tableView(tableView: UITableView,movedRowAtIndexPath sourceIndexPath: NSIndexPath,toIndexRowPath destinationRowIndexPath: NSIndexPath)     */
    
    public var rx_itemRowMoved: ControlEvent<ItemMovedEvent> {
        let source: Observable<ItemMovedEvent> = rx_dataSource.observe("tableView:movedRowAtIndexPath:toIndexSubRowPath:")
            .map { a in
                return ((a[1] as! NSIndexPath), (a[2] as! NSIndexPath))
        }
        
        return ControlEvent(events: source)
    }
    
    /*
    Reactive wrapper for `delegate` message `tableView:movedRowAtIndexPath:toIndexPath:`.
    */
    
    public var rx_itemSubRowMovedToRoot: ControlEvent<ItemMovedEvent> {
        let source: Observable<ItemMovedEvent> = rx_dataSource.observe("tableView:movedRowAtIndexPath:toRootRowPath:")
            .map { a in
                return ((a[1] as! NSIndexPath), (a[2] as! NSIndexPath))
        }
        
        return ControlEvent(events: source)
    }

    
    
    /*
    func tableView(tableView: UITableView, movedSubRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexSubRowPath destinationSubRowIndexPath: NSIndexPath)
    */
    
    
    public var rx_itemSubRowMoved: ControlEvent<ItemMovedEvent> {
        let source: Observable<ItemMovedEvent> = rx_dataSource.observe("tableView:movedSubRowAtIndexPath:toIndexSubRowPath:")
            .map { a in
                return ((a[1] as! NSIndexPath), (a[2] as! NSIndexPath))
        }
        
        return ControlEvent(events: source)
    }
    
    
    /*
    Reactive wrapper for `delegate` message  func tableView(tableView: UITableView, moveSubRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexSubRowPath destinationSubRowIndexPath: NSIndexPath).
    */
    
    public var rx_itemSubRowMove: ControlEvent<ItemMovedEvent> {
        let source: Observable<ItemMovedEvent> = rx_dataSource.observe("tableView:moveSubRowAtIndexPath:toIndexSubRowPath:")
            .map { a in
                return ((a[1] as! NSIndexPath), (a[2] as! NSIndexPath))
        }
        
        return ControlEvent(events: source)
    }
    // func tableView(tableView: UITableView, moveSubRowAtIndexPath sourceIndexPath: NSIndexPath, toRootRowPath destinationSubRowIndexPath: NSIndexPath)
    public var rx_itemMoveToRoot: ControlEvent<ItemMovedEvent> {
        let source: Observable<ItemMovedEvent> = rx_dataSource.observe("tableView:moveSubRowAtIndexPath:toRootRowPath:")
            .map { a in
                return ((a[1] as! NSIndexPath), (a[2] as! NSIndexPath))
        }
        
        return ControlEvent(events: source)
    }
    
    
//    public var rx_itemSelected: ControlEvent<ItemMovedEvent> {
//        let source: Observable<ItemSelectedViewEvent> = rx_dataSource.observe("tableView:moveSubRowAtIndexPath:toIndexSubRowPath:")
//            .map { a in
//                return ((a[1] as! NSIndexPath), (a[2] as! NSIndexPath)  )//; -> (a[3] as! UIView)
//        }
//        
//        return ControlEvent(events: source)
//    }
    
}