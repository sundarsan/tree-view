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
#if !RX_NO_MODULE
import RxSwift
import RxCocoa
#endif

public class RxTableViewSectionedReloadDataSource<S: SectionModelType> : RxTableViewSectionedDataSource<S>
, RxTableViewDataSourceType {
    public typealias Element = [S]
    
    public func tableView(tableView: UITableView, observedEvent: Event<Element>) {
        switch observedEvent {
        case .Next(let element):
            setSections(element)
            tableView.reloadData()
        case .Error(let error):
            print(error)
            break
           
        case .Completed:
            break
        }
    }
}

// objc monkey business
public class _RxTableViewSectionedDataSource: NSObject
                                             , UITableViewDataSource {
    
    func _numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    public func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return _numberOfSectionsInTableView(tableView)
    }

    func _tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _tableView(tableView, numberOfRowsInSection: section)
    }

    func _tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return (nil as UITableViewCell?)!
    }
    
    public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return _tableView(tableView, cellForRowAtIndexPath: indexPath)
    }

    func _tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return nil
    }
    
    public func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return _tableView(tableView, titleForHeaderInSection: section)
    }

    func _tableView(tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return nil
    }
    
    public func tableView(tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return _tableView(tableView, titleForFooterInSection: section)
    }
}

public class RxTableViewSectionedDataSource<S: SectionModelType> : _RxTableViewSectionedDataSource {
    
    public typealias I = S.Item
    public typealias Section = S
    public typealias CellFactory = (UITableView, NSIndexPath, I) -> UITableViewCell
    
    // This structure exists because model can be mutable
    // In that case current state value should be preserved.
    // The state that needs to be preserved is ordering of items in section
    // and their relationship with section.
    // If particular item is mutable, that is irrelevant for this logic to function
    // properly.
    public typealias SectionModelSnapshot = SectionModel<S, I>
    
    private var _sectionModels: [SectionModelSnapshot] = []

    public func sectionAtIndex(section: Int) -> S {
        return self._sectionModels[section].model
    }

    public func itemAtIndexPath(indexPath: NSIndexPath) -> I {
        return self._sectionModels[indexPath.section].items[indexPath.item]
    }

    public func setSections(sections: [S]) {
        self._sectionModels = sections.map { SectionModelSnapshot(model: $0, items: $0.items) }
    }
    
    public var cellFactory: CellFactory! = nil
    
    public var titleForHeaderInSection: ((section: Int) -> String)?
    public var titleForFooterInSection: ((section: Int) -> String)?
    
    public var rowAnimation: UITableViewRowAnimation = .Automatic
    
    public override init() {
        super.init()
        self.cellFactory = { [weak self] _ in
            if let strongSelf = self {
                precondition(false, "There is a minor problem. `cellFactory` property on \(strongSelf) was not set. Please set it manually, or use one of the `rx_bindTo` methods.")
            }
            
            return (nil as UITableViewCell!)!
        }
    }
    
    // UITableViewDataSource
    
    override func _numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return _sectionModels.count
    }
    
    override func _tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _sectionModels[section].items.count
    }
    
    override func _tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        precondition(indexPath.item < _sectionModels[indexPath.section].items.count)
        
        return cellFactory(tableView, indexPath, itemAtIndexPath(indexPath))
    }
    
    override func _tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return titleForHeaderInSection?(section: section)
    }
    
    override func _tableView(tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return titleForFooterInSection?(section: section)
    }
    
}
