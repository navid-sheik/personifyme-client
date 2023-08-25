//
//  TrackingBuyerController .swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 24/08/2023.
//

import Foundation

import Foundation



import UIKit






class TrackingBuyerController : UIViewController {
    
   
    var order : OrderItem
        

    
    var indexPath : IndexPath?
    
    
    

    
    
    // MARK: - Components
    // Here you add all components
    let viewContainer  : UIView =  {
        let view =  UIView()
        view.backgroundColor   = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    var titleLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "TRACK YOUR ORDER"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .center
        label.textColor = UIColor.gray
        return label
    }()
    
    var shippingLabel:  UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Shipping Service: "
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .left
        label.textColor = UIColor.gray
        return label
    }()
    
    
    var shippingValue :  UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .left
        label.textColor = UIColor.gray
        label.numberOfLines =  0
        return label
    }()
    
    
    var trackingLabel:  UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Tracking Number: "
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .left
        label.textColor = UIColor.gray
        return label
    }()
    
    var trackingValue:  UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = " "
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .left
        label.textColor = UIColor.gray
        label.numberOfLines =  0
        return label
    }()
    
    
    var closeButton : CustomButton = {
        let button = CustomButton(title: "Close", hasBackground: true, fontType: .medium)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    
 
 
    
    
    
   
    
    
    // MARK: - Properties
    // All properties and variables you need in your ViewController
    
  
    init(order : OrderItem) {
        self.order  =  order
        print(order)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor  = .clear
     
        closeButton.addTarget(self, action: #selector(handleClosePop), for: .touchUpInside)
        if let exstingTrackingObject =  order.tracking {
            self.shippingValue.text  =  exstingTrackingObject.carrier
            self.trackingValue.text  =  exstingTrackingObject.trackingNumber
        }

    
       
        
        setupUI()
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        
        // Setup toolbar
        

    
        // Set up all UI elements here
        view.addSubview(viewContainer)
        viewContainer.layer.borderColor = UIColor.lightGray.cgColor
        viewContainer.layer.borderWidth = 1
//        viewContainer.backgroundColor = .lightGray
        let widthContainer  = self.view.frame.width * 0.85
        let heightContainer  = self.view.frame.height / 3
        
        viewContainer.heightAnchor.constraint(equalToConstant: heightContainer).isActive = true
        viewContainer.widthAnchor.constraint(equalToConstant: widthContainer).isActive = true
        
        viewContainer.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        viewContainer.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        viewContainer.addSubview(titleLabel)
        viewContainer.addSubview(trackingLabel)
        viewContainer.addSubview(trackingValue)
        viewContainer.addSubview(shippingLabel)
        viewContainer.addSubview(shippingValue)
        
        viewContainer.addSubview(closeButton)
        
        titleLabel.anchor( top: self.viewContainer.topAnchor, left:  self.viewContainer.leadingAnchor, right:  self.viewContainer.trailingAnchor, bottom: nil, paddingTop: 10, paddingLeft: 10 ,paddingRight: -10, paddingBottom: 0, width: nil, height: nil)
        
        shippingLabel.anchor( top: titleLabel.bottomAnchor, left:  self.viewContainer.leadingAnchor, right:  nil, bottom: nil, paddingTop: 40, paddingLeft: 10 ,paddingRight: -10, paddingBottom: 0, width: nil, height: nil)

        
        shippingValue.anchor( top: titleLabel.bottomAnchor, left:   shippingLabel.trailingAnchor, right:  self.viewContainer.trailingAnchor, bottom: nil, paddingTop: 40, paddingLeft: 5 ,paddingRight: -10, paddingBottom: 0, width: nil, height: nil)
        
        trackingLabel.anchor( top: shippingLabel.bottomAnchor, left:   self.viewContainer.leadingAnchor, right:  nil, bottom: nil, paddingTop: 15, paddingLeft: 10 ,paddingRight: -10, paddingBottom: 0, width: nil, height: nil)
        
        trackingValue.anchor( top: shippingLabel.bottomAnchor, left:   self.trackingLabel.trailingAnchor, right:  self.viewContainer.trailingAnchor, bottom: nil, paddingTop: 15, paddingLeft: 5 ,paddingRight: -10, paddingBottom: 0, width: nil, height: nil)
        
        closeButton.anchor( top: nil, left:   self.viewContainer.leadingAnchor, right:  self.viewContainer.trailingAnchor, bottom: self.viewContainer.bottomAnchor, paddingTop: 25, paddingLeft: 10 ,paddingRight: -10, paddingBottom: -20, width: nil, height: 35)
        
        
        

        
       
        
        
        
        
        
    }
    
    
    // MARK: - IBActions
    // Here you add all your @IBActions (functions called by UI interactions like button taps)
   
    
    @objc func handleClosePop(){
        print("Close")
        self.dismiss(animated: true)
    }
    
    
    
    // MARK: - Navigation
    // Segue preparations and related stuff
    
    // MARK: - Private methods
    // All other functions that you use within the ViewController
}
