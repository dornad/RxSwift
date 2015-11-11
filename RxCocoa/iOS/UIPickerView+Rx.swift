//
//  UIPickerView+Rx.swift
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

extension UIPickerView {
 
    /**
     Binds sequences of elements to picker view components and sections.
     
     - parameter source: Observable sequence of items.
     - parameter pickerFactory: Transform between sequence elements and picker view sections.
     - paramater pickerComponentFactory: Transform between sequence elements and sub-sections inside picker views
     - returns: Disposable object that can be used to unbind.
     */
    public func rx_itemsWithFactories<S: SequenceType, O: ObservableType where O.E ==S>
        (source:O)
        (pickerFactory: UIPickerView, Int, S.Generator.Element -> Int)
        (pickerComponentFactory: (UIPickerView, Int, S.Generator.Element) -> Int)
        -> Disposable {
            let dataSource = RxPickerViewSectionedReactiveDelegateWrapper<S>(pickerFactory: pickerFactory, componentFactory: pickerComponentFactory)
            
            return self.rx_itemsWithDataSource(dataSource)(source: source)
    }
    
    /**
     Binds sequences of elements to picker view rows using a custom reactive data used to perform the transformation.
     
     - parameter dataSource: Data source used to transform elements to picker view segments
     - parameter source: Observable sequence of items.
     - returns: Disposable object that can be used to unbind.
     */
    public func rx_itemsWithDataSource<DataSource: protocol<RxPickerViewDataSourceType, UIPickerViewDataSource>, S: SequenceType, O: ObservableType where DataSource.Element == S, O.E == S>
        (dataSource: DataSource)
        (source: O)
        -> Disposable  {
            return source.subscribeProxyDataSourceForObject(self, dataSource: dataSource, retainDataSource: false) { [weak self] (_: RxPickerViewDataSourceProxy, event) -> Void in
                guard let pickerView = self else {
                    return
                }
                dataSource.pickerView(pickerView, observedEvent: event)
            }
    }
}
    
#endif
