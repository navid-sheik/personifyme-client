//
//  SettingViewController.swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 08/08/2023.
//

import Foundation

import UIKit

//
//  PersonifyMe
//
//  Created by Navid Sheikh on 27/07/2023.
//

import Foundation


import UIKit


protocol SettingViewControllerDelegate : class{
    func updateUser(with updatedUser : User)
}


class SettingViewController: UIViewController {
    weak var delegate : SettingViewControllerDelegate?
    var user: User
    private var settings: [SettingOption] {
        didSet{
            print("Something")
        }
    }
    var existingImageUrl : String?
    private var userImage  : UIImage?{
        didSet{
            guard let userImage = userImage else {
                return
            }
            
            self.mainImage.image = userImage
        }
    }
    
    
    var update : Bool = false

    let settingCellIDentifier : String = "settingCellIDentifier"
    
    // MARK: - Components
    // Here you add all components
    let label : UILabel  =  {
        let label = UILabel()
        label.text  =  "Something"
        return label
    }()
    let tableViewSettings : UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor = .systemBackground
        table.separatorStyle = .none


        return table
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
 
    let contactUsButton : CustomButton = {
        let button =  CustomButton(title: "Contact Us",hasBackground: true,  fontType: .medium)
        return button
    }()
    
    let mainImage : CustomImageView  = {
        let imageView  = CustomImageView()
        imageView.image =  UIImage(named: "image-placeholder")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius =  .init(10)
        imageView.isUserInteractionEnabled = true
        imageView.clipsToBounds = true
        imageView.backgroundColor =  .init(white: 0.9, alpha: 0.5)
        return imageView
    }()

    
    // MARK: - Properties
    // All properties and variables you need in your ViewController
    
    init(user: User) {
        self.user = user
        if let imageUrl =  user.image{
            self.mainImage.loadImageUrlString(urlString: imageUrl)
            self.existingImageUrl = imageUrl
        }
        
        
        self.settings = [
            .fullName(user.name),
            .email(user.email),
            .currency("USD (Upcoming)"),
            .country(user.country),
            .primaryAddress("123 Main St, Anytown"),
            .primaryPayment("Credit Card - **** 1234"),
            .password("••••••••"),
            .pushNotification,
            .appearance,
            .aboutThisApp,
            .privacyPolicy,
            .termsOfService,
            .contactUs
        ]
        super.init(nibName: nil, bundle: nil)
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor  = .systemBackground
        saveButton.addTarget(self, action: #selector(didTapSave), for:
                .touchUpInside)
        cancelButton.addTarget(self, action: #selector(didTapCancel), for: .touchUpInside)
        mainImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapImage)))
        setUpNavigationView()
        setTableView()
        setupUI()
    }
    
    
    
    
    // MARK: - UI Setup
    private func setupUI() {
        // Set up all UI elements here
        self.view.addSubview(cancelButton)
        cancelButton.anchor(top: self.view.safeAreaLayoutGuide.topAnchor, left: self.view.leadingAnchor, right: nil, bottom: nil, paddingTop: 10, paddingLeft: 5, paddingRight: 0, paddingBottom: 0, width: 60, height: 40)
        
        
        self.view.addSubview(saveButton)
        saveButton.anchor(top: self.view.safeAreaLayoutGuide.topAnchor, left: nil, right: self.view.trailingAnchor, bottom: nil, paddingTop: 10, paddingLeft: 0, paddingRight: -5, paddingBottom: 0, width: 60, height: 40)
        view.addSubview(tableViewSettings)
        
        
        let width = self.view.frame.width / 3
        self.view.addSubview(mainImage)
        mainImage.anchor(top: saveButton.bottomAnchor, left: nil, right: nil, bottom: nil, paddingTop: 10, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: width, height: width)
        
        mainImage.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        tableViewSettings.anchor( top: self.mainImage.bottomAnchor, left: view.leadingAnchor, right: view.trailingAnchor, bottom:  view.bottomAnchor,  paddingTop: 10, paddingLeft: 0,paddingRight: 0, paddingBottom: -10, width: nil, height: nil)
        
//        view.addSubview(contactUsButton)
//        contactUsButton.anchor(top: tableViewSettings.bottomAnchor, left: view.leadingAnchor, right: view.trailingAnchor, bottom: view.bottomAnchor, paddingTop: 0, paddingLeft: 20, paddingRight: 20, paddingBottom: -30, width: nil, height: 50)
//
    
        
    }
    
    private func setUpNavigationView(){
        let barButtonItem = UIBarButtonItem(image: UIImage(systemName: "star.fill"), style: .plain, target: self, action: #selector(contactApp))
        navigationItem.rightBarButtonItem = barButtonItem
        
        
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.title = "Settings "
    }
    
    private func setTableView(){
        tableViewSettings.dataSource = self
        tableViewSettings.delegate = self
        tableViewSettings.register(SettingTableViewCell.self, forCellReuseIdentifier: "SettingCell")
        
    
//        tableViewSettings.register(BuyerOrderHeader.self, forHeaderFooterViewReuseIdentifier: settingCellIDentifier)
        
        
    }
    
    
    // MARK: - IBActions
    // Here you add all your @IBActions (functions called by UI interactions like button taps)
    
    // MARK: - Navigation
    // Segue preparations and related stuff
    
    // MARK: - Private methods
    // All other functions that you use within the ViewController
    
    @objc func didTapImage(){
        print("Edit image")
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
       
       imagePickerController.sourceType = .photoLibrary // Change to .camera to take a photo
       self.present(imagePickerController, animated: true, completion: nil)
    
    }
    @objc func contactApp(){
        print("Contact admin")
    }
    
    @objc func didTapSave(){
        if let uploadImage =  userImage{
            var base64String = uploadImage.jpegData(compressionQuality: 0.8)?.base64EncodedString()
            guard let base64 = base64String else {return}
            let newImage  =  "data:image/jpeg;base64,\(base64)"
            
           
            self.user.image = newImage
        }
        
        self.delegate?.updateUser(with: self.user)
        self.dismiss(animated: true)
    }
    
    @objc func didTapCancel(){
        self.dismiss(animated: true)
    }
    
//    func update(){
////        Service.shared.get
//
////        Service.shared.updateCurrentUser(with: user, expecting: ApiResponse<User>.self) { [weak self] result in
////
////            guard let self = self else {return}
////            switch result{
////
////            }
////        }
//
//    }
//
    
}



