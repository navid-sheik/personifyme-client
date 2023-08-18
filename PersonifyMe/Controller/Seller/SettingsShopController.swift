//
//  UpdateShopController.swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 18/08/2023.
//



//
//  PersonifyMe
//
//  Created by Navid Sheikh on 27/07/2023.
//

import Foundation


import UIKit

protocol SettingsShopControllerDelegate : class{
    func didUpdateShop( shop : Shop)
    func didDeactivateShop( shop : Shop)
}

class SettingsShopController: UIViewController {
    weak var delegate : SettingsShopControllerDelegate?
    
    
    // MARK: - Components
    // Here you add all components
    var shopInfo : Shop? {
        didSet{
           
            self.configureUI(shopInfo)
        }
    }
    

    var catergories : [Category]?{
        didSet{
            DispatchQueue.main.async {
                guard let categories = self.catergories else {return}
                let categoriesName = categories.map{$0.name}
                self.categoryTextfield.setPickerData(data: categoriesName)
            }
          
        }
    }
    
    
    var existingImageUrl : String?
  
 
    private var shopImage  : UIImage?{
        didSet{
            mainImage.image  =  self.shopImage
        }
    }
    
    let mainImage : CustomImageView  = {
        let imageView  = CustomImageView()
        imageView.image =  UIImage(named: "image-placeholder")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius =  .init(10)
        
        imageView.clipsToBounds = true
        imageView.backgroundColor =  .init(white: 0.9, alpha: 0.5)
        return imageView
    }()
    
