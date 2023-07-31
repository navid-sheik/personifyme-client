//
//  LoginController.swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 26/07/2023.
//

import Foundation
import UIKit


class LoginViewController : UIViewController{
    
    // MARK: - Variables
//    private let viewMOdel = LoginViewModel()
    
    
    private let headerView = AuthHeaderView()
    
    
    private let emailTextField : CustomTextField = {
        let textField = CustomTextField(fieldType: .email)
        textField.placeholder = "Email"
        return textField
    }()
    
    private let passwordTextField : CustomTextField = {
        let textField = CustomTextField(fieldType: .password)
        textField.placeholder = "Password"
        return textField
    }()
    
    
    private let loginButton : CustomButton = {
        let button = CustomButton(title: "Login", hasBackground: true, fontType: .medium)
        button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let forgetPasswordLabel : UILabel = {
        let label = UILabel()
        label.text = "Forget Password?"
        label.textColor = .systemBlue
        label.textAlignment = .center
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 16)
        label.isUserInteractionEnabled = true
   
   
        return label
    }()
    
    private let signUpLabel : UILabel = {
        let label = UILabel()
        let attributedString1 = NSAttributedString(string: "Don't have an account? ", attributes: [NSAttributedString.Key.foregroundColor : UIColor.black , NSAttributedString.Key.font: UIFont.systemFont(ofSize: UIFont.systemFontSize, weight: .light)])

        let attributedString2 = NSAttributedString(string: "Sign Up", attributes: [NSAttributedString.Key.foregroundColor : UIColor.systemBlue, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: UIFont.systemFontSize)])

        let combinedAttributedString = NSMutableAttributedString()
        combinedAttributedString.append(attributedString1)
        combinedAttributedString.append(attributedString2)
        label.attributedText = combinedAttributedString
        label.isUserInteractionEnabled = true
        
        
    
        label.textAlignment = .center
       
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 16)
        return label
    }()
    
    
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "DONE", style: .done, target: self, action: nil)
        view.backgroundColor =  .systemBackground
        
        
        self.setUpViews()
    
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
      
        
       
    
    }
    
    
    private func setUpViews (){
        view.addSubview(headerView)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)
        view.addSubview(forgetPasswordLabel)
        view.addSubview(signUpLabel)
        
        
        
        
        
        
        
        
        
        
        
        
      
      
        headerView.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        forgetPasswordLabel.translatesAutoresizingMaskIntoConstraints = false
        signUpLabel.translatesAutoresizingMaskIntoConstraints = false
        forgetPasswordLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(forgetPasswordTapped)))
 
        signUpLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(signUpTapped(_:))))
        
        
        
        
        
        
        
        
        
        
        
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor, constant: 0),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            headerView.heightAnchor.constraint(equalToConstant: 270),
            
            
            emailTextField.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 20),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            emailTextField.heightAnchor.constraint(equalToConstant: 50),
            
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            loginButton.heightAnchor.constraint(equalToConstant: 50),
            
            forgetPasswordLabel.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 20),
            forgetPasswordLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            forgetPasswordLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            forgetPasswordLabel.heightAnchor.constraint(equalToConstant: 50),
            
            signUpLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            signUpLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            signUpLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            signUpLabel.heightAnchor.constraint(equalToConstant: 50)
            
            

            
        
        ])
    
        
        
        
    }
    
    @objc func loginButtonTapped(){
        print("Login Button Tapped")

        // get the value from the textfield
    
        guard let email = emailTextField.text, !email.isEmpty else {
            AlertManager.showInvalidEmailAlert(on: self)
            return
        }
        guard let password = passwordTextField.text, !password.isEmpty else {
            AlertManager.showInvalidPasswordAlert(on: self)
            return
        }

        //Craate data object to send to server
        let data = ["email": email, "password": password]

        Service.shared.login(data, expecting: ApiResponse<AuthResponse2>.self) { [weak self] result in
            guard let strongSelf = self else { return }
            
            switch result{
                case .success(let result):
                    print(result)
                    //Check for user data
                    guard let user_data = result.data else {return}
                 
                    //Check verification of the user
                    let verifed   =  user_data.verified
                    //Show verified controller if not verifed
                    DispatchQueue.main.async {
                        if verifed {
                            AuthManager.setUserDefaults(token: user_data.token, refresh_token: user_data.refreshToken, verified:  user_data.verified)
                            strongSelf.dismiss(animated: true, completion: nil)
                        }else{
                            let vc = VerifyEmailViewController(email: email)
                            strongSelf.navigationController?.pushViewController(vc, animated: true)
                            return
                        }
                    }
                    
                case .failure(let error):
                    ErrorManager.handleServiceError(error, on: self)
                    
                }
        }
    }
    
    @objc func forgetPasswordTapped(_ sender : UITapGestureRecognizer ){
        print("Forget Password Tapped")
        let vc = ForgotPasswordController()
        self.navigationController?.pushViewController(vc, animated: true)
        
        
    
    }
    
    @objc func signUpTapped(_ sender : UITapGestureRecognizer){
        print("Sign Up Tapped")
        let vc = RegisterController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)

    }
    

}
