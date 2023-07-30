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
    
    // MARK: - Components
    // Here you add all components
    
    let label : UILabel  =  {
        let label = UILabel()
        label.text = "Verified"
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .black
        return label
    }()
    

    
    
    // MARK: - Properties
    // All properties and variables you need in your ViewController
    
    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Dashboard"
        view.backgroundColor = .systemBackground
        
        setupUI()
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        // Set up all UI elements here
        view.addSubview(label)
        
        (label).anchor( top: view.layoutMarginsGuide.topAnchor, left: view.leadingAnchor, right: view.trailingAnchor, bottom: nil, paddingTop: 0, paddingLeft: 0,paddingRight: 0, paddingBottom: 0, width: nil, height: 220)
        
        
    }
    
    
    // MARK: - IBActions
    // Here you add all your @IBActions (functions called by UI interactions like button taps)
    
    // MARK: - Navigation
    // Segue preparations and related stuff
    
    // MARK: - Private methods
    // All other functions that you use within the ViewController
}
