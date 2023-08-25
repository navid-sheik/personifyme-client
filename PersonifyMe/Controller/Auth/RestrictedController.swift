//
//  RestrictedController.swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 27/07/2023.
//

import Foundation

import UIKit

extension Notification.Name {
    static let userDidLogin = Notification.Name("userDidLogin")
    static let userDidLogout = Notification.Name("userDidLogout")
}

class RestrictedController: UIViewController {

    private let tokenKey = "token"
    private let refreshTokenKey = "refresh_token"
    
    var authenticationRequiredView: UIView?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(userDidLogin), name: .userDidLogin, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(userDidLogout), name: .userDidLogout, object: nil)

        // Initial check for authentication
        checkUserLoggedIn()
    }

    deinit {
        NotificationCenter.default.removeObserver(self, name: .userDidLogin, object: nil)
        NotificationCenter.default.removeObserver(self, name: .userDidLogout, object: nil)
    }

    private func checkUserLoggedIn() {
        if UserDefaults.standard.string(forKey: tokenKey) != nil,
            UserDefaults.standard.string(forKey: refreshTokenKey) != nil {
            
            setupAuthenticatedUI()
        } else {
            teardownAuthenticatedUI()
        }
    }

    @objc func userDidLogin() {
        setupAuthenticatedUI()
    }

    @objc func userDidLogout() {
        teardownAuthenticatedUI()
    }

    
    // Call this when the user is authenticated
      func setupAuthenticatedUI() {
          // Remove the 'authentication required' view if it exists
          authenticationRequiredView?.removeFromSuperview()
          authenticationRequiredView = nil
      }
      
    // Call this when the user is not authenticated
    func teardownAuthenticatedUI() {
        // Create and add a 'authentication required' view
        for view in self.view.subviews {
            view.removeFromSuperview()
        }
       
        setUpUIImpletation()
        presentLoginScreen()
    }
    
    

    
    func setUpUIImpletation (){
        if authenticationRequiredView == nil {
            authenticationRequiredView = NoLoggedInView(message: "In order to pass")
        }
        if let authView = authenticationRequiredView as? NoLoggedInView {
            authView.delegate = self
            self.view.addSubview(authView)
            authView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                authView.topAnchor.constraint(equalTo: self.view.topAnchor),
                authView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
                authView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                authView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
            ])
            
            self.view.bringSubviewToFront(authView)
        }
        
    
        
    }
 

    func presentLoginScreen() {
        if let tabBarController = UIApplication.findTabBarController() {
            DispatchQueue.main.async {
                let loginVC = AuthViewContoller()
                let navigationController = UINavigationController(rootViewController: loginVC)
                navigationController.modalPresentationStyle = .fullScreen
                
                // Present the new view controller
                tabBarController.present(navigationController, animated: true, completion: nil)
            }
        } else {
            print("TabBarController not found")
        }
//        let loginVC = AuthViewContoller() // Replace with your actual login view controller
//        let nav = UINavigationController(rootViewController: loginVC)
//        nav.modalPresentationStyle = .fullScreen
//        present(nav, animated: true, completion: nil)
    }
    
 
}

extension RestrictedController :  NoLoggedInViewDelegate{
    func didTapSignIn() {
        print("Did tap")
        presentLoginScreen()
    }
    
    
}
