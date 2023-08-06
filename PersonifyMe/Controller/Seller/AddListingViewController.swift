//
//  AddListingViewController.swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 31/07/2023.
//

//
//  PersonifyMe
//
//  Created by Navid Sheikh on 27/07/2023.
//

import Foundation

import PhotosUI
import UIKit

import SimpleCheckbox

class AddListingViewController: UIViewController{
    
    //MARK: IDENTIFIER
    let imageListingSellerIdentifier =  "imageListingSellerIdentifier"
    
    //MARK: VALUE
    
    let returnValue : Bool = false
    
    let exchangeValue : Bool = false
    
    
    //MARK: Arrays
    var images : [UIImage] = []
    
    //MARK: Picker
    
    //Country
    var pickerContainerView = UIView()
    let countryPicker = UIPickerView()
    
    
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
    
    //MARK: COMPONENTS
    ///Title
    let titleTextField :BorderedTextField = {
        let textField = BorderedTextField()
        textField.placeholder = "Title"
        return textField
    }()
    
    ///Image
    let imageCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero , collectionViewLayout: layout)
        cv.isPagingEnabled = true
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .systemBackground
        return cv
    }()
    
    ///Add Image
    
    var addImageButton : CustomButton =  {
        let button  = CustomButton(title: "Add Picture", hasBackground: true, fontType: .medium)
        return button
    }()
    
    ///Catgory
    let categoriesView: CustomSelectableView = {
        let view  = CustomSelectableView(labelName: "Category", imageName: nil)
        
        return view
        
    }()
    
    ///Condition
    let conditionView : CustomSelectableView = {
        let view  = CustomSelectableView(labelName: "Condition", imageName: nil)
        
        return view
        
    }()
    
    ///Description
    let descriptionLabeledTexView :  LabeledTextView = {
        let labelTextView = LabeledTextView(labelText: "Description", placeholder: "Enter an appropriate description")
        labelTextView.translatesAutoresizingMaskIntoConstraints = false
        return labelTextView
    }()
    
    ///Price
    let priceTextField : LabeledTextField =  {
        let textField = LabeledTextField(labelText: "Price", placeholder: "0.0")
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    ///Quantity
    let quantiyTextField : LabeledTextField =  {
        let textField = LabeledTextField(labelText: "Quatity", placeholder: "0")
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    ///Variations
    let variationLabel  : UILabel =  {
        let label  = UILabel()
        label.text =  "Variations"
        label.font =  UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    lazy var swittchVariant: UISwitch = {
        let swithControl = UISwitch()
        swithControl.isOn = false
        swithControl.isEnabled = true
        swithControl.onTintColor = UIColor(red: 55/255, green: 120/255, blue: 250/255, alpha: 1)
        swithControl.translatesAutoresizingMaskIntoConstraints = false
        swithControl.addTarget(self, action: #selector(handleSwitchAction), for: .valueChanged)
        
        return swithControl
    }()
    
    let addVariantButton : CustomButton = {
        let button = CustomButton(title: "Add Variant", hasBackground: true ,fontType: .medium)
        
        return button
    }()
    
    let variantView : UILabel = {
        let label = UILabel()
        label.text = "Variation View"
        label.translatesAutoresizingMaskIntoConstraints = false
        let lighterGray = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1.0)
        label.backgroundColor = lighterGray
        label.textAlignment = .center
        
        return label
    }()
    ///Personalization
    let personalizationLabel  : UILabel =  {
        let label  = UILabel()
        label.text =  "Personlization"
        label.font =  UIFont.systemFont(ofSize: 18)
        return label
    }()
    let personalizationTextView :  LabeledTextView = {
        let labelTextView = LabeledTextView(labelText: "Enter personalization for buyers", placeholder: "Enter an appropriate description")
        labelTextView.translatesAutoresizingMaskIntoConstraints = false
        return labelTextView
    }()
    
    ///Delivery And Producton
    let processingLabel  : UILabel =  {
        let label  = UILabel()
        label.text =  "Delivery & Production"
        label.font =  UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    let originCountryLabel: UILabel = {
        let label = UILabel()
        label.text = "Origin Country"
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    let destinationCountryLabel: UILabel = {
        let label = UILabel()
        label.text = "Destination Country"
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    let processingTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "Processing Time"
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    let standardDeliveryLabel: UILabel = {
        let label = UILabel()
        label.text = "Standard Delivery"
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    let internationalDeliveryLabel: UILabel = {
        let label = UILabel()
        label.text = "International Delivery"
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    let deliveryLabel: UILabel = {
        let label = UILabel()
        label.text = "Delivery & Production"
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    let deliveryStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 20 // Adjust the spacing between labels as needed
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let originCountryTextField : CustomTextField = {
        let textField = CustomTextField(fieldType: .custom)
        textField.placeholder = "Select country"
        textField.layer.cornerRadius =  2
        return textField
    }()
    
    let destinationCountryTextField : CustomTextField = {
        let textField = CustomTextField(fieldType: .custom)
        textField.placeholder = "Select country"
        textField.layer.cornerRadius =  2
        return textField
    }()
    
    let selectableDeliveryStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 20 // Adjust the spacing between labels as needed
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let timeProcessingView : TimeProcessingView =  {
        let view =  TimeProcessingView(start_range: 1, end_range: 2)
        return view
    }()
    
    let timeStandardDelivery : TimeProcessingView =  {
        let view =  TimeProcessingView(start_range: 3, end_range: 5)
        return view
    }()
    
    let timeViewInternationalDelivery : TimeProcessingView =  {
        let view =  TimeProcessingView(start_range: 7, end_range: 10)
        return view
    }()
    
    ///Return & Exhcnage
    
    let returnPoliciesLabel  : UILabel =  {
        let label  = UILabel()
        label.text =  "Delivery & Production"
        label.font =  UIFont.systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let returnPoliciesView :  UILabel =  {
        
        let textView =  UILabel()
        textView.numberOfLines = 0
        textView.textColor  = .lightGray
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isUserInteractionEnabled = false
        textView.font = UIFont.systemFont(ofSize: 14)
        
        return textView
    }()
    
    let returnCheckBox : Checkbox = {
        let tickBox = Checkbox(frame: CGRect(x: 30, y: 160, width: 25, height: 25))
        tickBox.borderStyle = .square
        tickBox.checkmarkStyle = .tick
        tickBox.checkedBorderColor = .lightGray
        tickBox.checkmarkSize = 0.7
        tickBox.checkmarkColor = .darkGray
        tickBox.checkedBorderColor = .darkGray
        tickBox.valueChanged = { (value) in
            print("tickBox value change: \(value)")
        }
        return tickBox
    }()
    
    let exchangeCheckBox : Checkbox = {
        let tickBox = Checkbox(frame: CGRect(x: 30, y: 160, width: 25, height: 25))
        tickBox.borderStyle = .square
        tickBox.checkmarkStyle = .tick
        tickBox.checkedBorderColor = .lightGray
        tickBox.checkmarkSize = 0.7
        tickBox.checkmarkColor = .darkGray
        tickBox.checkedBorderColor = .darkGray
        tickBox.valueChanged = { (value) in
            print("exhange  value change: \(value)")
        }
        return tickBox
    }()
    
    ///Submit Buttons
    var submitItemButton : CustomButton =  {
        let button  = CustomButton(title: "List Item", hasBackground: true, fontType: .medium)
        return button
    }()
    var saveItemButton : CustomButton =  {
        let button  = CustomButton(title: "Save As Draft", hasBackground: true, fontType: .medium)
        return button
    }()
    
    
    //MARK: SUPPORT
    var activateCountryTextField : CustomTextField?
    
    //MARK: DROPDOWN
    
    lazy var menuVC: DropdownMenuController = {
           let dropdown = DropdownMenuController()
            dropdown.modalPresentationStyle = .popover
            dropdown.items = ["64ca8a8b9ecb2a6823af6030", "Eletronics", "Smarthphone"] // The items in the dropdown
            dropdown.selectedItem = { item in
                    print(item)
                    self.categoriesView.setNewValueForLabel(item)
        
            }
           return dropdown
       }()
    
    lazy var conditionMenu: DropdownMenuController = {
            let dropdown = DropdownMenuController()
            dropdown.modalPresentationStyle = .popover
            dropdown.items = ["New", "Used"]
            dropdown.selectedItem = { item in
                    print(item)
                    self.conditionView.setNewValueForLabel(item)
        
            }
            return dropdown
    }()
    
    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor =  .systemBackground
        //Navigation bar
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title  = "List Item"
        //Set Up the text for return policies and
        self.returnPoliciesView.text =  GlobalTexts.returnPolicies
        //Image actions
        addImageButton.addTarget(self, action: #selector(handleAddImage), for: .touchUpInside)
        submitItemButton.addTarget(self, action: #selector(createProduct), for: .touchUpInside)
        
        
       
        setupPickerView()
        setUpDelegate()
        setImageCollectionView()
        setupUI()
    }
    
    //MARK: - SET UP DELETEGATE
    private func setUpDelegate(){
        //Textfield
        originCountryTextField.delegate = self
        destinationCountryTextField.delegate = self
        titleTextField.delegate = self
        //TextView
        descriptionLabeledTexView.textView.delegate = self
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        
        //ScrollView
        view.addSubview(containerScrollView)
        containerScrollView.addSubview(contentView)
        containerScrollView.topAnchor.constraint(equalTo:  view.safeAreaLayoutGuide.topAnchor).isActive = true
        containerScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        containerScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        containerScrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.leadingAnchor.constraint(equalTo: containerScrollView.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: containerScrollView.trailingAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: containerScrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: containerScrollView.bottomAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: containerScrollView.widthAnchor).isActive = true
        //Others
        contentView.addSubview(titleTextField)
        contentView.addSubview(imageCollectionView)
        contentView.addSubview(addImageButton)
        contentView.addSubview(categoriesView)
        contentView.addSubview(conditionView)
        contentView.addSubview(descriptionLabeledTexView)
        let princeAndConditionStackView =  createStackView(with: [priceTextField, quantiyTextField], axis: .horizontal, spacing: 20, distribution: .fillEqually, alignment: .fill)
        contentView.addSubview(princeAndConditionStackView)
        
        //Variations
        contentView.addSubview(variationLabel)
        contentView.addSubview(swittchVariant)
        contentView.addSubview(addVariantButton)
        contentView.addSubview(variantView)
        //Personalization
        contentView.addSubview(personalizationLabel)
        contentView.addSubview(personalizationTextView)
        
        
        //Processing
        //
        //        let width = self.view.frame.width / 2
        //        let height: CGFloat = 40
        //        let spacing: CGFloat = 20
        
        originCountryTextField.widthAnchor.constraint(equalToConstant: self.view.frame.width / 2 ).isActive = true
        destinationCountryTextField.widthAnchor.constraint(equalToConstant: self.view.frame.width / 2 ).isActive = true
        timeProcessingView.widthAnchor.constraint(equalToConstant: self.view.frame.width / 2 ).isActive = true
        timeStandardDelivery.widthAnchor.constraint(equalToConstant: self.view.frame.width / 2 ).isActive = true
        timeViewInternationalDelivery.widthAnchor.constraint(equalToConstant: self.view.frame.width / 2 ).isActive = true
        
        let delivery1sStackView =  self.createStackView(with: [originCountryLabel, originCountryTextField] , axis: .horizontal, spacing: 20)
        let delivery2sStackView =  self.createStackView(with: [destinationCountryLabel, destinationCountryTextField],  axis: .horizontal, spacing: 20)
        let processingStackView = self.createStackView(with: [processingTimeLabel, timeProcessingView ],  axis: .horizontal, spacing: 20)
        let standardDeliveryStackView = self.createStackView(with: [standardDeliveryLabel, timeStandardDelivery ],  axis: .horizontal, spacing: 20)
        let internationalDeliveryStackView = self.createStackView(with: [internationalDeliveryLabel, timeViewInternationalDelivery ],  axis: .horizontal, spacing: 20)
        
        delivery1sStackView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        delivery2sStackView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        processingStackView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        standardDeliveryStackView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        internationalDeliveryStackView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        let mainStack  = self.createStackView(with: [delivery1sStackView, delivery2sStackView, processingStackView, standardDeliveryStackView, internationalDeliveryStackView], axis: .vertical, spacing: 20)
        contentView.addSubview(processingLabel)
        contentView.addSubview(mainStack)
        
        //Return and exhange
        contentView.addSubview(returnPoliciesLabel)
        contentView.addSubview(returnPoliciesView)
        returnCheckBox.heightAnchor.constraint(equalToConstant: 20).isActive = true
        returnCheckBox.widthAnchor.constraint(equalToConstant: 20).isActive = true
        exchangeCheckBox.heightAnchor.constraint(equalToConstant: 20).isActive = true
        exchangeCheckBox.widthAnchor.constraint(equalToConstant: 20).isActive = true
        let returnCheckBoxStackView  = self.createCheckBox(with: returnCheckBox, labelText: "Return")
        let exchangeCheckBoxStackView  = self.createCheckBox(with: exchangeCheckBox, labelText: "Exchange")
        let exchangeAndReturnsStack  = createStackView(with: [returnCheckBoxStackView, exchangeCheckBoxStackView], axis: .horizontal, spacing: 10, alignment: .center  )
        
        contentView.addSubview(exchangeAndReturnsStack)
        
        let submitBUttonStackView  =  createStackView(with: [saveItemButton, submitItemButton], axis: .horizontal, spacing: 20, distribution: .fillEqually, alignment: .fill
        )
        contentView.addSubview(submitBUttonStackView)
        
        
        //CONSTRAINTS
        categoriesView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDropDownCategory)))
        conditionView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDropDownCondition)))
        titleTextField.anchor( top: contentView.layoutMarginsGuide.topAnchor, left: contentView.leadingAnchor, right: contentView.trailingAnchor, bottom: nil, paddingTop: 10, paddingLeft: 5,paddingRight: -5, paddingBottom: 0, width: nil, height: 30)
        imageCollectionView.backgroundColor =  .cyan
        imageCollectionView.anchor( top: titleTextField.bottomAnchor , left: contentView.leadingAnchor, right: contentView.trailingAnchor, bottom: nil, paddingTop: 10, paddingLeft: 0,paddingRight: 0, paddingBottom: 0, width: nil, height: self.view.frame.width)
        
        addImageButton.anchor( top: imageCollectionView.bottomAnchor, left:  nil, right:  nil, bottom: nil, paddingTop: 15, paddingLeft: 0,paddingRight: 0, paddingBottom: 0, width: self.view.frame.width / 2, height: nil)
        addImageButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        categoriesView.anchor( top: addImageButton.bottomAnchor , left: contentView.leadingAnchor, right: contentView.trailingAnchor, bottom: nil, paddingTop: 10, paddingLeft: 0,paddingRight: 0, paddingBottom: 0, width: nil, height: 40)
        
        conditionView.anchor( top: categoriesView.bottomAnchor , left: contentView.leadingAnchor, right: contentView.trailingAnchor, bottom: nil, paddingTop: -1, paddingLeft: 0,paddingRight: 0, paddingBottom: 0, width: nil, height: 40)
        
        descriptionLabeledTexView.anchor( top: conditionView.bottomAnchor , left: contentView.leadingAnchor, right: contentView.trailingAnchor, bottom: nil, paddingTop: 20, paddingLeft: 10,paddingRight:-10, paddingBottom: 0, width: nil, height: 200)
        
        princeAndConditionStackView.anchor( top: descriptionLabeledTexView.bottomAnchor , left: contentView.leadingAnchor, right: contentView.trailingAnchor, bottom: nil, paddingTop: 20, paddingLeft: 10,paddingRight:-10, paddingBottom: 0, width: nil, height: 50)
        
        variationLabel.anchor( top: princeAndConditionStackView.bottomAnchor , left: contentView.leadingAnchor, right: nil, bottom: nil, paddingTop: 20, paddingLeft: 10,paddingRight: 0, paddingBottom: 0, width: nil, height: 30)
        
        swittchVariant.anchor( top: princeAndConditionStackView.bottomAnchor , left: variationLabel.trailingAnchor, right: nil, bottom: nil, paddingTop: 20, paddingLeft: 5,paddingRight: 0, paddingBottom: 0, width: nil, height: 30)
        swittchVariant.centerYAnchor.constraint(equalTo: variationLabel.centerYAnchor).isActive = true
        
        addVariantButton.anchor( top: princeAndConditionStackView.bottomAnchor , left: nil, right: contentView.trailingAnchor, bottom: nil, paddingTop: 20, paddingLeft: 0,paddingRight: -10, paddingBottom: 0, width: self.view.frame.width / 3, height: 30)
        addVariantButton.centerYAnchor.constraint(equalTo: variationLabel.centerYAnchor).isActive = true
        
        variantView.anchor( top: variationLabel.bottomAnchor , left: contentView.leadingAnchor, right: contentView.trailingAnchor, bottom: nil, paddingTop: 10, paddingLeft: 10,paddingRight: -10, paddingBottom: 0, width: nil, height: 200)
        
        
        personalizationLabel.anchor( top: variantView.bottomAnchor, left:  contentView.leadingAnchor, right:  nil, bottom: nil, paddingTop: 15, paddingLeft: 10,paddingRight: 0, paddingBottom: 0, width: nil, height: 30)
        
        personalizationTextView.anchor( top: personalizationLabel.bottomAnchor, left:  contentView.leadingAnchor, right:  contentView.trailingAnchor, bottom: nil, paddingTop: 10, paddingLeft: 10,paddingRight: -10, paddingBottom: 0, width: nil, height: 100)
        
        processingLabel.anchor( top: personalizationTextView.bottomAnchor, left:  contentView.leadingAnchor, right:  contentView.trailingAnchor, bottom: nil, paddingTop: 10, paddingLeft: 10,paddingRight: -10, paddingBottom: 0, width: nil, height: 30)
        
        mainStack.anchor( top: processingLabel.bottomAnchor, left:  contentView.leadingAnchor, right:  contentView.trailingAnchor, bottom: nil, paddingTop: 10, paddingLeft: 10,paddingRight: -10, paddingBottom: 0, width: nil, height: nil)
        
        
        returnPoliciesLabel.anchor( top: mainStack.bottomAnchor, left:  contentView.leadingAnchor, right:  contentView.trailingAnchor, bottom: nil, paddingTop: 30, paddingLeft: 10,paddingRight: -10, paddingBottom: 0, width: nil, height: nil)
        
        returnPoliciesView.anchor( top: returnPoliciesLabel.bottomAnchor, left:  contentView.leadingAnchor, right:  contentView.trailingAnchor, bottom: nil, paddingTop: 10, paddingLeft: 10,paddingRight: -10, paddingBottom: 0, width: nil, height: nil)
        
        exchangeAndReturnsStack.anchor( top: returnPoliciesView.bottomAnchor, left:  contentView.leadingAnchor, right:  nil, bottom: nil, paddingTop: 5, paddingLeft: 10,paddingRight: -10, paddingBottom: 0, width: self.view.frame.width / 2, height: 50)
        
        
        submitBUttonStackView.anchor( top: exchangeAndReturnsStack.bottomAnchor, left: nil, right:   nil, bottom: contentView.bottomAnchor, paddingTop: 50, paddingLeft: 0,paddingRight: 0, paddingBottom: -75, width: self.view.frame.width * (5/6), height: nil)
        submitBUttonStackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        
    }
    
    
    //Set Country picker Controller
    func setupPickerView() {
        countryPicker.delegate = self
        countryPicker.dataSource = self
        pickerContainerView = UIView(frame: CGRect(x: 0, y: self.view.frame.size.height, width: self.view.frame.size.width, height: 200))
        pickerContainerView.backgroundColor = UIColor.systemBackground
        
        pickerContainerView.addSubview(countryPicker)
        countryPicker.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            countryPicker.topAnchor.constraint(equalTo: pickerContainerView.topAnchor),
            countryPicker.leftAnchor.constraint(equalTo: pickerContainerView.leftAnchor),
            countryPicker.rightAnchor.constraint(equalTo: pickerContainerView.rightAnchor),
            countryPicker.bottomAnchor.constraint(equalTo: pickerContainerView.bottomAnchor)
        ])
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first(where: { $0.isKeyWindow }) {
            window.addSubview(pickerContainerView)
            
        }
        
    }
    
    private func setImageCollectionView(){
        imageCollectionView.dataSource = self
        imageCollectionView.delegate = self
        imageCollectionView.register(ImageListingCell.self, forCellWithReuseIdentifier: imageListingSellerIdentifier)
    }
    
    
    // MARK: - IBActions
    // Here you add all your @IBActions (functions called by UI interactions like button taps)
    @objc func handleAddImage(){
        let vc  = UIImagePickerController()
        vc.sourceType =  .photoLibrary
        vc.delegate = self
        vc.allowsEditing =  true
        self.present(vc, animated: true)
        
        
    }
    
    //Show Drop Menu
    @objc func handleDropDownCategory(){
        present(menuVC, animated: true, completion: nil)
    }
    @objc func handleDropDownCondition(){
        present(conditionMenu, animated: true, completion: nil)
    }
    
    //Switch Variant, allow to enter variant
    @objc func handleSwitchAction(sender: UISwitch){
        
        
        if sender.isOn {
            print("Turned on")
            UIApplication.shared.registerForRemoteNotifications()
            
            
        }
        else{
            UIApplication.shared.unregisterForRemoteNotifications()
            print("Turned off")
        }
    }
    
    //Open number picker controller
    @objc func didTapNumber() {
        let numbers = Array(1...10)
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first(where: { $0.isKeyWindow }) {
            let pickerHeight: CGFloat = 200
            let pickerFrame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: pickerHeight)
            let numberPickerView = NumberPickerView(numbers: numbers, frame: pickerFrame)
            numberPickerView.delegate = self
            window.addSubview(numberPickerView)
            
            // Animation
            UIView.animate(withDuration: 0.3) {
                numberPickerView.frame = CGRect(x: 0, y: window.frame.height - pickerHeight, width: window.frame.width, height: pickerHeight)
            }
        }
    }
    
    //Submit product
    @objc func createProduct (){
        //VALIDATION
        
        //Title
        guard  let title =  titleTextField.text , !title.isEmpty else {
            AlertManager.showProductVAlidationError(on: self, message: "Title is missing")
            return
        }
        //Images
        guard  !images.isEmpty else {
            AlertManager.showProductVAlidationError(on: self, message: "Images are missing")
            return
        }
        
        //Category
        
        guard let category  = categoriesView.getValue() else {
            AlertManager.showProductVAlidationError(on: self, message: "Select Category")
            return
        }
        
        //Condition
        guard let condition  = conditionView.getValue() else {
            AlertManager.showProductVAlidationError(on: self, message: "Select Condition")
            return
        }
        //Description
        
        guard let description =  descriptionLabeledTexView.textView.text , !description.isEmpty else {
            AlertManager.showProductVAlidationError(on: self, message: "Description is missing")
            return
        }
        
        
        //Price
        
        guard let price  = priceTextField.textField.text , !price.isEmpty else  {
            AlertManager.showProductVAlidationError(on: self, message: "Price is missing")
            return
        }
        guard let price =  Double(price) else {
            AlertManager.showProductVAlidationError(on: self, message: "Price is invalid")
            return
        }
        
        
        
        
        //Quantity
        guard let quantity  = quantiyTextField.textField.text , !quantity.isEmpty else  {
            AlertManager.showProductVAlidationError(on: self, message: "Quantity is missing")
            return
        }
        guard let quantity =  Int(quantity) else {
            AlertManager.showProductVAlidationError(on: self, message: "Quantiy is invalid")
            return
        }
        
        //Variations - Optional
        
        
        
        //Personalization
        guard  let personalizationInStructions =  personalizationTextView.textView.text else {
            AlertManager.showProductVAlidationError(on: self, message: "Personalization is missing ")
            return
        }
        
        //Delivery & Production - INternal Delivery Optional
        guard let originCountry  =  originCountryTextField.text else {
            AlertManager.showProductVAlidationError(on: self, message: "Origin Country is missing ")
            return
            
        }
        
        guard let destinationCountry  = destinationCountryTextField.text else {
            AlertManager.showProductVAlidationError(on: self, message: "Destination Country is missing ")
            return
        }
        
        guard let minProcessingTime =  timeProcessingView.minTextField.text, !minProcessingTime.isEmpty else {
            AlertManager.showProductVAlidationError(on: self, message: "Min Processing Time is missing ")
            return
        }
        guard let minProcessingTime = Int(minProcessingTime) else {
            AlertManager.showProductVAlidationError(on: self, message: "Min Processing Time is invalid ")
            return
        }
        
        guard let maxProcessingTime =  timeProcessingView.maxTextfield.text, !maxProcessingTime.isEmpty else {
            AlertManager.showProductVAlidationError(on: self, message: "Min Processing Time is missing ")
            return
        }
        guard let maxProcessingTime = Int(maxProcessingTime) else {
            AlertManager.showProductVAlidationError(on: self, message: "Max Processing Time is invalid ")
            return
        }
        
        
        guard let minDeliveryTime =  timeStandardDelivery.minTextField.text, !minDeliveryTime.isEmpty else {
            AlertManager.showProductVAlidationError(on: self, message: "Min Delivery  Time is missing ")
            return
        }
        guard let minDeliveryTime = Int(minDeliveryTime) else {
            AlertManager.showProductVAlidationError(on: self, message: "Min Delivery time Time is invalid ")
            return
        }
        
        guard let maxDeliveryTime =  timeProcessingView.maxTextfield.text, !maxDeliveryTime.isEmpty else {
            AlertManager.showProductVAlidationError(on: self, message: "Max Deliery  Time is missing ")
            return
        }
        guard let maxDeliveryTime = Int(maxDeliveryTime) else {
            AlertManager.showProductVAlidationError(on: self, message: "Max Delivery Time is invalid ")
            return
        }
        
        
        
        let minInternational = timeViewInternationalDelivery.minTextField.text!
        let maxInternational =  timeViewInternationalDelivery.maxTextfield.text!
        
        guard let minInternational  = Int(minInternational), let maxInternational = Int(maxInternational) else {
            
            AlertManager.showProductVAlidationError(on: self, message: "Max International Time is invalid ")
            return
            
        }
        
        
        //Return & Exchange Policy Acceptance
        
        
        let standardProcessing  = ProcessingTime(min: minDeliveryTime, max: maxDeliveryTime)
        let internationaProcessing   =  ProcessingTime(min: minInternational, max: maxInternational)
        
        let standardDelivery = Delivery(deliveryTime: standardProcessing, available: true)
        let internationalDelivery = Delivery(deliveryTime: standardProcessing, available: true)
        let processingTimeProduction =  ProcessingTime(min: minProcessingTime, max: maxProcessingTime)
        
        let shippingInfo  = ShippingInfo(processingTime: processingTimeProduction, originCountry: originCountry, destinationCountry: destinationCountry, internationalDelivery: internationalDelivery, standardDelivery: standardDelivery)
        
        let customizationOptions =  CustomizationOptionListing(field: "Personalization", instructions: personalizationInStructions, customizationType: "Text")
        
        

        
        //CREATE THE PRODUCT
        let product  = ProductListing(title: title, description: description, price: price, quantity: quantity, category_id: category, customizationOptions: [customizationOptions], images: ["https://i.pinimg.com/originals/0a/31/79/0a3179547dcda386369a632f9f8a7ee4.jpg"], condition: condition, hasVariations: false, variations: nil, shippingInfo: shippingInfo, returnPolicy: true, shippingPolicy: true)
        
        
        
        //NETWWORK CALL + REDIRECT TO MANAGE LISTING PAGE
        
        Service.shared.createProduct(product, expecting: ApiResponse<Product>.self, completion: { [weak self] result in
            
            guard let self  = self else {
                return
            }
            switch result {
            case .success(let response):
                print(response)
                DispatchQueue.main.async {
                    let vc =  ManageListingController()
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            case .failure(let error):
                print(error)
            }
        })
        
        
        
        
        
        
        
        
        
        
    }
    
}


extension AddListingViewController{
    
    //MARK: - HELPER FUNCTION
    
    ///Create a checkbox with label
    func createCheckBox (with checkbox : Checkbox, labelText : String) -> UIStackView{
        let label =  UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 13)
        label.text =  labelText
        let stackView = self.createStackView(with: [checkbox, label], axis: .horizontal, spacing: 5, distribution: .fillProportionally, alignment: .fill)
        
        return stackView
        
    }
    
    ///Create a stackView
    func createStackView(with views: [UIView], axis: NSLayoutConstraint.Axis = .vertical, spacing: CGFloat = 0, distribution: UIStackView.Distribution = .fill , alignment: UIStackView.Alignment = .fill) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: views)
        stackView.axis = axis
        stackView.spacing = spacing
        stackView.distribution = distribution
        stackView.alignment = alignment
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }
    
    ///Create Constrainsted stackview- not working
    func createConstrainedStackView(with views: [UIView], axis: NSLayoutConstraint.Axis, spacing: CGFloat, width: CGFloat, height: CGFloat) -> UIStackView {
        views.forEach {
            $0.widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        let stackView = createStackView(with: views, axis: axis, spacing: spacing)
        stackView.heightAnchor.constraint(equalToConstant: height).isActive = true
        
        return stackView
    }
    
    
}