    let editImaeButton : UIButton =  {
        let button =  UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "pencil"), for: .normal)
       

        
        return button
    }()
    
    let saveButton  : UIButton = {
        let button =  UIButton(type: .system)
        button.setTitle("Save", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.black, for: .normal)
     
        return button
    }()
    
    let cancelButton  : UIButton = {
        let button =  UIButton(type: .system)
        button.setTitle("Cancel", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.black, for: .normal)
     
        return button
    }()
    
    lazy var nameTxtField: ShopSettingTxtField  = {
        let textfield  =  ShopSettingTxtField(title: "Name", value: "")
        
        return textfield
    }()
    
    lazy var descriptionTxtfield : ShopSettingTxtField  = {
        let textfield  =  ShopSettingTxtField(title: "Description", value: "")
        
        return textfield
    }()
   
    let locationTxtField : ShopSelectableTextFiled = {
        let textfield  =  ShopSelectableTextFiled(title: "Location", value: "")
        
        return textfield
    }()
    
    let currencyTxtField : ShopSelectableTextFiled = {
        let textfield  =  ShopSelectableTextFiled(title: "Currency", value: "")
        
        return textfield
    }()
 
    
 
    
    lazy var categoryTextfield : ShopSelectableTextFiled  = {
        let textfield  =  ShopSelectableTextFiled(title: "Category", value: "")
        
        return textfield
    }()
    
    lazy var emailSupportTextfield : ShopSettingTxtField  = {
        let textfield  =  ShopSettingTxtField(title: "Email Support", value: "")
        
        return textfield
    }()
    
    let deactivateButton : CustomButton =  {
        
        let button  = CustomButton(title: "Deactivate",hasBackground: true,  fontType: .medium)
        return button
        
    }()
    
    
    
    //MARK: MAIN SCROLLVIEW
    lazy var containerScrollView :  UIScrollView =  {
        let sv =  UIScrollView()
        sv.isScrollEnabled = true
        sv.bounces = true
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.flashScrollIndicators()
        sv.isUserInteractionEnabled = true
        sv.contentInsetAdjustmentBehavior = .never
        return sv
    }()
    let contentView : UIView =  {
        let view = UIView()
        view.isUserInteractionEnabled = true
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
        
    }()
  
    
    
    
    
    @objc func handleSomethign(){
            print("Someting")
        }
    
    
    
    // MARK: - Properties
    // All properties and variables you need in your ViewController
    
    
    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor  = .systemBackground
        saveButton.addTarget(self, action: #selector(didTapSave), for: .touchUpInside)
        editImaeButton.addTarget(self, action: #selector(didTapEditImageButton), for: .touchUpInside)
        cancelButton.addTarget(self, action: #selector(didTapCancel), for: .touchUpInside)
        // Add observers for keyboard events
              NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
              NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
     
        self.configureUI(shopInfo)

//        nameTxtField.textFieldDelegate =  self
        let pickerDataArray = ["USD", "GBP"]
        currencyTxtField.setPickerData(data: pickerDataArray)
        
        let pickerDataArrayCountries = ["United States", "United Kingdom"]
        locationTxtField.setPickerData(data: pickerDataArrayCountries)
        
        
        let pickerDataArrayCategory = ["Fashion", "Electronics"]
        categoryTextfield.setPickerData(data: pickerDataArrayCategory)
        
        
        
        
        
        
        setupUI()
        fetchCategories()
    }
    
    init(shopInfo: Shop) {
        self.shopInfo = shopInfo
        super.init(nibName: nil, bundle: nil)
   
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func keyboardWillShow(notification: Notification) {
          // Get the height of the keyboard.
          guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {
              return
          }
          
          let keyboardHeight = keyboardFrame.cgRectValue.height
          
          // Increase the bottom content inset of the scroll view by the keyboard height.
          containerScrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight, right: 0)
          
          // Add the same amount to the scroll indicator insets.
          containerScrollView.scrollIndicatorInsets = containerScrollView.contentInset
      }
      
      @objc func keyboardWillHide(notification: Notification) {
          // Reset the content inset of the scroll view to zero.
          containerScrollView.contentInset = UIEdgeInsets.zero
          
          // Reset the scroll indicator insets to zero.
          containerScrollView.scrollIndicatorInsets = UIEdgeInsets.zero
      }
      
      // MARK: - Deinit
      
      deinit {
          // Remove the observers
          NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
          NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
      }
    
    // MARK: - UI Setup
    private func setupUI() {
        // Set up all UI elements here
        view.addSubview(containerScrollView)
        
        // Increase the paddingTop 20
        containerScrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        containerScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        containerScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        containerScrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        containerScrollView.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.leadingAnchor.constraint(equalTo: containerScrollView.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: containerScrollView.trailingAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: containerScrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: containerScrollView.bottomAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: containerScrollView.widthAnchor).isActive = true
        
        // Add everything to the contentView instead of the view
        
        contentView.addSubview(cancelButton)
        cancelButton.anchor(top: contentView.safeAreaLayoutGuide.topAnchor, left: contentView.leadingAnchor, right: nil, bottom: nil, paddingTop: 10, paddingLeft: 5, paddingRight: 0, paddingBottom: 0, width: 60, height: 40)
        
        
        contentView.addSubview(saveButton)
        saveButton.anchor(top: contentView.safeAreaLayoutGuide.topAnchor, left: nil, right: contentView.trailingAnchor, bottom: nil, paddingTop: 10, paddingLeft: 0, paddingRight: -5, paddingBottom: 0, width: 60, height: 40)
        
        let width = self.view.frame.width / 3
        contentView.addSubview(mainImage)
        mainImage.anchor(top: saveButton.bottomAnchor, left: nil, right: nil, bottom: nil, paddingTop: 10, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: width, height: width)
        
        mainImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        contentView.addSubview(editImaeButton)
        editImaeButton.anchor(top: mainImage.topAnchor, left: nil, right: mainImage.trailingAnchor, bottom: nil, paddingTop: 2, paddingLeft: 0, paddingRight: -2, paddingBottom: 0, width: 30, height: 30)
        
        contentView.addSubview(nameTxtField)
        nameTxtField.anchor(top: mainImage.bottomAnchor, left: contentView.leadingAnchor, right: contentView.trailingAnchor, bottom: nil, paddingTop: 30, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: nil, height: 50)
        
        contentView.addSubview(descriptionTxtfield)
        descriptionTxtfield.anchor(top: nameTxtField.bottomAnchor, left: contentView.leadingAnchor, right: contentView.trailingAnchor, bottom: nil, paddingTop: 30, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: nil, height: 50)
        
        contentView.addSubview(currencyTxtField)
        currencyTxtField.anchor(top: descriptionTxtfield.bottomAnchor, left: contentView.leadingAnchor, right: contentView.trailingAnchor, bottom: nil, paddingTop: 30, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: nil, height: 50)
        
        contentView.addSubview(locationTxtField)
        locationTxtField.anchor(top: currencyTxtField.bottomAnchor, left: contentView.leadingAnchor, right: contentView.trailingAnchor, bottom: nil, paddingTop: 30, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: nil, height: 50)
        
        contentView.addSubview(categoryTextfield)
        categoryTextfield.anchor(top: locationTxtField.bottomAnchor, left: contentView.leadingAnchor, right: contentView.trailingAnchor, bottom: nil, paddingTop: 30, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: nil, height: 50)
        
        contentView.addSubview(emailSupportTextfield)
        emailSupportTextfield.anchor(top: categoryTextfield.bottomAnchor, left: contentView.leadingAnchor, right: contentView.trailingAnchor, bottom: nil, paddingTop: 30, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: nil, height: 50)
        
        contentView.addSubview(deactivateButton)
        deactivateButton.anchor(top: emailSupportTextfield.bottomAnchor, left: contentView.leadingAnchor, right: contentView.trailingAnchor, bottom: contentView.bottomAnchor, paddingTop: 30, paddingLeft: 10, paddingRight: -10, paddingBottom: 0, width: nil, height: 35)
    }
    
    
    private func fetchCategories(){
        Service.shared.fecthAllCategories(expecting: ApiResponse<[Category]>.self) { [weak self] result in
            guard let self = self else {return}
            switch result{
                
                
            case .success(let response):
                guard let categories = response.data else {
                    print("Cannot get the categories ")
                    return
                    
                }
                self.catergories =  categories
               
                
            
            case .failure(let error):
                print(error)
                
            }
        }
        
    }

    
    

    @objc func didTapCancel(){
        self.dismiss(animated: true)
    }
    
    @objc func didTapSave(){
        print (descriptionTxtfield.getText())
        
        let description = descriptionTxtfield.getText()
        let name = nameTxtField.getText()
        let currency = currencyTxtField.getText()
        let location = locationTxtField.getText()
        let categoryName = categoryTextfield.getText()
        //Find the id
        let categoryID  = catergories?.filter{$0.name == categoryName}.first?.categoryId
        
        let email = emailSupportTextfield.getText()

        
       
        
     
       
            
        
        var shop = Shop(sellerShopID: self.shopInfo?.sellerShopID, name: name, description: description, location: location, currecy: currency, image: nil, isActive: self.shopInfo!.isActive, categoryId: categoryID!, categoryName: categoryName, emailSupport: email, totalLikes: nil, followers: nil, follows: nil, createdAt: nil, updatedAt: nil)
       
        if let uploadImage =  shopImage{
            var base64String = uploadImage.jpegData(compressionQuality: 0.8)?.base64EncodedString()
            guard let base64 = base64String else {return}
            let newImage  =  "data:image/jpeg;base64,\(base64)"
            shop = Shop(sellerShopID: self.shopInfo?.sellerShopID, name: name, description: description, location: location, currecy: currency, image: newImage, isActive: self.shopInfo!.isActive, categoryId: categoryID!, categoryName: categoryName, emailSupport: email, totalLikes: nil, followers: nil, follows: nil, createdAt: nil, updatedAt: nil)
           
            
        }
        
        Service.shared.updateShop(with: shop, expecting: ApiResponse<Shop>.self) { [weak self] result in
            guard let self = self else {return}
            switch result{
                
            case .success(let response):
                guard let newShopInfo  = response.data else {return}
                DispatchQueue.main.async {
                    self.delegate?.didUpdateShop(shop: newShopInfo)
                    self.dismiss(animated: true)
                }
                
                print("Neew shop")
            case .failure(let error):
                print("Eror")
            }
        }
        
        
        
        
        
        
        
        
        
        
    
//        guard let name = nameTxtField.textField.text , name != "" else {
//            //Show alert
//            self.showAlert(for: nameTxtField, withMessage: "No emptry values")
//            return
//        }
//        guard let description = descriptionTxtfield.textField.text else {return}
//
       
        
    }
    
    func showAlert(for textField: ShopSettingTxtField, withMessage message: String) {
        let alertController = UIAlertController(title:  "Empty \(textField.title) ",
                                                   message: message,
                                                   preferredStyle: .alert)
           
           let okAction = UIAlertAction(title: "OK", style: .default) { [weak self] _ in
               textField.becomeFirstResponder()
               self?.dismiss(animated: true, completion: nil)
           }
           alertController.addAction(okAction)
           
           self.present(alertController, animated: true, completion: nil)
       }
    
    
    @objc func didTapEditImageButton(){
        print("Edit image")
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
       
       imagePickerController.sourceType = .photoLibrary // Change to .camera to take a photo
       self.present(imagePickerController, animated: true, completion: nil)
    
    }
    
    
    
    
    // MARK: - IBActions
    // Here you add all your @IBActions (functions called by UI interactions like button taps)
    
    // MARK: - Navigation
    // Segue preparations and related stuff
    
    // MARK: - Private methods
    // All other functions that you use within the ViewController
    
    func configureUI(_ shopInfo :  Shop?){
        if let imageUrl  =  shopInfo?.image {
            self.mainImage.loadImageUrlString(urlString: imageUrl)
        }
        self.nameTxtField.setText(value: shopInfo!.name)
        self.descriptionTxtfield.setText(value: shopInfo!.description)
        self.currencyTxtField.setText(value: shopInfo!.currecy)
        self.locationTxtField.setText(value: shopInfo!.location!)
        self.categoryTextfield.setText(value: shopInfo!.categoryName)
        self.emailSupportTextfield.setText(value: shopInfo!.emailSupport)
        self.existingImageUrl = shopInfo!.image
        
    
     
    }
}

extension SettingsShopController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print(textField.text)
    }
    
    
    
    

}

