//
//  TabController.swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 23/08/2023.
//

import Foundation
import UIKit


extension UIApplication {
    class func findTabBarController() -> UITabBarController? {
        func findInHierarchy(controller: UIViewController?) -> UITabBarController? {
            if let tabController = controller as? UITabBarController {
                return tabController
            }
            if let navigationController = controller as? UINavigationController {
                return findInHierarchy(controller: navigationController.visibleViewController)
            }
            if let tabController = controller?.tabBarController {
                return tabController
            }
            if let presented = controller?.presentedViewController {
                return findInHierarchy(controller: presented)
            }
            return nil
        }
        
        return findInHierarchy(controller: UIApplication.shared.keyWindow?.rootViewController)
    }
}
