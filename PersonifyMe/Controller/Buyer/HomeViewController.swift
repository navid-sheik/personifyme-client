//
//  HomeController.swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 26/07/2023.
//

import UIKit

class HomeViewController: UIViewController {
    
    
    private let spinner  =  UIActivityIndicatorView(style: .large)
    private let mylabel  : UILabel = {
        let label = UILabel()
        label.text = "Loading"
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 30)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor  =  .purple
        
//        UserDefaults.standard.set("", forKey: "token")
        //        UserDefaults.standard.set(nil, forKey: "token")
        //        UserDefaults.standard.set(nil, forKey: "verified")
        print(UserDefaults.standard.string(forKey: "token"))
        print(UserDefaults.standard.string(forKey: "refresh_token"))
        self.setUpView()
        let url = URL(string: "personifyme:navid")
        
        
        UIApplication.shared.open(url!) { (result) in
            if result {
                // The URL was delivered successfully!
            }
        }
        
        
        
        // Do any additional setup after loading the view.
    }
    
    
    
    private func setUpView(){
        self.view.backgroundColor =  .systemBackground
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout", style: .done, target: self, action: #selector(didTapLogout))
        
        self.view.addSubview(mylabel)
        
        
        mylabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        mylabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive =  true
        
        
        
        
    }
    
    private func networkTest (){
        let data  = [    "email" : "navidsheikh2020@gmail.com",
                         "name" : "navid sheikh",
                         "username": "navid_l",
                         "password" :  "larrysama"
        ]
        let jsonData  =  try? JSONSerialization.data(withJSONObject: data)
        let request  =  Request(endpoint: .base, pathComponents: ["signup"])
            .add(headerField: "Content-Type", value: "application/json")
            .set(body: jsonData)
            .set(method: .POST)
            .build()
        
        print(request)
        
        
        Service.shared.execute(request, expecting: AuthResponse.self) { [weak self] result in
            guard let strongSelf = self else {
                return
            }
            
            switch result{
            case .success(let daata):
                print(daata)
                
            case .failure(let failure):
                print(failure)
            }
            
            
        }
        
    }
    
    
    @objc private func didTapLogout(){
        //        let vc = LoginViewController()
        //        vc.modalPresentationStyle = .fullScreen
        //        self.present(vc, animated: true, completion: nil)
        
        print("logout")
        
        Service.shared.logout(expecting: ApiResponse<String>.self) { [weak self] result in
            
            switch result{
            case .success(let _):
                print("Success in logout")
                AuthManager.clearUserDefaults()
                AlertManager.showLogoutAlert(on: self!)
                
                
                
            case .failure(let error):
               ErrorManager.handleServiceError(error, on: self)
            }
            
        }
    }
    
}

