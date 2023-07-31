//
//  DashboardViewController.swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 27/07/2023.
//

//
//  PersonifyMe
//
//  Created by Navid Sheikh on 27/07/2023.
//

import Foundation


import UIKit

class DashboardViewController : RestrictedController {
    
    var stripeRequirements : StripeStatusResponse?{
        didSet{
            DispatchQueue.main.async {[weak self] in
                if let verifed =  self?.stripeRequirements?.isVerified {
                    self?.label.text =   verifed ? "Verified"  : "Pending"
                }
              
            }
           
            
        }
    }
    
    // MARK: - Components
    // Here you add all components
    
    var label : UILabel  =  {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .black
        return label
    }()
    
    var sellerMenuCollection   :   SellerMenuCollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collection = SellerMenuCollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    
    var verificationStatus  =  VerificationStatusView ()
    

    
    
    // MARK: - Properties
    // All properties and variables you need in your ViewController
    
    // MARK: - Lifecycle methods
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//
//    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.checkStripeStatus()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Dashboard"
        view.backgroundColor = .systemBackground
        
        setupUI()
    }
    
    
    
    // MARK: - UI Setup
    private func setupUI() {
        // Set up all UI elements here
        self.navigationItem.hidesBackButton = true
        view.addSubview(verificationStatus)
        
//        view.addSubview(label)
        view.addSubview(sellerMenuCollection)
        
      
        sellerMenuCollection.anchor( top: view.layoutMarginsGuide.topAnchor, left: view.leadingAnchor, right: view.trailingAnchor, bottom: nil, paddingTop: 0, paddingLeft: 0,paddingRight: 0, paddingBottom: 0, width: nil, height: nil)
        //For setting the  collection view resizable, set the bottom anchor less or equal
        sellerMenuCollection.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        (verificationStatus).anchor( top: sellerMenuCollection.bottomAnchor, left: view.leadingAnchor, right: view.trailingAnchor, bottom: nil, paddingTop: 0, paddingLeft: 10,paddingRight: -10, paddingBottom: 0, width: nil, height: 60)
        
        
        
    }
   
    
    
    
    // MARK: - IBActions
    // Here you add all your @IBActions (functions called by UI interactions like button taps)
    
    // MARK: - Navigation
    // Segue preparations and related stuff
    
    // MARK: - Private methods
    // All other functions that you use within the ViewController
    
    func checkStripeStatus (){
        Service.shared.statusStripeAccount(expecting: ApiResponse<StripeStatusResponse>.self) { [weak self ] result in
            guard let self =  self else {return}
            switch result{
                
            case .success(let response):
                let success  =  response.status
                guard let stripeData  =  response.data else {
                    print ("Not data available")
                    return
                }
                self.stripeRequirements = stripeData
                
                
                
            case .failure(let error):
                print(error)
                print("Error displaying for verification for verification")
            }
            
            
        }

        
    }
}

