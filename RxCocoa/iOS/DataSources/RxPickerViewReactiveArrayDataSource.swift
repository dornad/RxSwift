//
//  RxPickerViewReactiveArrayDataSource.swift
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
    
class _RxPickerViewSectionedReactiveDelegate : NSObject, UIPickerViewDataSource, UIPickerViewDelegate {
    
    // returns the number of 'columns' to display.
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return rxAbstractMethod()
    }
    
    // returns the # of rows in each component..
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return rxAbstractMethod()
    }
    
}

class RxPickerViewSectionedReactiveDelegateWrapper<S: SequenceType> : RxPickerViewSectionedReactiveDelegate<S.Generator.Element>
, RxPickerViewDelegateType {
    typealias Element = S
    
    override init(pickerFactory:PickerFactoryType, componentFactory:PickerComponentFactoryType) {
        super.init(pickerFactory: pickerFactory, componentFactory: componentFactory)
    }
    
    func pickerView(pickerView: UIPickerView, observedEvent: Event<S>) {
        switch observedEvent {
        case .Next(let value):
            super.pickerView(pickerView, observedElements: Array(value))
        case .Error(let error):
            bindingErrorToInterface(error)
        case .Completed:
            break
        }
    }
}
    
// Please take a look at `DelegateProxyType.swift`
class RxPickerViewSectionedReactiveDelegate<Element> : _RxPickerViewSectionedReactiveDelegate {
    
    typealias PickerFactoryType = UIPickerView -> Int
    typealias PickerComponentFactoryType = (UIPickerView, Int) -> Int
    
    var itemModels: [Element]? = nil
    
    func modelAtIndex(index: Int) -> Element? {
        return itemModels?[index]
    }
    
    let pickerFactory: PickerFactoryType
    let pickerComponentFactory: PickerComponentFactoryType
    
    init(pickerFactory:PickerFactoryType, componentFactory:PickerComponentFactoryType) {
        self.pickerFactory = pickerFactory
        self.pickerComponentFactory = componentFactory
    }
    
    // _Rx Overrides
    
    override func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return self.pickerFactory(pickerView)
    }
    
    override func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.pickerComponentFactory(pickerView, component)
    }
    
    // reactive
    
    func pickerView(pickerView: UIPickerView, observedElements: [Element]) {
        self.itemModels = observedElements
        pickerView.reloadAllComponents()
    }
}


    
#endif