///Textfield
extension AddListingViewController : UITextFieldDelegate{
    // MARK: - UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
//        if textField == titleTextField {
//            // Handle return key press for name field
//            textField.resignFirstResponder()
//        }
//        // Handle for other fields...
//
        return true
    }
}

///Collection View For Images
extension AddListingViewController : UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        return  images.count == 0 ? 1 : images.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //User NOrmal cell
        
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: imageListingSellerIdentifier, for: indexPath) as! ImageListingCell
        if images.count != 0 {
            cell.mainImage.image = images[indexPath.row]
            cell.delegate = self
        }
        
        
        
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width, height: self.view.frame.width )
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
    
}

///Photo Image Controller
extension AddListingViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        
        
        if let pickedImage = info[.editedImage] as? UIImage {
            // Add the selected image to your images array
            let squareImage = cropToBounds(image: pickedImage, width: Double(pickedImage.size.width), height: Double(pickedImage.size.width))
            images.append(squareImage)
            
            // Reload the collection view
            imageCollectionView.reloadData()
            
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



///Photo ios 14
extension AddListingViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        dismiss(animated: true, completion: nil)
        
        for result in results {
            result.itemProvider.loadObject(ofClass: UIImage.self) { [weak self] object, error in
                if let image = object as? UIImage {
                    DispatchQueue.main.async {
                        // Add the selected image to your images array
                        self?.images.append(image)
                        
                        // Reload the collection view
                        self?.imageCollectionView.reloadData()
                    }
                }
            }
        }
    }
}

