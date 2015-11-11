//
//  RxPickerViewDataSourceType.swift
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
    
/**
 Marks data source as `UIPickerView` reactive data source enabling it to be used with one of the `bindTo` methods.
 */
public protocol RxPickerViewDataSourceType /*: UIPickerViewDataSource*/ {
    
    /**
     Type of elements that can be bound to picker view.
     */
    typealias Element
    
    /**
     New observable sequence event observed.
     
     - parameter pickerView: Bound picker view.
     - parameter observedEvent: Event
     */
    func pickerView(pickerView: UIPickerView, observedEvent: Event<Element>) -> Void

}
    
#endif

