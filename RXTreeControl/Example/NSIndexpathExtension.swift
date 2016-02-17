//
//  NSIndexpathExtension.swift
//  CSite
//
//  Created by Arcilite on 29.04.15.
//  Copyright (c) 2015 Ramotion. All rights reserved.
//

import Foundation

extension NSIndexPath {

    class func indexPathsFromSection(section: Int, indexesArray: [Int]) -> [NSIndexPath] {
        var inexPaths = [NSIndexPath]()
        
        for index in indexesArray {
            print(index)
            let indexPath = NSIndexPath(forRow: index, inSection: section)
            inexPaths.append(indexPath)
        }
        
        return inexPaths
    
    }
}