///Create Listing
extension AddListingViewController :  CreateListingDelegate{
    func didTapCell(_ cell: UICollectionViewCell) {
        if let indexPath  = imageCollectionView.indexPath(for: cell){
            images.remove(at: indexPath.row)
            // Now delete the item from your UICollectionView.
            imageCollectionView.performBatchUpdates({
                imageCollectionView.deleteItems(at: [indexPath])
            }, completion: nil)
        }
        
    }
    
    
}


///Picker controller for countries
extension AddListingViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.activateCountryTextField = textField as? CustomTextField
        if textField == originCountryTextField || textField == destinationCountryTextField {
            textField.resignFirstResponder()
            UIView.animate(withDuration: 0.3, animations: {
                self.pickerContainerView.frame.origin.y -= self.pickerContainerView.frame.size.height
            })
        }
        
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.isFirstResponder{
            pickerView.endEditing(true)
        }
        activateCountryTextField?.text = GlobalArrays.countries[row].0// Store the country code
        UIView.animate(withDuration: 0.3, animations: {
            self.pickerContainerView.frame.origin.y += self.pickerContainerView.frame.size.height
        })
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return GlobalArrays.countries[row].0  // Show the country name and flag
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return GlobalArrays.countries.count
    }
    
    
}

///Picker controller  for number
extension AddListingViewController : NumberPickerDelegate {
    func didSelectNumber(_ number: Int) {
        print(number)
    }
}


///Text View delegate
extension AddListingViewController : UITextViewDelegate {}
