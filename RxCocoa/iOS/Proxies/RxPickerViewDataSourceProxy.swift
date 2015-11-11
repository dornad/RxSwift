//
//  RxPickerViewDataSourceProxy.swift
//  Rx
//
//  Created by Daniel Rodriguez on 11/11/15.
//  Copyright © 2015 Krunoslav Zaher. All rights reserved.
//

#if os(iOS) || os(tvOS)
    
import Foundation
import UIKit
#if !RX_NO_MODULE
import RxSwift
#endif

let pickerViewDataSourceNotSet = PickerViewDataSourceNotSet()
    
class PickerViewDataSourceNotSet: NSObject
                                , UIPickerViewDataSource {
    
    public func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return rxAbstractMethodWithMessage(dataSourceNotSet)
    }
    
    public func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return rxAbstractMethodWithMessage(dataSourceNotSet)
    }
}
    
// Please take a look at `DelegateProxyType.swift`
class RxPickerViewDataSourceProxy: DelegateProxy
                                 , UIPickerViewDataSource
                                 , DelegateProxyType {

    unowned let pickerView: UIPickerView
    
    unowned var dataSource: UIPickerViewDataSource = pickerViewDataSourceNotSet
    
    required init(parentObject: AnyObject) {
        self.pickerView = parentObject as! UIPickerView
        super.init(parentObject: parentObject)
    }
    
    // data source delegate
    
    public func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return self.dataSource.numberOfComponentsInPickerView(pickerView)
    }
    
    public func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.dataSource.pickerView(pickerView, numberOfRowsInComponent: component)
    }
    
    // proxy
    
    override class func delegateAssociatedObjectTag() -> UnsafePointer<Void> {
        return _pointer(&dataSourceAssociatedTag)
    }
    
    class func setCurrentDelegate(delegate: AnyObject?, toObject object: AnyObject) {
        let pickerView: UIPickerView = castOrFatalError(object)
        pickerView.dataSource = castOptionalOrFatalError(delegate)
    }
    
    class func currentDelegateFor(object: AnyObject) -> AnyObject? {
        let pickerView: UIPickerView = castOrFatalError(object)
        return pickerView.dataSource
    }
    
    override func setForwardToDelegate(forwardToDelegate: AnyObject?, retainDelegate: Bool) {
        let dataSource: UIPickerViewDataSource? = castOptionalOrFatalError(forwardToDelegate)
        self.dataSource = dataSource ?? pickerViewDataSourceNotSet
        super.setForwardToDelegate(forwardToDelegate, retainDelegate: retainDelegate)
    }
    
}
    
#endif
