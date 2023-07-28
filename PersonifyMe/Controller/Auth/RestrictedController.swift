//
//  RestrictedController.swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 27/07/2023.
//

import Foundation

import UIKit

class RestrictedController: UIViewController {
    
    // Constants
    private let tokenKey = "token"
    private let refreshTokenKey = "refresh_token"
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkUserLoggedIn()
    }
    
    private func checkUserLoggedIn() {
        guard UserDefaults.standard.string(forKey: tokenKey) != nil,
              UserDefaults.standard.string(forKey: refreshTokenKey) != nil else {
   
            
            // Show login screen if token or refresh token is nil
            presentLoginScreen()
            
            return
        }
    }
    
    private func presentLoginScreen() {
        let loginVC = LoginViewController()
        let nav = UINavigationController(rootViewController: loginVC)
//        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true, completion: nil)
    }
}
