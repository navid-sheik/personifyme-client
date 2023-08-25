
//
//  PersonifyMe
//
//  Created by Navid Sheikh on 27/07/2023.
//

import Foundation


import UIKit


protocol PopReviewControllerDelegate : class {
    func createNewReview(description : String, rating : Int, productId : String)
}



class CreateReviePopController: UIViewController {
    
    weak var delegate : PopReviewControllerDelegate?
    
    
    var productId : String
    
    
    // MARK: - Components
    // Here you add all components
    let viewContainer  : UIView =  {
        let view =  UIView()
        view.backgroundColor   = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let  titleLabel : UILabel = {
        let label = UILabel()
        label.text = "Create Review"
        label.font = UIFont.boldSystemFont(ofSize: 30)
        return label
    }()
    
    let closeButton :  UIButton =  {
       let closeButton  =  UIButton()
        closeButton.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.tintColor  = DesignConstants.primaryColor
        return closeButton
    }()
    let plusButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName:  "xmark.circle.fill" ), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor  = DesignConstants.primaryColor
        return button
    }()
    
    
    
    let  starRatingLabel : UILabel = {
        let label = UILabel()
        label.text = "Overall Rating"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    
    lazy var starRatingView: StarRatingView = {
        let ratingView = StarRatingView(starMode: .interactive)
            ratingView.translatesAutoresizingMaskIntoConstraints = false
            
            return ratingView
        }()
    
    
    let descriptionTextField : UITextView =  {
        let textView  =  UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.layer.masksToBounds = true
        textView.text = "Enter your review "
        textView.textAlignment = .left
        textView.textContainerInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5);
        textView.font = UIFont.systemFont(ofSize: 14)
        textView.layer.cornerRadius = 5
        
        textView.layer.borderColor  =  UIColor.lightGray.cgColor
        textView.layer.borderWidth = 1
        textView.isScrollEnabled = true
        return textView
    }()
    
    let submitButton  : CustomButton =  {
        let button  =  CustomButton(title: "Submit", hasBackground : true,  fontType: .medium)
        
        return button
    }()
    
    
   
    
    
    // MARK: - Properties
    // All properties and variables you need in your ViewController
    init(productId: String) {
        self.productId = productId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor  = .clear
        self.descriptionTextField.delegate = self
        submitButton.addTarget(self, action: #selector(handleCreateReview), for: .touchUpInside)
        
        closeButton.addTarget(self, action: #selector(handleClosePop), for: .touchUpInside)
        
        setupUI()
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        
        // Setup toolbar
        
        
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 40))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonTapped))
        toolbar.items = [flexSpace, doneButton]
        descriptionTextField.inputAccessoryView = toolbar
        
    
        // Set up all UI elements here
        view.addSubview(viewContainer)
        viewContainer.backgroundColor = DesignConstants.secondaryColor
        viewContainer.layer.shadowColor = UIColor.black.cgColor
        viewContainer.layer.shadowOpacity = 0.8
        viewContainer.layer.shadowOffset = CGSize(width: 0, height: 0)
        viewContainer.layer.shadowRadius = 8


               // To make the shadow work properly, set the background color and shadow on the same layer,
               // and make sure to set the `masksToBounds` property to false.
        viewContainer.layer.masksToBounds = false

        
        let widthContainer  = self.view.frame.width * 0.9
        let heightContainer  = self.view.frame.height / 2
        
        viewContainer.heightAnchor.constraint(equalToConstant: heightContainer).isActive = true
        viewContainer.widthAnchor.constraint(equalToConstant: widthContainer).isActive = true
        
        viewContainer.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        viewContainer.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        
        
        viewContainer.addSubview(titleLabel)
        viewContainer.addSubview(starRatingLabel)
        viewContainer.addSubview(starRatingView)
        viewContainer.addSubview(descriptionTextField)
        viewContainer.addSubview(submitButton)
        viewContainer.addSubview(closeButton)
        
        
        
        titleLabel.anchor( top: self.viewContainer.topAnchor, left:  self.viewContainer.leadingAnchor, right:  self.viewContainer.trailingAnchor, bottom: nil, paddingTop: 20, paddingLeft: 10 ,paddingRight: -10, paddingBottom: 0, width: nil, height: nil)
        
        closeButton.anchor( top: nil, left:  nil, right:  self.viewContainer.trailingAnchor, bottom: nil, paddingTop: 0, paddingLeft: 0 ,paddingRight: -10, paddingBottom: 0, width: 40, height: 40)
        
        closeButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor).isActive = true
    
        
        
        
        
        
        
     
        starRatingLabel.anchor( top: titleLabel.bottomAnchor, left:  self.viewContainer.leadingAnchor, right:  self.viewContainer.trailingAnchor, bottom: nil, paddingTop: 20, paddingLeft: 10 ,paddingRight: -10, paddingBottom: 0, width: nil, height: nil)

        starRatingView.anchor( top: starRatingLabel.bottomAnchor, left:  self.viewContainer.leadingAnchor, right:  nil, bottom: nil, paddingTop: 5, paddingLeft: 10 ,paddingRight: -10, paddingBottom: 0, width: self.view.frame.width / 2, height: 40)
        
        descriptionTextField.anchor( top: starRatingView.bottomAnchor, left:  self.viewContainer.leadingAnchor, right:  self.viewContainer.trailingAnchor, bottom: nil, paddingTop: 10, paddingLeft: 10 ,paddingRight: -10, paddingBottom: 0, width: nil, height: 200)
        
        submitButton.anchor( top: descriptionTextField.bottomAnchor, left:  self.viewContainer.leadingAnchor, right:  self.viewContainer.trailingAnchor, bottom: nil, paddingTop: 10, paddingLeft: 10 ,paddingRight: -10, paddingBottom: 0, width: nil, height: 40)
        
        
        
        
        
        
    }
    
    
    // MARK: - IBActions
    // Here you add all your @IBActions (functions called by UI interactions like button taps)
    
    @objc func handleCreateReview(){
        print ("Create")
        let rating   =  starRatingView.rating
        guard let description  = descriptionTextField.text ,  !description.isEmpty else {return}
        print("Rating is \(rating)")
        self.dismiss(animated: true) { 
            self.delegate?.createNewReview(description: description, rating: rating, productId: self.productId)
        }
      
        
    }
    
    @objc func handleClosePop(){
        print("Close")
        self.dismiss(animated: true)
    }
    
    @objc func doneButtonTapped(){
        descriptionTextField.resignFirstResponder()
    }
    
    // MARK: - Navigation
    // Segue preparations and related stuff
    
    // MARK: - Private methods
    // All other functions that you use within the ViewController
}

extension CreateReviePopController : UITextViewDelegate{
    
}

//
//    func textViewDidBeginEditing(_ textView: UITextView) {
//
//        if textView.text == "Enter your review " {
//            textView.text = ""
//            textView.textColor = .black
//        }
//
//    }
   
    

    
//    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
//        if textView.text.isEmpty {
//            textView.text = "Enter your review "
//            textView.textColor = .lightGray
//        }
//
//
//        textView.resignFirstResponder()
//        return true
//    }
    
    

