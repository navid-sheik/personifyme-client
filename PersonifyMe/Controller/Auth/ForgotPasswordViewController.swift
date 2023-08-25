//
//  ForgotPasswordController.swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 26/07/2023.
//

import UIKit

class ForgotPasswordController: UIViewController {
    
    private let headerView = AuthHeaderView(title: "Forget Password", subTitle: "Reset Your Password")
    
    
    private let emailTextField : CustomTextField = {
        let textField = CustomTextField(fieldType: .email)
        return textField
    }()
    
    
    private let resetPasswordButton : CustomButton = {
        let button = CustomButton(title: "Reset Password", hasBackground: true, fontType: .medium)
        return button
    }()
    
    private let backButton  :  UIButton =  {
        let button = UIButton()
        button.setImage(UIImage(systemName: "arrow.backward"), for: .normal)
        button.tintColor = DesignConstants.primaryColor

        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.isHidden = false
        
        
        
        self.setUpView()
    }
    
    private func setUpView(){
        self.view.addSubview(headerView)
        self.view.addSubview(emailTextField)
        self.view.addSubview(resetPasswordButton)
        self.view.addSubview(backButton)
        
        resetPasswordButton.addTarget(self, action: #selector(resetPasswordButtonTapped), for: .touchUpInside)
        
        backButton.anchor(top: self.view.safeAreaLayoutGuide.topAnchor, left: self.view.leadingAnchor, right: nil, bottom: nil, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 40, height: 40)
        
        
        
        let width  = self.view.frame.width * 0.8
        headerView.anchor( top: backButton.bottomAnchor, left: nil, right: nil, bottom: nil, paddingTop: 0, paddingLeft: 0,paddingRight: 0, paddingBottom: 0, width: width, height: 100)
        
        headerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        emailTextField.anchor(top: headerView.bottomAnchor, left: view.leadingAnchor, right: view.trailingAnchor, bottom: nil, paddingTop: 40, paddingLeft: 20, paddingRight: -20, paddingBottom: 0, width: nil, height: 50)
        
        
        resetPasswordButton.anchor(top: emailTextField.bottomAnchor, left: view.leadingAnchor, right: view.trailingAnchor, bottom: nil, paddingTop: 40, paddingLeft: 20, paddingRight: -20, paddingBottom: 0, width: nil, height: 45)
        
        
        
    }
    
    @objc func backButtonTapped(){
        print("Back Button Tapped")
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func resetPasswordButtonTapped(){
        //TODO: Validate Email
        print("Reset Password Button Tapped")
        guard let email =  self.emailTextField.text, !email.isEmpty  else {
            print("Email is empty")
            AlertManager.showInvalidEmailAlert(on: self)
            return
        }
        
        Service.shared.sendPasswordResetLink(email, expecting: ApiResponse<[String: String]>.self) { [weak self] result in
            guard let self = self else {return}
            switch result{
            case .success(let result):
                guard let user = result.data else {return}
                if result.status  == "success"{
                    AlertManager.showSendingPasswordReset(on: self)
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
