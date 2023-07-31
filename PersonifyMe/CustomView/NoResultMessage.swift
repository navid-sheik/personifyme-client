//
//  NoResultMessage.swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 31/07/2023.
//

import Foundation
import UIKit

class NoResultMessage : UIView {
    
    let noResultTitleMain  : UILabel =  {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .darkGray
        label.textAlignment = .center
        label.text = "No result"
        return label
    }()
    
    let noResultMessageMain  : UILabel =  {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .darkGray
        label.textAlignment = .center
        label.text = " We didn't find any recipe for your search"
        return label
    }()
    
    let noResultImage : UIImageView = {
        let imageView =  UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image =  UIImage(named: "noResults")
        return imageView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //backgroundColor = .gray
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setUpViews(){
        addSubview(noResultImage)
        noResultImage.anchor(top: nil, left: nil, right: nil, bottom: nil, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 150, height: 150)
        noResultImage.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -50).isActive = true
        noResultImage.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        addSubview(noResultTitleMain)
        noResultTitleMain.anchor(top: noResultImage.bottomAnchor, left: leadingAnchor, right: trailingAnchor, bottom: nil, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: nil, height: nil)
        addSubview(noResultMessageMain)
        noResultMessageMain.anchor(top: noResultTitleMain.bottomAnchor, left: leadingAnchor, right: trailingAnchor, bottom: nil, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: nil, height: nil)
    }
    
}

