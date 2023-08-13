//
//  DropDownTextfield.swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 13/08/2023.
//

import Foundation
import UIKit

import DropDown

extension UITextField {
    private struct AssociatedKeys {
        static var dropDown: DropDown?
    }
    
    var dropDown: DropDown? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.dropDown) as? DropDown
        }
        set {
            if let newValue = newValue {
                objc_setAssociatedObject(self, &AssociatedKeys.dropDown, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }
    }
}
