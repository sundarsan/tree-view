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
