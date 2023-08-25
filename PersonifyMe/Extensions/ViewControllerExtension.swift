//
//  ViewControllerExtension.swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 18/08/2023.
//

import Foundation
import UIKit

//extension UIViewController {
//    func hideKeyboardWhenTappedAround() {
//        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
//        tap.cancelsTouchesInView = false
//        view.addGestureRecognizer(tap)
//    }
//    
//    @objc func dismissKeyboard() {
//        view.endEditing(true)
//    }
//}


extension UIViewController {
    
    private static var activityIndicatorAssocKey = "activityIndicatorAssocKey"
    
    var activityIndicator: UIActivityIndicatorView {
        if let activityIndicator = objc_getAssociatedObject(self, &UIViewController.activityIndicatorAssocKey) as? UIActivityIndicatorView {
            return activityIndicator
        } else {
            let activityIndicator = UIActivityIndicatorView(style: .large)
            activityIndicator.translatesAutoresizingMaskIntoConstraints = false
            activityIndicator.hidesWhenStopped = true
            
            self.view.addSubview(activityIndicator)
            
            NSLayoutConstraint.activate([
                activityIndicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                activityIndicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
            ])
            
            objc_setAssociatedObject(self, &UIViewController.activityIndicatorAssocKey, activityIndicator, .OBJC_ASSOCIATION_RETAIN)
            
            return activityIndicator
        }
    }
    
    func showLoading() {
            DispatchQueue.main.async {
                self.activityIndicator.startAnimating()
                self.view.isUserInteractionEnabled = false
            }
        }
        
        func hideLoading() {
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                self.view.isUserInteractionEnabled = true
            }
        }
}
 

import UIKit

extension UIViewController {
    
    func isUserAuthorized() -> Bool {
        // Implement your actual authorization logic here
        let defaults = UserDefaults.standard
        let dictionary = defaults.dictionaryRepresentation()

        for (key, value) in dictionary {
            print("\(key) = \(value) \n")
        }
        if let user_id = UserDefaults.standard.object(forKey: "user_id") {
            print(user_id)
            return true
        }else {
            return false
        }
    }
    
    func performActionOrAuthorize(completionHandler: @escaping (Bool) -> Void) {
        if isUserAuthorized() {
            completionHandler(true)
        } else {
            presentAuthController { success in
                self.dismiss(animated: true, completion: nil)
                completionHandler(success)
            }
        }
    }
    
    func presentAuthController(completionHandler: @escaping (Bool) -> Void) {
        let authController = AuthViewContoller()
        authController.completionHandler = completionHandler
        let navigationController = UINavigationController(rootViewController: authController)
        navigationController.modalPresentationStyle  = .fullScreen
        present(navigationController, animated: true, completion: nil)
    }
}
