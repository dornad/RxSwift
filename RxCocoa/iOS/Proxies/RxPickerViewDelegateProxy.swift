//
//  RxPickerViewDelegateProxy.swift
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
    
// Please take a look at `DelegateProxyType.swift`
class RxPickerViewDelegateProxy : RxScrollViewDelegateProxy
                                 ,UIPickerViewDelegate {
    
}
    
#endif

