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

public struct SectionModel<Section, ItemType> : SectionModelType, CustomStringConvertible {
    public typealias Item = ItemType
    public var model: Section
    
    public var items: [Item]
    
    public init(model: Section, items: [Item]) {
        self.model = model
        self.items = items
    }
    
    public init(original: SectionModel, items: [Item]) {
        self.model = original.model
        self.items = items
    }
    
    public var description: String {
        get {
            return "\(self.model) > \(items)"
        }
    }
}

public struct HashableSectionModel<Section: Hashable, ItemType: Hashable> : Hashable, SectionModelType, CustomStringConvertible {
    public typealias Item = ItemType
    public var model: Section
    
    public var items: [Item]
    
    public init(model: Section, items: [Item]) {
        self.model = model
        self.items = items
    }
    
    public init(original: HashableSectionModel, items: [Item]) {
        self.model = original.model
        self.items = items
    }
    
    public var description: String {
        get {
            return "HashableSectionModel(model: \"\(self.model)\", items: \(items))"
        }
    }
    
    public var hashValue: Int {
        get {
            return self.model.hashValue
        }
    }

}

public func == <S, I>(lhs: HashableSectionModel<S, I>, rhs: HashableSectionModel<S, I>) -> Bool {
    return lhs.model == rhs.model
}
