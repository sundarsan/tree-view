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


import UIKit


public func rgb(colorRed:Int,colorGreen:Int,colorBlue:Int,alpha :Int = 1) -> UIColor{
  let colorRed = CGFloat(colorRed ) / CGFloat(255.0)
  let colorGreen = CGFloat(colorGreen ) / CGFloat(255.0)
  let colorBlue = CGFloat( colorBlue) / CGFloat(255.0)
  
 return UIColor(red: colorRed, green: colorGreen, blue: colorBlue, alpha: CGFloat(alpha))
}

enum ReorderingState {
  case Flat
  case Submenu
  case Root
}

public class RXReorderTableView: UITableView {
  
  
  public var longPressReorderDelegate: RXReorderTableViewDelegate!
  
  public var longPressReorderDatasource: RXReorderTableViewDatasource!
  
  internal var longPressGestureRecognizer: UILongPressGestureRecognizer!
  
  internal var fromIndexPath: NSIndexPath?
  
  internal var currentLocationIndexPath: NSIndexPath?
  
  internal var movedView: UIView?
  
  internal var selectionView: UIView?
  
  
  internal var reorderingState: ReorderingState = .Flat
  
  var getureHandler :ReorderGestureHandler!
  
  /** A Bool property that indicates whether long press to reorder is enabled. */
  public var longPressReorderEnabled: Bool {
    get {
      return longPressGestureRecognizer.enabled
    }
    set {
      longPressGestureRecognizer.enabled = newValue
    }
  }
  
  public convenience init() {
    self.init(frame: CGRect.zero)
  }
  
  public override init(frame: CGRect, style: UITableViewStyle) {
    super.init(frame: frame, style: style)
    initialize()
  }
  
  public required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    initialize()
  }
  
  private func initialize() {
    self.getureHandler = ReorderGestureHandler(tableView: self)
    longPressGestureRecognizer = UILongPressGestureRecognizer(target: self.getureHandler, action: Selector("longPress:"))
    addGestureRecognizer(longPressGestureRecognizer)
  }
  
  func canMoveRowAt(indexPath indexPath: NSIndexPath) -> Bool {
    return (dataSource?.respondsToSelector(#selector(UITableViewDataSource.tableView(_:canMoveRowAtIndexPath:))) == false) || (dataSource?.tableView?(self, canMoveRowAtIndexPath: indexPath) == true)
  }
  
 
  func clearMovedView(){
    self.movedView?.removeFromSuperview()
    self.movedView = nil
  }

  func cancelGesture() {
    longPressGestureRecognizer.enabled = false
    longPressGestureRecognizer.enabled = true
  }
}