extension SettingViewController : UITableViewDataSource, UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           
       

        return  settings.count
       }

       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "SettingCell", for: indexPath) as! SettingTableViewCell
           
           let setting = settings[indexPath.row]
           cell.configure(with:setting)
           cell.delegate = self
           cell.selectionStyle =  .none
           return cell
       }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    

}

extension SettingViewController : SettingTableViewCellDelegate {
  
    
    func switchValueChanged(for cell: SettingTableViewCell, with settingOption: SettingOption, isOn: Bool) {
        guard let indexPath = tableViewSettings.indexPath(for: cell) else {
            print("Failed to get indexPath for cell")
            return
        }
        
        // Ensure that the indexPath.row is within the range of the settings array.
        guard indexPath.row < settings.count else {
            print("IndexPath is out of range for settings array")
            return
        }
        
        // Only update if the settingOption is .fullName
    

        let updatedName = SettingOption.fullName("Name Sheikh")
        settings[indexPath.row] = updatedName
        tableViewSettings.reloadRows(at: [indexPath], with: .automatic)
    
    }
    
    func editButtonTapped(for cell: SettingTableViewCell, with settingOption: SettingOption, value: String?) {
   
       
        guard let indexPath = tableViewSettings.indexPath(for: cell) else {
            print("Failed to get indexPath for cell")
            return
        }
        
        // Ensure that the indexPath.row is within the range of the settings array.
        guard indexPath.row < settings.count else {
            print("IndexPath is out of range for settings array")
            return
        }
        guard let value =  value else { return}
        self.update =  true
        
        switch settingOption{
            
        case .fullName(_):
//            let updatedName = SettingOption.fullName("Name Sheikh")
            self.user.name =  value
//            let updatedName = SettingOption.fullName(value)
//            settings[indexPath.row] = updatedName
//            tableViewSettings.reloadRows(at: [indexPath], with: .automatic)

            print( "The name is" ,  self.user.name)
        case .email(_):
            self.user.email =  value
        case .currency(_):
            return
//            self.user.email =  value
        case .country(_):
            self.user.country =  value

        default:
            return
        }
        
       
    
    }
   

    
    
    
    
}



extension SettingViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
  
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        
        
        if let pickedImage = info[.editedImage] as? UIImage {
            // Add the selected image to your images array
            let squareImage = cropToBounds(image: pickedImage, width: Double(pickedImage.size.width), height: Double(pickedImage.size.width))
            self.userImage =  squareImage
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



