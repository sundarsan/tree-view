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

class TreeController {
    
    var treeArray: [TreeModelView]!
    private  var treeModel: TreeModel!
    
    init(treeModel: TreeModel) {
        self.treeModel = treeModel
        loadModel()
    }
    
    func loadModel() {
        let treeArray = treeModel.generateTree() as? [Tree] ?? []
        self.treeArray = buildTree(treeArray, parent: nil)
        self.treeArray = self.openNodeArray(self.treeArray)
    }
    
    func buildTree(treeArray: [TreeProtocol], parent: TreeModelView?, level: Int = 0) -> [TreeModelView] {
        var treeModelViewArray = [TreeModelView]()
        
        if let tree = treeArray.first {
            let modelViewTree = buildTreeObject(tree, parent: parent, level: level)
    
            treeModelViewArray.append(modelViewTree)
            
            var updatedTree = treeArray
            updatedTree.removeFirst()
            treeModelViewArray+=buildTree(updatedTree, parent: parent, level: level)
        }
        
        return treeModelViewArray
    }
    

    func buildTreeObject(treeObject: TreeProtocol, parent: TreeModelView?, level: Int) -> TreeModelView {
        let treeModelView = TreeModelView()
        treeModelView.level = level //parent?.level ?? 0 + 1
        treeModelView.parentObject = parent
        treeModelView.treeObject = treeObject
        
        treeModelView.subobjects = buildTree(treeObject.subtrees ?? [], parent:treeModelView, level: level+1)
        return treeModelView
    
    }
    
    
      func openNodeArray( tree: [TreeModelView])->[TreeModelView] {
        var nodeArray = [TreeModelView]()
        
        for node in tree {
            
            nodeArray.append(node)
            
            nodeArray+=self.openNode(node)
            
        }
        return nodeArray
    }
    
     func openNode(treeObject: TreeModelView)->[TreeModelView] {
        var nodeArray = [TreeModelView]()
        if(!treeObject.isTreeOpen) {
            if treeObject.subobjects.count > 0 {
                treeObject.isTreeOpen = true
                nodeArray=self.openNodeArray(Array(treeObject.subobjects))
            }
            
        }
        
        return nodeArray
    }
    
    

      func closeSubassetByIndex(index: Int) {
        let assetTreeObject = treeArray[index]
        closeSubasset(assetTreeObject)
        
    }
    
      func  indexesOfDeletedObjectsArray(array: [TreeModelView], objects: [TreeModelView]) -> [Int] {
        var result: [Int] = []
        for (index, obj) in array.enumerate() {
            if objects.indexOf(obj) == .None {
                result.append(index)
            }
        }
        return result
    }
    
    
       func  indexesOfObjectsArray(array: [TreeModelView], objects: [TreeModelView]) -> [Int] {
        var result: [Int] = []
        for (index, obj) in array.enumerate() {
            if objects.indexOf(obj) != .None {
                result.append(index)
            }
        }
        return result
    }
    
    
      func openSubassetIndexes(asset: TreeModelView)->[Int] {
        
        
        self.openSubasset(asset)
        let indexes = self.indexesOfObjectsArray(asset.subobjects, objects: self.treeArray)
        return indexes
    }
    
     func closeSubassetIndexes(asset: TreeModelView)->[Int] {
        
        
        
        let newTree = removeAssetTree(asset, fromArray: self.treeArray)
        
        
        let indexes = self.indexesOfDeletedObjectsArray(self.treeArray, objects: newTree)
        
        self.treeArray  = newTree
        asset.isTreeOpen = false
        return indexes
    }
    
    func closeSubasset(asset: TreeModelView)->[Int] {
        let  closedArray = removeAssetTree(asset, fromArray: self.treeArray)
        let indexes =  self.indexesOfDeletedObjectsArray(self.treeArray, objects: closedArray)
        self.treeArray  = closedArray
     
        asset.isTreeOpen = false
        print(indexes)
        return indexes
    }
    
     func openSubasset(asset: TreeModelView)-> [Int] {
        var indexes = [Int]()
        if asset.subobjects.count > 0 {
            
            if let index = self.treeArray.indexOf(asset) {
                self.treeArray.insertContentsOf(asset.subobjects, at: index+1)
                let startIndex = index+1
                for idx in startIndex ..< asset.subobjects.count+startIndex {
                   indexes.append(idx)
                }
                
                asset.isTreeOpen = true
            }
            
            
        }
        
        print(indexes)
        return indexes
    }
    
    func openOrCloseSubassetByIndex(index: Int) -> [Int] {
        let asset  =  self.treeArray[index]
        if(asset.isTreeOpen) {
            return  closeSubasset(asset)
        }else {
            return  openSubasset(asset)
            
        }
        
    }
    
    func openOrCloseSubasset(asset: TreeModelView) -> [Int] {
        
        if(asset.isTreeOpen) {
          return  closeSubasset(asset)
        }else {
          return  openSubasset(asset)
            
        }
        
    }
    
