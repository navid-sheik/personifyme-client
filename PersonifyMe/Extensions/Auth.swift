//
//  AuthViewController.swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 23/08/2023.
//

import Foundation
import UIKit
extension UIViewController {
    func requireLogin(for action: @escaping () -> Void) {
        guard let _ = UserDefaults.standard.object(forKey: "user_id") as? String else {
            // User is not authenticated, present login
            let auth = AuthViewContoller()
            auth.completionHandler = { [weak self] success in
                if success {
                    action()
                } else {
                    // Handle failed login if needed
                }
                self?.dismiss(animated: true, completion: nil)
            }
            let navController = UINavigationController(rootViewController: auth)
            navController.modalPresentationStyle = .fullScreen
            present(navController, animated: true, completion: nil)
            return
        }
        
        // User is authenticated, perform action
        action()
    }
}
