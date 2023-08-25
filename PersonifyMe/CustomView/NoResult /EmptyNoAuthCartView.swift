//
//  EmptryCart.swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 23/08/2023.
//

import Foundation
import UIKit





// Protocol for EmptyCartView delegate
protocol EmptyNoAuthCartViewDelegate: AnyObject {
    func didTapCartSignIn()
}

// Custom UIView to show when the cart is empty
class EmptyNoAuthCartView: UIView {
    
    // Delegate to handle user actions
    weak var delegate: EmptyNoAuthCartViewDelegate?
    
    // MARK: UI Elements
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .darkGray
        label.textAlignment = .center
        label.text = "Your Cart is Empty"
        return label
    }()
    
    private let messageLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .darkGray
        label.textAlignment = .center
        label.text = "Sign in to add items to your cart."
        return label
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "cart.fill")?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = DesignConstants.primaryColor // Replace with your DesignConstants.primaryColor if needed
        return imageView
    }()
    
    private let signInButton: CustomButton = {
        let button = CustomButton(title: "Sign In", hasBackground: true, fontType: .medium)
        return button
    }()
    
    // MARK: Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Setup Functions
    
    private func setupViews() {
        backgroundColor = .systemBackground
        
        // Configure and add subviews
        
        setupLayout()
    }
    
    private func setupLayout() {
        // Add subviews
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(messageLabel)
        addSubview(signInButton)
        
        // Use anchor helper for layout
        imageView.anchor(top: nil, left: nil, right: nil, bottom: nil, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 150, height: 150)
        imageView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -50).isActive = true
        imageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        titleLabel.anchor(top: imageView.bottomAnchor, left: leadingAnchor, right: trailingAnchor, bottom: nil, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: nil, height: nil)
        
        messageLabel.anchor(top: titleLabel.bottomAnchor, left: leadingAnchor, right: trailingAnchor, bottom: nil, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: nil, height: nil)
        
        signInButton.anchor(top: messageLabel.bottomAnchor, left: nil, right: nil, bottom: nil, paddingTop: 10, paddingLeft: 20, paddingRight: -20, paddingBottom: 0, width: 100, height: 40)
        signInButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
    }
    private func setupActions() {
        signInButton.addTarget(self, action: #selector(didTapSignInButton), for: .touchUpInside)
    }
    
    // MARK: Actions
    
    @objc private func didTapSignInButton() {
        delegate?.didTapCartSignIn()
    }
}





