//
//  TreeModelView.swift
//  RXTreeControl
//
//  Created by Arcilite on 15.12.15.
//  Copyright © 2015 Arcilite. All rights reserved.
//

import UIKit


@objc protocol TreeProtocol {
    var title : String!{get set}
    var subtrees:[TreeProtocol]! {get set}
}

class TreeModelView:NSObject {
    
    var parentObject:TreeModelView!
    var treeObject :TreeProtocol!
    var subobjects:[TreeModelView]!
    var level:Int = 0
    var isTreeOpen:Bool = false
    
    func setParentLevel(level:Int){
        self.level = level + 1
//        for subobject in self.subobjects{
//            subobject.setParentLevel(self.level)
//            
//        }
    }
    
}
