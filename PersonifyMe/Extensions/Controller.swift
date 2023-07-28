//
//  Controller.swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 28/07/2023.
//

import Foundation


import UIKit

extension UIViewController {
    func findTopController() -> UIViewController? {
        if let presented = self.presentedViewController {
            return presented.findTopController()
        }
        if let nav = self as? UINavigationController {
            return nav.visibleViewController?.findTopController()
        }
        if let tab = self as? UITabBarController {
            if let selected = tab.selectedViewController {
                return selected.findTopController()
            }
        }
        return self
    }
}
