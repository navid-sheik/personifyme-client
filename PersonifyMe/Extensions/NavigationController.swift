//
//  NavigationController.swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 07/08/2023.
//

import Foundation
import UIKit
extension UINavigationController {
    var previousViewController: UIViewController? {
       viewControllers.count > 1 ? viewControllers[viewControllers.count - 2] : nil
    }
}