    func openTreeByIndex(index: Int) -> [Int] {
        let tree = self.treeArray[index]
        if !tree.isTreeOpen {
           return self.openSubasset(tree)
        }
        return []
    }
    
     func removeAssetsTrees(assetTrees: [TreeModelView], fromArray: [TreeModelView]) -> [TreeModelView] {
        var array: [TreeModelView] =  fromArray
        for treeAsset in fromArray {
            treeAsset.isTreeOpen = false
            if treeAsset.subobjects.count > 0 {
                array = self.removeAssetTree(treeAsset, fromArray: array)
            }
        }
        return array
    }
    
    private func removeAssetTree(assetTree: TreeModelView, fromArray: [TreeModelView])-> [TreeModelView] {
        var array: [TreeModelView] =  fromArray
        
        for subasset in assetTree.subobjects {
            subasset.isTreeOpen = false
            array = self.removeAssetTree(subasset, fromArray: array)
            if let index = array.indexOf(subasset) {
                array.removeAtIndex(index)
            }
        }
        
        return array
    }

    

     func moveInTreeFromAssetIndex(index: Int, toIndex: Int) {
        let movedObject = self.treeArray[index]
        let targetObject = self.treeArray[toIndex]
        moveInTreeFromAssetObject(movedObject, targetObject: targetObject)
    }
    
     func moveInTreeFromAssetObject(movedObject: TreeModelView, targetObject: TreeModelView) {
        
        if let index = self.treeArray.indexOf(movedObject) {
            if let toIndex = self.treeArray.indexOf(targetObject) {
                
                if index != toIndex {
                    
                    
                    if let movedParent = movedObject.parentObject {
                        
                        if let targetParent = targetObject.parentObject {
                            
                            self.reorderChildObjectsFromMovedObject(movedObject, targetObject: targetObject, movedParent: movedParent, targetParent: targetParent)
                            
                        }else {
                            movedObject.setParentLevel(0)
                            movedObject.parentObject = nil
                            if let index = movedParent.subobjects.indexOf(movedObject) {
                                
                                movedParent.subobjects.removeAtIndex(index)
                            }
                            
                        }
                        
                    }else {
                        
                        if let targetParent = targetObject.parentObject {
                            self.reorderHieracrlieLevelChildObjectsFromMovedObject(movedObject, targetObject: targetObject, targetParent: targetParent)
                            
                            
                        }
                        
                        
                    }
                    
                    
                    
                }
                
                let toObject = treeArray[toIndex]
                
                treeArray.removeAtIndex(index)
                
                if toObject.parentObject == nil  && toObject.isTreeOpen && toIndex != 0 {
                    treeArray.insert(movedObject, atIndex: toIndex-1)
                }else {
                    treeArray.insert(movedObject, atIndex: toIndex)
                }
                
                
            }
        }
        
        
        
    }
    
    
    
    
     func reorderChildObjectsFromMovedObject(movedObject: TreeModelView, targetObject: TreeModelView, movedParent: TreeModelView, targetParent: TreeModelView) {
        if targetParent.subobjects.count > 0  && targetParent.isTreeOpen && movedParent != targetParent {
            
            self.reorderHieracrlieLevelChildObjectsFromMovedObject(movedObject, targetObject: targetObject, targetParent: targetParent)
            
            if let index = movedParent.subobjects.indexOf(movedObject) {
                
                movedParent.subobjects.removeAtIndex(index)
            }
        }else {
          //  self.reoderInSameParent(targetParent, movedObject: movedObject, targetObject: targetObject)
            
        }
        
    }
    
    
    
     func reorderHieracrlieLevelChildObjectsFromMovedObject(movedObject: TreeModelView, targetObject: TreeModelView, targetParent: TreeModelView) {
        if let subIndex = targetParent.subobjects.indexOf(targetObject) {
            
            movedObject.parentObject = targetParent
            targetParent.subobjects.insert(movedObject, atIndex: subIndex)
            
        }
        movedObject.setParentLevel(targetParent.level)
        
    }
    
    
     func reorderHieracrlieLevelChildObjectsFromMovedObject(movedObject: TreeModelView, targetObject: TreeModelView) {
        
        movedObject.parentObject = targetObject.parentObject
        targetObject.subobjects.insert(movedObject, atIndex: 0)
        movedObject.setParentLevel(targetObject.level)
    
    }
    
    
     func reoderInSameParent(parent: TreeModelView, movedObject: TreeModelView, targetObject: TreeModelView) {
        
        if let index = parent.subobjects.indexOf(movedObject) {
            if let indexMoved = parent.subobjects.indexOf(targetObject) {
                
                var subasssets = parent.subobjects
                
                subasssets.removeAtIndex(index)
                subasssets.insert(movedObject, atIndex: indexMoved )
                
                parent.subobjects = subasssets
            }
        }
        
    }
    


}
