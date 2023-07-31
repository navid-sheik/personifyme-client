//
//  VerifyEmailViewController.swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 27/07/2023.
//

import Foundation
import UIKit



class VerifyEmailViewController : UIViewController{
    
    
    private let email : String
    
    
    private let headerView  =  AuthHeaderView(title: "Verify Your Account ", subTitle: "")
    
    private let notificationLabel : UILabel =  {
        let label = UILabel()
        label.text = "Please request a verification code to your email!"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    
    
    
    private let verifyButton : CustomButton = {
        let button = CustomButton(title: "Continue", hasBackground: true, fontType: .medium)
        button.isEnabled = false
        button.addTarget(self, action: #selector(continueButtonTapped), for: .touchUpInside)
        return button
    }()
    
    
    
    
    private let verifyCodeTextField : CustomTextField = {
        let textField  =  CustomTextField(fieldType: .custom, "Enter Verification Code")
        return textField
    }()
    
    
    private let sendVerificationCodeButton : CustomButton = {
        let button = CustomButton(title: "Send Verification Code", hasBackground: false, fontType: .medium)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemBlue.cgColor
        button.layer.masksToBounds = true
        button.setTitleColor(.systemBlue, for: .normal)
//        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.addTarget(self, action: #selector(sendVerificationCodeTapped), for: .touchUpInside)
        return button
    }()
    
    
   
    
    
    
    
    init(email: String) {
        self.email = email
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    
    func setupViews(){
        self.view.backgroundColor = .systemBackground
        headerView.titleLabel.text = "Verify Your Account"
        self.view.addSubview(headerView)
        self.view.addSubview(notificationLabel)
        self.view.addSubview(verifyCodeTextField)
        self.view.addSubview(sendVerificationCodeButton)
        self.view.addSubview(verifyButton)
//        self.view.addSubview(resendLabel)
        
        headerView.anchor( top: view.layoutMarginsGuide.topAnchor, left: view.leadingAnchor, right: view.trailingAnchor, bottom: nil, paddingTop: 0, paddingLeft: 20,paddingRight: -20, paddingBottom: 0, width: nil, height: 200)
        
        
        notificationLabel.anchor( top: headerView.bottomAnchor, left: view.leadingAnchor, right: view.trailingAnchor, bottom: nil, paddingTop: 10, paddingLeft: 20,paddingRight: -20, paddingBottom: 0, width: nil, height: 50)
        
        verifyCodeTextField.anchor( top: notificationLabel.bottomAnchor, left: view.leadingAnchor, right: view.trailingAnchor, bottom: nil, paddingTop: 10, paddingLeft: 20,paddingRight: -20, paddingBottom: 0, width: nil, height: 50)
        
        sendVerificationCodeButton.anchor( top: verifyCodeTextField.bottomAnchor, left: view.leadingAnchor, right: view.trailingAnchor, bottom: nil, paddingTop: 10, paddingLeft: 20,paddingRight: -20, paddingBottom: 0, width: nil, height: 50)
        
        
        
        verifyButton.anchor( top: sendVerificationCodeButton.bottomAnchor, left: view.leadingAnchor, right: view.trailingAnchor, bottom: nil, paddingTop: 10,paddingLeft: 20,paddingRight: -20,paddingBottom: 0, width: nil, height: 50)
        
//        resendLabel.anchor( top: verifyButton.bottomAnchor, left: view.leadingAnchor, right: view.trailingAnchor, bottom: nil, paddingTop: 10, paddingLeft: 20,paddingRight: -20,paddingBottom: 0, width: nil, height: 50)
//
        
        
        
        
        
    }
    
    
    @objc func continueButtonTapped(){
        guard let verificationCode = verifyCodeTextField.text else {
            print("Missing verification code")
            return
        }
        Service.shared.verifyEmail(self.email, verificationCode, expecting: ApiResponse<AuthResponse2>.self) { [weak self] result in
            guard let self = self else {return}
            switch result{
            case .success(let result):
                guard let user = result.data else {
                    return
                }
                let verifed = user.verified
                if verifed{
                    DispatchQueue.main.async {
                        AuthManager.setUserDefaults(token: user.token, refresh_token: user.refreshToken, verified: user.verified)
                        
                        self.dismiss(animated: true)
                    }
                }
            case .failure(let error):
                ErrorManager.handleServiceError(error, on: self)
            }
        
        }
        
        
    }
    
    @objc func sendVerificationCodeTapped(){
        print("send verification code tapped")
        
        Service.shared.sendVerificationLink(self.email, expecting: ApiResponse<[String : String]>.self) {  [weak self] result in
            guard let self = self else {return}
            switch result{
            case .success(let result):
                let status = result.status
                if status  == "success"{
                   DispatchQueue.main.async {
                       self.sendVerificationCodeButton.setTitle("Sent Email !", for: .normal)
                       self.notificationLabel.text = "We've sent a notification to your email: \(self.email)"
                       self.verifyButton.isEnabled = true
                    }
                }
            case .failure(let error):
                ErrorManager.handleServiceError(error, on: self)
            }
        
        }
        
    }
    
    
    
    

    
}
