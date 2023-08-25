//
//  NoResultPage.swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 23/08/2023.
//

import Foundation
import UIKit

protocol NoResultViewDelegate: AnyObject {
    func didTapActionButton()
}
//
//class NoResultView: UIView {
//
//    // Delegate to handle user actions
//    weak var delegate: NoResultViewDelegate?
//
//    // Custom message to be displayed
//    private var customMessage: String
//
//    // MARK: UI Elements
//
//    private let titleLabel: UILabel = {
//        let label = UILabel()
//        label.font = UIFont.boldSystemFont(ofSize: 20)
//        label.textColor = .darkGray
//        label.textAlignment = .center
//        label.text = "No Results Found"
//        return label
//    }()
//
//    private let messageLabel: UILabel = {
//        let label = UILabel()
//        label.font = UIFont.systemFont(ofSize: 16)
//        label.textColor = .darkGray
//        label.textAlignment = .center
//        return label
//    }()
//
//    private let actionButton: UIButton = {
//        let button = UIButton()
//        button.setTitle("Try Again", for: .normal)
//        button.backgroundColor = .systemBlue
//        button.setTitleColor(.white, for: .normal)
//        return button
//    }()
//
//    // MARK: Initializers
//
//    init(frame: CGRect, customMessage: String) {
//        self.customMessage = customMessage
//        super.init(frame: frame)
//        messageLabel.text = customMessage
//        setupViews()
//        setupActions()
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    // MARK: Setup Functions
//
//    private func setupViews() {
//        backgroundColor = .systemBackground
//
//        // Configure and add subviews
//        addSubview(titleLabel)
//        addSubview(messageLabel)
//        addSubview(actionButton)
//
//        setupLayout()
//    }
//
//    private func setupLayout() {
//        // Use anchor helper for layout
//        titleLabel.anchor(top: topAnchor, left: leadingAnchor, right: trailingAnchor, bottom: nil, paddingTop: 20, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: nil, height: nil)
//
//        messageLabel.anchor(top: titleLabel.bottomAnchor, left: leadingAnchor, right: trailingAnchor, bottom: nil, paddingTop: 10, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: nil, height: nil)
//
//        actionButton.anchor(top: messageLabel.bottomAnchor, left: nil, right: nil, bottom: nil, paddingTop: 20, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 100, height: 40)
//        actionButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
//    }
//
//    private func setupActions() {
//        actionButton.addTarget(self, action: #selector(didTapActionButton), for: .touchUpInside)
//    }
//
//
//}


class NoResultView : UIView {
    
    weak var delegate: NoResultViewDelegate?
    
    private var customMessage: String
    
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
        label.text = "We didn't find any recipe for your search"
        return label
    }()
    
    let noResultImage : UIImageView = {
        let imageView =  UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image =  UIImage(systemName: "questionmark.circle")?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = DesignConstants.primaryColor
        
        return imageView
    }()
    
    
    

    init(message : String){
        self.customMessage =  message
        super.init(frame: .zero)
        setUpViews()
        self.noResultMessageMain.text =  message
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setUpViews(){
        addSubview(noResultImage)
        noResultImage.anchor(top: nil, left: nil, right: nil, bottom: nil, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 100, height: 100)
        noResultImage.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -75).isActive = true
        noResultImage.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        addSubview(noResultTitleMain)
        noResultTitleMain.anchor(top: noResultImage.bottomAnchor, left: leadingAnchor, right: trailingAnchor, bottom: nil, paddingTop:5, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: nil, height: nil)
        addSubview(noResultMessageMain)
        noResultMessageMain.anchor(top: noResultTitleMain.bottomAnchor, left: leadingAnchor, right: trailingAnchor, bottom: nil, paddingTop: 3, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: nil, height: nil)
    }
    
    // MARK: Actions
    
    @objc private func didTapActionButton() {
        delegate?.didTapActionButton()
    }
    
}
