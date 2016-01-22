//
//  TreeModel.swift
//  RXTreeControl
//
//  Created by Arcilite on 28.12.15.
//  Copyright © 2015 Arcilite. All rights reserved.
//

import UIKit

import RxSwift
import RxBlocking



class TreeModel {

    
     func generateTree() -> [TreeProtocol] {
        
        var treeArray = [Tree]()
        
        let dbTreeFirst = Tree()
        dbTreeFirst.title = "1"
      
        treeArray.append(dbTreeFirst)
        
        var subassetsFirst = [Tree]()
        
        let dbAssetSecond = Tree()
        dbAssetSecond.title = "2"
       
        subassetsFirst.append(dbAssetSecond)
        
        var subassetsSecond = [Tree]()
        let dbAssetThird = Tree()
        dbAssetThird.title = "3"
        
        subassetsSecond.append(dbAssetThird)
        
        dbAssetSecond.subtrees = subassetsSecond
        dbTreeFirst.subtrees = subassetsFirst
        
        subassetsSecond.append(dbAssetThird)
        
        
        let dbAssetFourth = Tree()
        dbAssetFourth.title = "4"
       
        treeArray.append(dbAssetFourth)
        var subassetsThird = [Tree]()
        
        let dbAssetFifth = Tree()
        dbAssetFifth.title = "5"
     
        subassetsThird.append(dbAssetFifth)
        
        let dbAssetSix =  Tree()
        dbAssetSix.title = "6"
       
        subassetsThird.append(dbAssetSix)
        
        dbAssetFourth.subtrees =  subassetsThird
        subassetsThird.append(dbAssetFifth)
        
        
        return treeArray
        
    }
}
