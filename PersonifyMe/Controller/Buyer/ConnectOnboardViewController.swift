//
//  ConnectOnboardViewController.swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 29/07/2023.
//

import UIKit
import SafariServices

let BackendAPIBaseURL: String = "http://localhost:4050/payments/onBoarding" // Set to the URL of your backend server

class ConnectOnboardViewController: UIViewController {

    // ...

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        let connectWithStripeButton = UIButton(type: .system)
        connectWithStripeButton.setTitle("Connect with Stripe", for: .normal)
        connectWithStripeButton.addTarget(self, action: #selector(didSelectConnectWithStripe), for: .touchUpInside)
        view.addSubview(connectWithStripeButton)

        connectWithStripeButton.translatesAutoresizingMaskIntoConstraints = false
        connectWithStripeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        connectWithStripeButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    
    }

    @objc
    func didSelectConnectWithStripe() {
        print("This is the didSelectConnectWithStripe function")
        if let url = URL(string: BackendAPIBaseURL) {
        
          var request = URLRequest(url: url)
          request.httpMethod = "POST"
            
            
          
          let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
              
              guard let data = data,
                  let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String : Any],
                  let accountURLString = json["url"] as? String,
                    
                  let accountURL = URL(string: accountURLString) else {
                        print("Failed to retrieve account link URL")
                  
                        print("This is the error \(error)")
                        
                        
                        
                        // Handle error
                        return
                
              }
              print("This is the error \(accountURLString)")
              
              
              

              let safariViewController = SFSafariViewController(url: accountURL)
              safariViewController.delegate = self

              DispatchQueue.main.async {
                  self.present(safariViewController, animated: true, completion: nil)
              }
          }
            
            task.resume()
        }
        
        
    }

    
}

extension ConnectOnboardViewController: SFSafariViewControllerDelegate {
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        // the user may have closed the SFSafariViewController instance before a redirect
        // occurred. Sync with your backend to confirm the correct state
    }
}
