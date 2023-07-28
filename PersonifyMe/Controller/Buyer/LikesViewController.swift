//
//  LikesViewController.swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 27/07/2023.
//

import Foundation
import UIKit



class LikesViewController : RestrictedController{
    
    //MARK: Properties
    
    //MARK: Life Cycle
    
    
    
    
    let label : UILabel = {
        let label = UILabel()
        label.text = "Likes"
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    
    

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Likes"
        setUpView()
        
        
    }
    
    
    
    //MARK: Methods
    
  
    private func setUpView(){
        view.addSubview(label)
        
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        label.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
    
        
    }
    
    
    //MARK: Selectors
    
    
    //MARK: Helpers
}

