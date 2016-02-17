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
#if !RX_NO_MODULE
import RxSwift
#endif

#if os(iOS)
    import UIKit
    typealias OSViewController = UIViewController
#elseif os(OSX)
    import Cocoa
    typealias OSViewController = NSViewController
#endif

class BaseViewController: OSViewController {
#if TRACE_RESOURCES
    #if !RX_NO_MODULE
    private let startResourceCount = RxSwift.resourceCount
    #else
    private let startResourceCount = resourceCount
    #endif
#endif

    var disposeBag = DisposeBag()

    override func viewDidLoad() {
#if TRACE_RESOURCES
        print("Number of start resources = \(resourceCount)")
#endif
    }
    
    deinit {
#if TRACE_RESOURCES
        print("View controller disposed with \(resourceCount) resources")
    
        let numberOfResourcesThatShouldRemain = startResourceCount
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(0.1 * Double(NSEC_PER_SEC)))
        dispatch_after(time, dispatch_get_main_queue(), { () -> Void in
            assert(resourceCount <= numberOfResourcesThatShouldRemain, "Resources weren't cleaned properly")
        })
#endif
    }
}
