//
//  ReorderGestureHandler.swift
//  RXTreeControl
//
//  Created by Arcilite on 18.02.16.
//  Copyright © 2016 Arcilite. All rights reserved.
//

import UIKit

public class ReorderGestureHandler: NSObject {
  
  private var scrollRate = 0.0
  
  private var scrollDisplayLink: CADisplayLink?
  
  private var reorderingState: ReorderingState = .Flat
  
  private var longPressReorderDelegate: RXReorderTableViewDelegate!
  
  private var longPressReorderDatasource: RXReorderTableViewDatasource!
  
  
//  public convenience init() {
//    self.init()
//  }

  
  
  
  
}
