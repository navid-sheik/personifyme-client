//
//  PaymentMethodView.swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 14/08/2023.
//

import Foundation
import UIKit

class PaymentMethodView: UIView {

    private let padding: CGFloat = 10.0

    private let plusButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        return button
    }()
    
    private let paymentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Add payment method"
        return label
    }()
    
    private let chevronImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "chevron.right")
        imageView.tintColor = .gray
        return imageView
    }()
    
    private let payWithLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Pay with"
        label.isHidden = true
        return label
    }()
    
    private let cardImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "creditcard")  // Placeholder image
        imageView.tintColor = .gray
        imageView.isHidden = true
        return imageView
    }()
    
 
    
    private let cardNumberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isHidden = true
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.lightGray.cgColor

        addSubview(plusButton)
        addSubview(paymentLabel)
        addSubview(chevronImageView)
        addSubview(payWithLabel)
        addSubview(cardImageView)
        addSubview(cardNumberLabel)
        
        NSLayoutConstraint.activate([
            plusButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            plusButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            
            paymentLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            paymentLabel.leadingAnchor.constraint(equalTo: plusButton.trailingAnchor, constant: 8),
            paymentLabel.trailingAnchor.constraint(lessThanOrEqualTo: chevronImageView.leadingAnchor, constant: -8),
            
            chevronImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            chevronImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            
            payWithLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            payWithLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            
            cardImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            cardImageView.leadingAnchor.constraint(equalTo: payWithLabel.trailingAnchor, constant: 8),
            
            cardNumberLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            cardNumberLabel.leadingAnchor.constraint(equalTo: cardImageView.trailingAnchor, constant: 8),
            cardNumberLabel.trailingAnchor.constraint(lessThanOrEqualTo: chevronImageView.leadingAnchor, constant: -8)
        ])
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapPaymentMethod))
        addGestureRecognizer(tapGesture)
    }
    
    @objc private func didTapPaymentMethod() {
        print("Payment method Tapped!")
    }
    
    func setPaymentMethod(cardImage: UIImage?, lastFourDigits: String?) {
        UIView.animate(withDuration: 0.3, animations: {
            if let cardImg = cardImage, let digits = lastFourDigits {
                self.plusButton.alpha = 0.0
                self.paymentLabel.alpha = 0.0
                
                self.payWithLabel.alpha = 1.0
                self.cardImageView.image = cardImg
                self.cardImageView.alpha = 1.0
                self.cardNumberLabel.text = "****\(digits)"
                self.cardNumberLabel.alpha = 1.0
            } else {
                self.plusButton.alpha = 1.0
                self.paymentLabel.alpha = 1.0
                
                self.payWithLabel.alpha = 0.0
                self.cardImageView.alpha = 0.0
                self.cardNumberLabel.alpha = 0.0
            }
        }) { (completed) in
            if let cardImg = cardImage, let digits = lastFourDigits {
                self.plusButton.isHidden = true
                self.paymentLabel.isHidden = true
                
                self.payWithLabel.isHidden = false
                self.cardImageView.isHidden = false
                self.cardNumberLabel.isHidden = false
            } else {
                self.plusButton.isHidden = false
                self.paymentLabel.isHidden = false
                
                self.payWithLabel.isHidden = true
                self.cardImageView.isHidden = true
                self.cardNumberLabel.isHidden = true
            }
        }
    }





}
