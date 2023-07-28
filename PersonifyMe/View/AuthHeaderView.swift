//
//  AuthHeaderView.swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 26/07/2023.
//

import Foundation

import UIKit


class AuthHeaderView : UIView {
    
    private let title : String
    private let subTitle : String
    
    
    
    //MARK: UI COMPONENTS
    
    private let imageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    public let titleLabel : UILabel = {
        let label = UILabel()
        label.text = "Sign Into your account"
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 30)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    private let  subTitleLabel : UILabel =  {
        let label = UILabel()
        label.text = "Create your own avatar"
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 20)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    
    init(title : String , subTitle : String) {
        self.title = title
        self.subTitle = subTitle
        super.init(frame: .zero)
        setUpViews()
    }
    
    init() {
        self.title = ""
        self.subTitle = ""
        super.init(frame: .zero)
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    private func setUpViews (){
        addSubview(imageView)
        addSubview(titleLabel)
//        addSubview(subTitleLabel)
        
     
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 30),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 100),
            imageView.widthAnchor.constraint(equalToConstant: 100),
           
            
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
//            
//            subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
//            subTitleLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
            
        ])
    }
    
    
    
    
    
    
        
        
        
    
}
