//
//  AddTrackingController.swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 16/08/2023.
//

import Foundation



import UIKit


protocol AddTrackingControllerDelegate : class {
    func updateValue (courierName : String, trackingNumber : String, order: OrderItem?, indexPath: IndexPath?)
}



class AddTrackingController: UIViewController {
    
    weak var delegate : AddTrackingControllerDelegate?
    var order : OrderItem?{
        didSet{
            if let exstingTrackingObject =  order?.tracking {
                self.carrier.text  =  exstingTrackingObject.carrier
                self.trackingNumber.text  =  exstingTrackingObject.trackingNumber
            }
        }
    }
    
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
        label.text = "ADD TRACKING"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textAlignment = .center
        label.textColor = DesignConstants.textColor
        return label
    }()
    
    var  carrier : UITextField = {
        let textField = UITextField()
        let spacer  =  UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        

        textField.leftView =  spacer
        textField.leftViewMode =  .always
        textField.textColor =  .lightGray
        textField.keyboardAppearance =  .dark
        textField.backgroundColor =  UIColor(white: 1, alpha: 0.1)
//        textField.attributedPlaceholder =  NSAttributedString(string: "Size", attributes: [.foregroundColor : UIColor(white: 1, alpha: 0.7) ])

        textField.placeholder = "Enter Courier"
        textField.font = UIFont.systemFont(ofSize: 14)
        textField.textColor = UIColor.gray
        textField.layer.cornerRadius = 2
        textField.layer.masksToBounds = true
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.lightGray.cgColor
        
        return textField
    }()
    
    var  trackingNumber : UITextField = {
        let textField = UITextField()
        let spacer  =  UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        

        textField.leftView =  spacer
        textField.leftViewMode =  .always
        textField.textColor =  .lightGray
        textField.keyboardAppearance =  .dark
        textField.backgroundColor =  UIColor(white: 1, alpha: 0.1)
//        textField.attributedPlaceholder =  NSAttributedString(string: "Size", attributes: [.foregroundColor : UIColor(white: 1, alpha: 0.7) ])

        textField.placeholder = "Enter the tracking number"
        textField.font = UIFont.systemFont(ofSize: 14)
        textField.textColor = UIColor.gray
        textField.layer.cornerRadius = 2
        textField.layer.masksToBounds = true
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.lightGray.cgColor
        
        return textField
    }()
    
    let closeButton  : UIButton =  {
        let button = UIButton()
        button.setImage(UIImage(named: "close"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
 
    
  
    
    let updateButton  : CustomButton =  {
        let button  =  CustomButton(title: "Update", hasBackground : true,  fontType: .medium)
        
        return button
    }()
    
    
    
    
    let cancelBUtton  : CustomButton =  {
        let button  =  CustomButton(title: "Cancel", hasBackground : true,  fontType: .medium)
        
        return button
    }()
    
    
   
    
    
    // MARK: - Properties
    // All properties and variables you need in your ViewController
    
  
    init() {
      
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor  = .clear
     
        updateButton.addTarget(self, action: #selector(handleUpdateButton), for: .touchUpInside)
        
        cancelBUtton.addTarget(self, action: #selector(handleClosePop), for: .touchUpInside)
       
        
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
        let widthContainer  = self.view.frame.width * 0.9
        let heightContainer  = self.view.frame.height / 3
        
        viewContainer.heightAnchor.constraint(equalToConstant: heightContainer).isActive = true
        viewContainer.widthAnchor.constraint(equalToConstant: widthContainer).isActive = true
        
        viewContainer.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        viewContainer.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        viewContainer.addSubview(titleLabel)
        viewContainer.addSubview(cancelBUtton)
        viewContainer.addSubview(carrier)
        viewContainer.addSubview(updateButton)
        
        viewContainer.addSubview(trackingNumber)
        
        
        
        
        titleLabel.anchor( top: self.viewContainer.topAnchor, left:  self.viewContainer.leadingAnchor, right:  self.viewContainer.trailingAnchor, bottom: nil, paddingTop: 25, paddingLeft: 10 ,paddingRight: -10, paddingBottom: 0, width: nil, height: nil)
        
        carrier.anchor( top: self.titleLabel.bottomAnchor, left:  self.viewContainer.leadingAnchor, right:  self.viewContainer.trailingAnchor, bottom: nil, paddingTop: 20, paddingLeft: 10 ,paddingRight: -10, paddingBottom: 0, width: nil, height: 40)
        
     
        
        
        
        
        
        
     
        trackingNumber.anchor( top: carrier.bottomAnchor, left:  self.viewContainer.leadingAnchor, right:  self.viewContainer.trailingAnchor, bottom: nil, paddingTop: 20, paddingLeft: 10 ,paddingRight: -10, paddingBottom: 0, width: nil, height: 40)

        
        
        let buttonStackView =  StackManager.createStackView(with: [cancelBUtton, updateButton], axis: .horizontal, spacing: 10, distribution: .fillEqually, alignment: .fill)
        buttonStackView.isUserInteractionEnabled = true
        
        viewContainer.addSubview(buttonStackView)
        buttonStackView.anchor( top: trackingNumber.bottomAnchor, left:  self.viewContainer.leadingAnchor, right:  self.viewContainer.trailingAnchor, bottom: nil, paddingTop: 10, paddingLeft: 10 ,paddingRight: -10, paddingBottom: 0, width: nil, height: 40)
        
        
        
        
        
        
    }
    
    
    // MARK: - IBActions
    // Here you add all your @IBActions (functions called by UI interactions like button taps)
    
    @objc func handleUpdateButton() {
        print("Create")
        
        // Ensure carrier and trackingNumber are not empty
        guard let carrier = carrier.text, !carrier.isEmpty else {
            showAlert(with: "Error", message: "Please enter a valid carrier.")
            return
        }
        
        guard let trackingNumber = trackingNumber.text, !trackingNumber.isEmpty else {
            showAlert(with: "Error", message: "Please enter a valid tracking number.")
            return
        }
        
        let trackingInfo  = TrackingInfo(carrier: carrier, trackingNumber: trackingNumber, trackingUrl: nil)
        let tracking = Tracking(tracking: trackingInfo)
        
        guard let orderId = order?.orderId else { return }
//        print(tracking)
        Service.shared.uploadTrackingNumber(to: orderId, with: tracking, expecting: ApiResponse<OrderItem>.self) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let response):
                guard let newOrder = response.data else { return }
    
                DispatchQueue.main.async {
                    // Notify delegate of the updated values
                    self.delegate?.updateValue(courierName: carrier, trackingNumber: trackingNumber, order: newOrder, indexPath: self.indexPath)
                    
                    // Show an alert to user about successful update and then dismiss this ViewController
                    self.showAlert(with: "Success", message: "Tracking number updated successfully.", dismissAfter: true)
                
                }
                   
                
                
                
             
                
            case .failure(let error):
                print("Failure: \(error)")
                DispatchQueue.main.async {
                    self.showAlert(with: "Error", message: "Failed to update tracking number. Please try again.", dismissAfter: false)
                }
                
                // Show an alert to user about the failure
             
            }
        }
    }

    // Helper function to display alerts
    func showAlert(with title: String, message: String, dismissAfter: Bool = false) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
            if dismissAfter {
                self.dismiss(animated: true, completion: nil)
            }
        })
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func handleClosePop(){
        print("Close")
        self.dismiss(animated: true)
    }
    
    
    
    // MARK: - Navigation
    // Segue preparations and related stuff
    
    // MARK: - Private methods
    // All other functions that you use within the ViewController
}

extension AddTrackingController : UITextViewDelegate{
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        textView.resignFirstResponder()
        return true
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)

    }
}
