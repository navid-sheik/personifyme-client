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
        
        resetPasswordButton.addTarget(self, action: #selector(resetPasswordButtonTapped), for: .touchUpInside)
        
        
        
        headerView.anchor( top: view.layoutMarginsGuide.topAnchor, left: view.leadingAnchor, right: view.trailingAnchor, bottom: nil, paddingTop: 0, paddingLeft: 0,paddingRight: 0, paddingBottom: 0, width: nil, height: 220)
        
        
        emailTextField.anchor(top: headerView.bottomAnchor, left: view.leadingAnchor, right: view.trailingAnchor, bottom: nil, paddingTop: 40, paddingLeft: 20, paddingRight: -20, paddingBottom: 0, width: nil, height: 60)
        
        
        resetPasswordButton.anchor(top: emailTextField.bottomAnchor, left: view.leadingAnchor, right: view.trailingAnchor, bottom: nil, paddingTop: 40, paddingLeft: 20, paddingRight: -20, paddingBottom: 0, width: nil, height: 60)
        
        
    
    }
    
    @objc private func resetPasswordButtonTapped(){
        //TODO: Validate Email
        
        guard let email =  self.emailTextField.text, !email.isEmpty  else {
            return
        
        }
        
        Service.shared.sendPasswordResetLink(email, expecting: SuccessResponse.self) { [weak self] result in
                
                guard let self = self else {return}
                
                switch result{
                    case .success(let result):
                    let success = result.success
                    
                    if success{
                        print("Password Reset Link Sent")
                    }
                       
                    
                    case .failure(let error):
                        print(error)
                        
                }
        }
        print("Reset Password Button Tapped")
    
    }
    


}
