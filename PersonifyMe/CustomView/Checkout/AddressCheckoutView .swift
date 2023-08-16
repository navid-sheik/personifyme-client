//
//  AddressCheckoutView .swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 14/08/2023.
//

import Foundation
import UIKit

class AddressCheckoutView : UIView {
    
    private let padding: CGFloat = 10.0
    
    private let plusButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.isSelected = false
        button.titleLabel?.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        return button
    }()
    
    let addressLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.text = "Add shipping address"
        return label
    }()
    
    private let chevronImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "chevron.right") // using SF Symbols for chevron
        imageView.tintColor = .gray
        return imageView
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
        addSubview(addressLabel)
        addSubview(chevronImageView)
        
        NSLayoutConstraint.activate([
                   plusButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
                   plusButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding), // Added padding here
                   
                   addressLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
                   addressLabel.leadingAnchor.constraint(equalTo: plusButton.trailingAnchor, constant: 8),
                   addressLabel.trailingAnchor.constraint(lessThanOrEqualTo: chevronImageView.leadingAnchor, constant: -8),
                   
                   chevronImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
                   chevronImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding) // Added padding here
               ])
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapAddress))
        addGestureRecognizer(tapGesture)
    }
    
    @objc private func didTapAddress() {
        // Placeholder action, you can customize this further
        print("Address Tapped!")
    }
    
    func setAddress(_ address: String?) {
        if let addr = address {
            addressLabel.text = addr
            plusButton.setImage(UIImage(systemName: "house"), for: .normal)
        } else {
            addressLabel.text = "Add shipping address"
            plusButton.isHidden = false
        }
    }
}
