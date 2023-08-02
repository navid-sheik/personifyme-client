//
//  OnBoardingLinkController.swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 30/07/2023.
//

//
//  PersonifyMe
//
//  Created by Navid Sheikh on 27/07/2023.
//

import Foundation


import UIKit
import SafariServices

class OnBoardingLinkViewController: RestrictedController {
    
    // MARK: - Components
    // Here you add all components
    

    
    
    var hasStartedOnboarding : Bool
    
    let titleLabel : UILabel = {
        let label = UILabel()
        label.text = "Join Seller Programme"
        label.font =  UIFont.boldSystemFont(ofSize: 28)
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    let onBoardCollectionView : OnBoardingCollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collection = OnBoardingCollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    
    
    let becomeSellerButton : CustomButton = {
        let button  = CustomButton(title: "Start Bank Verification",hasBackground: true  ,fontType: .medium)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleBecomeSeller), for: .touchUpInside)
        return button
    }()
    
    
    
    // MARK: - Properties
    // All properties and variables you need in your ViewController
    init(hasStartedOnboarding : Bool = false){
        self.hasStartedOnboarding = hasStartedOnboarding
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        becomeSellerButton.setTitle(hasStartedOnboarding ?  "Continue Verification" :  "Start Verification", for: .normal)
        setupUI()
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        // Set up all UI elements here
//        view.addSubview(onBoardCollectionView)
        view.addSubview(becomeSellerButton)
        
        (becomeSellerButton).anchor( top: view.layoutMarginsGuide.topAnchor, left: view.leadingAnchor, right: view.trailingAnchor, bottom: nil, paddingTop: 0, paddingLeft: 0,paddingRight: 0, paddingBottom: 0, width: nil, height: 50)
        
    }
    
    
    // MARK: - IBActions
    // Here you add all your @IBActions (functions called by UI interactions like button taps)
    @objc func handleBecomeSeller() {
        print("Handle Become Seller")
        Service.shared.sendVerificationStripeLink(expecting: ApiResponse<String>.self) { [weak self]  result in
            guard let self = self else { return }
            switch result{
                
            
            case .success(let response):
                print("Success")
                print(response)
                let success  = response.status
               
                
                if (success ==  "success"){
                    DispatchQueue.main.async {
                        guard let stripeLink = response.data else { return }
                        
                        
                        guard let url = URL(string: stripeLink) else { return }
                        
                        let safariViewController = SFSafariViewController(url: url)
                        safariViewController.delegate = self
                        let navigationController = UINavigationController(rootViewController: safariViewController)
                        

                        self.present(navigationController, animated: true)
                    }
                    
                }else {
                    AlertManager.showUnknownFetchingUserError(on: self)
                }
              
            case .failure(let error):
                print("Error")
                print(error)
            }
        }
    }
    
    // MARK: - Navigation
    // Segue preparations and related stuff
    
    // MARK: - Private methods
    // All other functions that you use within the ViewController
}


extension OnBoardingLinkViewController: SFSafariViewControllerDelegate {
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        // the user may have closed the SFSafariViewController instance before a redirect
        // occurred. Sync with your backend to confirm the correct state
        print("Finished")
       
        
        navigateToController()
     
    
              
        
    }
    
   
    
    func navigateToController(){
        let dashBoardVC  =  DashboardViewController()
        self.navigationController?.pushViewController(dashBoardVC, animated: true)
        
        
    }
    
}
