//
//  ResetPasswordViewController.swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 27/07/2023.
//

import Foundation
import UIKit

class ResetPasswordViewController : UIViewController{
    
    private let userId : String
    
    private let token : String
    
    
    
    //MARK: Properties
    
    let headerView  : AuthHeaderView = {
        let view = AuthHeaderView(title: "Password Reset", subTitle: "")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    let passwordTextField : CustomTextField = {
        
        let textField = CustomTextField(fieldType: .password)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let confirmPasswordTextField : CustomTextField = {
        let textField = CustomTextField(fieldType: .password)
        textField.placeholder = "Confirm Password"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    
    let resetButton : CustomButton = {
        let button  =  CustomButton(title: "Reset", hasBackground: true, fontType: .medium)
        button.addTarget(self, action: #selector(didTapReset), for: .touchUpInside)
        
        return button
    }()
    
    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        
//    }
//    
    private let backButton  :  UIButton =  {
        let button = UIButton()
        button.setImage(UIImage(systemName: "arrow.backward"), for: .normal)
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        button.tintColor = DesignConstants.primaryColor
        return button
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.isHidden =  true
        
        setUpView()
        
        
    }
    
    
    init(userId: String, token: String) {
        self.userId = userId
        self.token = token
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    private func setUpView(){
        view.addSubview(headerView)
        headerView.titleLabel.text = "Password Reset"
        view.addSubview(passwordTextField)
        view.addSubview(confirmPasswordTextField)
        view.addSubview(resetButton)
        view.addSubview(backButton)
        
        backButton.anchor(top: self.view.safeAreaLayoutGuide.topAnchor, left: self.view.leadingAnchor, right: nil, bottom: nil, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 40, height: 40)
        
        
        let width  = self.view.frame.width * 0.8
        headerView.anchor(top: backButton.topAnchor, left: nil, right: nil, bottom: nil, paddingTop: 20, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: width, height: 100)
        headerView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        passwordTextField.anchor(top: headerView.bottomAnchor, left: view.leadingAnchor, right: view.trailingAnchor, bottom: nil, paddingTop: 20, paddingLeft: 20, paddingRight: -20, paddingBottom: 0, width: nil, height: 45)
        
        
        confirmPasswordTextField.anchor(top: passwordTextField.bottomAnchor, left: view.leadingAnchor, right: view.trailingAnchor, bottom: nil, paddingTop: 20, paddingLeft: 20, paddingRight: -20, paddingBottom: 0, width: nil, height: 45)
        
        
        resetButton.anchor(top: confirmPasswordTextField.bottomAnchor, left: view.leadingAnchor, right: view.trailingAnchor, bottom: nil, paddingTop: 20, paddingLeft: 20, paddingRight: -20, paddingBottom: 0, width: nil, height: 45)
        
        
        
    }
    @objc func backButtonTapped() {
        print("Back Button Tapped")
        
        if let navController = self.navigationController, navController.viewControllers.count > 1 {
            navController.popViewController(animated: true)
        } else {
            let alertController = UIAlertController(title: "Failed", message: "Failed to reset password.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default) { _ in
                self.dismiss(animated: true) {
                   
                }
            }
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func fetchActiveTabBarController() -> UITabBarController? {
        if #available(iOS 13.0, *) {
            let activeScene = UIApplication.shared.connectedScenes.first { scene in
                return scene.activationState == .foregroundActive
            }
            if let windowScene = activeScene as? UIWindowScene {
                for window in windowScene.windows {
                    if let tabBarController = window.rootViewController as? UITabBarController {
                        return tabBarController
                    }
                }
            }
        } else {
            // Fallback for earlier versions
            if let tabBarController = UIApplication.shared.keyWindow?.rootViewController as? UITabBarController {
                return tabBarController
            }
        }
        return nil
    }
    
    @objc func didTapReset(){
        guard let password = self.passwordTextField.text, !password.isEmpty else {
            AlertManager.showInvalidPasswordAlert(on: self)
            return
        }
        guard let repeatPassword = self.confirmPasswordTextField.text, !repeatPassword.isEmpty else {
            AlertManager.showInvalidPasswordAlert(on: self)
            return
        }
        
        guard password == repeatPassword else {
            AlertManager.showPasswordNotMatch(on: self)
            return
        }
        
        Service.shared.resetPassword(userId, token, password, expecting:  ApiResponse<[String: String]>.self) {[weak self] result in
            
            guard let self = self else {return}
            
            switch result{
            case .success(let response):
                let success =  response.status
            
                DispatchQueue.main.async {
                    if success == "success"{
                        let alert = UIAlertController(title: "Password Resetted", message: response.message, preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                            let loginViewController = AuthViewContoller()
                            self.navigationController?.pushViewController(loginViewController, animated: true)
                        }))
                        self.present(alert, animated: true, completion: nil)
                                        
                                   
                    }else {
                        //Show alert for a few second and move to controller
                        let alert = UIAlertController(title: "Error", message: response.message, preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                            // Instantiate the login view controller
                            let loginViewController = AuthViewContoller() // Replace this with the actual initialization of your login
                            self.navigationController?.pushViewController(loginViewController, animated: true)
                        }))
                        self.present(alert, animated: true, completion: nil)
                        
                    }
                    
                }
                
            case .failure(let error):
                ErrorManager.handleServiceError(error, on: self)
            }
        }

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

}
