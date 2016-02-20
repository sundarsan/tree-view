//
//  RXReorderTableViewExtension.swift
//  RXTreeControl
//
//  Created by Arcilite on 19.02.16.
//  Copyright © 2016 Arcilite. All rights reserved.
//

import Foundation
import UIKit

extension UITableView{
  
  func countRows() -> Int {
    let sections = numberOfSections
    var rows = 0
    for i in 0..<sections {
      rows += numberOfRowsInSection(i)
    }
    return rows
  }
  
}
