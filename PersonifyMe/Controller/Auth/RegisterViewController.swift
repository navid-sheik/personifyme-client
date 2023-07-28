//
//  RegisterController.swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 26/07/2023.
//

import Foundation
import UIKit


class RegisterController :  UIViewController {
    
    
    // MARK: - Variables
    private let headerView = AuthHeaderView()
    
    private let nameTextField : CustomTextField = {
        let textField = CustomTextField(fieldType: .name)
       
        return textField
    }()
    
    
    private let emailTextField : CustomTextField = {
        let textField = CustomTextField(fieldType: .email)
        
        return textField
    }()
    
    private let usernameTextField : CustomTextField = {
        let textField = CustomTextField(fieldType: .username)
        return textField
    }()
    
    
    
    private let passwordTextField : CustomTextField = {
        let textField = CustomTextField(fieldType: .password)
        return textField
    }()
    
    
    private let passwordTextField2 : CustomTextField = {
        let textField = CustomTextField(fieldType: .password)
        textField.placeholder = "Repeat Password"
        return textField
    }()
    
    private let signUp : CustomButton = {
        let button = CustomButton(title: "Create Account", hasBackground: true, fontType: .medium)
        button.addTarget(self, action: #selector(signUpButton), for: .touchUpInside)
        return button
    }()
    
    private let termsLabel : UITextView = {
        let tv = UITextView()
        
        let attributedString = NSMutableAttributedString(string: "By registering, I conf irm I accept PersonifyMe’s Terms & Conditions,  have read the Privacy Policy,  and  at least 18 years old.")
        attributedString.addAttribute(.link, value: "terms://termsAndConditions", range: (attributedString.string as NSString).range(of: "Terms & Conditions") )
        attributedString.addAttribute(.link, value: "privacy://privacyPolicy", range: (attributedString.string as NSString).range(of: "Privacy Policy") )
        
        tv.linkTextAttributes =  [.foregroundColor :  UIColor.systemBlue]
        tv.backgroundColor =  .clear
        
        tv.attributedText =  attributedString
        
        
        
 
        tv.textColor = .label
        tv.delaysContentTouches = false
        tv.textAlignment = .center
        tv.font = UIFont.systemFont(ofSize: 14)
        tv.isUserInteractionEnabled = true

   
   
        return tv
    }()
    
    private let loginLabel : UILabel = {
        let label = UILabel()
        let attributedString1 = NSAttributedString(string: "Already have an account? ", attributes: [NSAttributedString.Key.foregroundColor : UIColor.black , NSAttributedString.Key.font: UIFont.systemFont(ofSize: UIFont.systemFontSize, weight: .light)])

        let attributedString2 = NSAttributedString(string: "Log in", attributes: [NSAttributedString.Key.foregroundColor : UIColor.systemBlue, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: UIFont.systemFontSize)])

        let combinedAttributedString = NSMutableAttributedString()
        combinedAttributedString.append(attributedString1)
        combinedAttributedString.append(attributedString2)
        label.attributedText = combinedAttributedString
        label.isUserInteractionEnabled = true
        
        
    
        label.textAlignment = .center
       
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        view.backgroundColor = .systemBackground
        setUpViews()
    
    }
    
    
    private func setUpViews(){
        headerView.titleLabel.text =  "Create Account "
        loginLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(loginLabelTapped)))
        
        termsLabel.delegate = self
        
        
        
        
        view.addSubview(headerView)
        view.addSubview(nameTextField)
        view.addSubview(emailTextField)
        view.addSubview(usernameTextField)
        view.addSubview(passwordTextField)
        view.addSubview(passwordTextField2)
        view.addSubview(termsLabel)
        view.addSubview(signUp)
        view.addSubview(loginLabel)
        
        
//
        
        headerView.anchor( top: view.layoutMarginsGuide.topAnchor, left: view.leadingAnchor, right: view.trailingAnchor, bottom: nil, paddingTop: 0, paddingLeft: 0,paddingRight: 0, paddingBottom: 0, width: nil, height: 220)
        
        nameTextField.anchor(top: headerView.bottomAnchor, left: view.leadingAnchor, right: view.trailingAnchor, bottom: nil, paddingTop: 20, paddingLeft: 20, paddingRight: -20, paddingBottom: 0, width: nil, height: 50)
        
        emailTextField.anchor(top: nameTextField.bottomAnchor, left: view.leadingAnchor, right: view.trailingAnchor, bottom: nil, paddingTop: 20, paddingLeft: 20, paddingRight: -20, paddingBottom: 0, width: nil, height: 50)
        
        usernameTextField.anchor(top: emailTextField.bottomAnchor, left: view.leadingAnchor, right: view.trailingAnchor, bottom: nil, paddingTop: 20, paddingLeft: 20, paddingRight: -20, paddingBottom: 0, width: nil, height: 50)
        
        passwordTextField.anchor(top: usernameTextField.bottomAnchor, left: view.leadingAnchor, right: view.trailingAnchor, bottom: nil, paddingTop: 20, paddingLeft: 20, paddingRight: -20, paddingBottom: 0, width: nil, height: 50)
        
        passwordTextField2.anchor(top: passwordTextField.bottomAnchor, left: view.leadingAnchor, right: view.trailingAnchor, bottom: nil, paddingTop: 20, paddingLeft: 20, paddingRight: -20, paddingBottom: 0, width: nil, height: 50)
        
        termsLabel.anchor(top: passwordTextField2.bottomAnchor, left: view.leadingAnchor, right: view.trailingAnchor, bottom: nil, paddingTop: 8, paddingLeft: 20, paddingRight: -20, paddingBottom: 0, width: nil, height: 70)
        
        signUp.anchor(top: termsLabel.bottomAnchor, left: view.leadingAnchor, right: view.trailingAnchor, bottom: nil, paddingTop: 10, paddingLeft: 20, paddingRight: -20, paddingBottom: 0, width: nil, height: 50)
        
        
        
        loginLabel.anchor(top: signUp.bottomAnchor, left: view.leadingAnchor, right: view.trailingAnchor, bottom: nil, paddingTop: 10, paddingLeft: 20, paddingRight: -20, paddingBottom: -20, width: nil, height: nil)
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
   
        
        
        
        
        
        
    }
    
    