extension SettingsShopController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
  
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        
        
        if let pickedImage = info[.editedImage] as? UIImage {
            // Add the selected image to your images array
            let squareImage = cropToBounds(image: pickedImage, width: Double(pickedImage.size.width), height: Double(pickedImage.size.width))
            self.shopImage =  squareImage
            self.existingImageUrl = nil
        
            
            
        }
        picker.dismiss(animated: true, completion: nil)
        
        
        
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    ///Sqaure Image
    func cropToBounds(image: UIImage, width: Double, height: Double) -> UIImage {
        let contextImage: UIImage = UIImage(cgImage: image.cgImage!)
        let contextSize: CGSize = contextImage.size
        var posX: CGFloat = 0.0
        var posY: CGFloat = 0.0
        var cgwidth: CGFloat = CGFloat(width)
        var cgheight: CGFloat = CGFloat(height)
        
        // See what size is longer and create the center off of that
        if contextSize.width > contextSize.height {
            posX = ((contextSize.width - contextSize.height) / 2)
            posY = 0
            cgwidth = contextSize.height
            cgheight = contextSize.height
        } else {
            posX = 0
            posY = ((contextSize.height - contextSize.width) / 2)
            cgwidth = contextSize.width
            cgheight = contextSize.width
        }
        
        let rect: CGRect = CGRect(x: posX, y: posY, width: cgwidth, height: cgheight)
        // Create bitmap image from context using the rect
        let imageRef: CGImage = contextImage.cgImage!.cropping(to: rect)!
        // Create a new image based on the imageRef and rotate back to the original orientation
        let image: UIImage = UIImage(cgImage: imageRef, scale: image.scale, orientation: image.imageOrientation)
        
        return image
    }
    
}

