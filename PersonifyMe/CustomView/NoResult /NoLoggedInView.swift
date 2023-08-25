//
//  NoLoggedIn.swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 23/08/2023.
//

import Foundation
import UIKit

protocol NoLoggedInViewDelegate :  class {
    func didTapSignIn()
}



class NoLoggedInView : UIView {
    
    
    weak var delegate : NoLoggedInViewDelegate?
    
    
    private var message : String
    
    let noResultTitleMain  : UILabel =  {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .darkGray
        label.textAlignment = .center
        label.text = "Please Sign In"
        return label
    }()
    
    let noResultMessageMain  : UILabel =  {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .darkGray
        label.textAlignment = .center
        label.text = ""
        return label
    }()
    
    let noResultImage : UIImageView = {
        let imageView =  UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image =  UIImage(systemName: "exclamationmark.square.fill")?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = DesignConstants.primaryColor
        return imageView
    }()
    
    let button : CustomButton = {
        let button = CustomButton(title: "Sign In", hasBackground: true, fontType: .medium)
        return button
    }()
    
    
    
    init(message : String) {
        self.message = message
        super.init(frame: .zero)
        self.noResultMessageMain.text = message
        button.addTarget(self, action: #selector(handleShowLogin), for: .touchUpInside)
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setUpViews(){
        backgroundColor = .systemBackground
        
        addSubview(noResultImage)
        noResultImage.anchor(top: nil, left: nil, right: nil, bottom: nil, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 150, height: 150)
        noResultImage.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -50).isActive = true
        noResultImage.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        addSubview(noResultTitleMain)
        noResultTitleMain.anchor(top: noResultImage.bottomAnchor, left: leadingAnchor, right: trailingAnchor, bottom: nil, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: nil, height: nil)
        addSubview(noResultMessageMain)
        noResultMessageMain.anchor(top: noResultTitleMain.bottomAnchor, left: leadingAnchor, right: trailingAnchor, bottom: nil, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: nil, height: nil)
        
        addSubview(button)
        
    
        button.anchor(top: noResultMessageMain.bottomAnchor, left: nil, right: nil, bottom: nil, paddingTop: 10, paddingLeft: 20, paddingRight: -20, paddingBottom: 0, width: 100, height: 40)
        button.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    @objc func handleShowLogin(){
        delegate?.didTapSignIn()
    }
    

}