//    @objc private func didTapTerms (){
//        print("Terms tapped")
//
//        let webVC = WebViewController(with: "https://www.google.com")
//
//        let nav =  UINavigationController(rootViewController: webVC)
//        self.present(nav, animated: true, completion: nil)
//    }
//
    
    
    
    @objc private func signUpButton(){
        print("Sign Up button tapped")
//        let vc = HomeViewController()
//        vc.modalPresentationStyle = .fullScreen
//        self.present(vc, animated: true, completion: nil)
//
        
        
        // get the value from the textfield
    
        guard let email = emailTextField.text, !email.isEmpty else {
            AlertManager.showInvalidEmailAlert(on: self)
            return
        }
        
        guard let username = usernameTextField.text, !username.isEmpty else {
            AlertManager.showInvalidUsernameAlert(on: self)
            return
        }
        
        guard let fullname = nameTextField.text, !fullname.isEmpty else {
            AlertManager.showInvalidFullNameAlert(on: self)
            return
        }
        guard let password = passwordTextField.text, !password.isEmpty else {
            AlertManager.showInvalidPasswordAlert(on: self)
            return
        }
        guard let passowrd2 = passwordTextField2.text, !passowrd2.isEmpty else {
            AlertManager.showInvalidPasswordAlert(on: self)
            return
        }
        
        guard passowrd2 == password else {
            AlertManager.showPasswordNotMatch(on: self)
            return
        }
        
        
        

        
        //Craate data object to send to server
        let data = ["email": email, "password": password, "username" :  username, "name" :  fullname]

        //Send the data to server
        let jsonData  =  try? JSONSerialization.data(withJSONObject: data)

        //Use the url request builder
        let request  =  Request(endpoint: .base, pathComponents: ["signup"])
            .add(headerField: "Content-Type", value: "application/json")
            .set(body: jsonData)
            .set(method: .POST)
            .build()

        //Send the request
        Service.shared.execute(request, expecting: AuthResponse.self) { [weak self] result in
            guard let strongSelf = self else { return }



            switch result{
                case .success(let data):
                   
                
                    UserDefaults.standard.set(data.token, forKey: "token")
                    UserDefaults.standard.set(data.token, forKey: "refresh_token")
                    UserDefaults.standard.set(data.verified, forKey: "verified")
                
                    let verifed   = data.verified
                    print(verifed)
                    DispatchQueue.main.async {
                        
                        if verifed {
                            
                            let vc = HomeViewController()
                            let nav = UINavigationController(rootViewController: vc)
                            nav.modalPresentationStyle = .fullScreen
                            strongSelf.present(vc, animated: true, completion: nil)
                            
                            
                        }else{
                            let vc = VerifyEmailViewController(email: email)
                            strongSelf.navigationController?.pushViewController(vc, animated: true)
                            
                            return
                            
                            
                        }
                    }
                    

            case .failure(let error):
                print(error)
                AlertManager.showLoginErrorAlert(on: strongSelf)
                
            }


        }

        
    
    }
    
    @objc private func loginLabelTapped(){
        print("Login Label Tapped")
        self.navigationController?.popViewController(animated: true)
    }
    
}


extension RegisterController : UITextViewDelegate{
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        
        if URL.scheme == "terms"{
            self.showWebViewerController(with: "https://www.google.com")
       
        }else if URL.scheme == "privacy"{
            self.showWebViewerController(with: "https://www.facebook.com")
        }
        
        
        return true
    }
    
    private func showWebViewerController (with urlString :  String){
        let webVC = WebViewController(with: urlString)
        let nav = UINavigationController(rootViewController: webVC)
        self.present(nav, animated: true, completion: nil)
        
    }
    
    func textViewDidChangeSelection(_ textView: UITextView) {
        textView.delegate = nil
        textView.selectedTextRange =  nil
        textView.delegate =  self
    }
}
