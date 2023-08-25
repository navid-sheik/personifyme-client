//
//  OnBoardingLaunch.swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 29/07/2023.
//

import Foundation


//
//  PersonifyMe
//
//  Created by Navid Sheikh on 27/07/2023.
//

import Foundation


import UIKit
import SafariServices

protocol OnBoardingLaunchViewControllerDelegate: class {
    func updateTabController(onBoardingData: OnBoardingData)
}
class OnBoardingLaunchViewController: RestrictedController, UITextFieldDelegate {
    
    // MARK: - Components
    // Here you add all components
    
    weak var delegate : OnBoardingLaunchViewControllerDelegate?
    
    
    public let identifierBoarding = "OnBoardingLaunchViewController"
    let promos = [
        PromoModel(title: "Smooth Payments", description: "Fast and easy payment process. Earn without hassle!", imageName: "onBoarding1"),
        PromoModel(title: "Simple KYC", description: "Quick, easy KYC steps. Your security matters.", imageName: "onBoarding1"),
        PromoModel(title: "Find Gift Seekers", description: "Reach a sea of buyers seeking unique gifts.", imageName: "onBoarding1"),
        PromoModel(title: "Manage Orders Easily", description: "User-friendly system to track and manage orders.", imageName: "onBoarding1"),
        PromoModel(title: "Effortless Listings", description: "Manage your items with our easy listing tool.", imageName: "onBoarding1"),
        PromoModel(title: "Swift Payouts", description: "Get your earnings fast, without the wait.", imageName: "onBoarding1"),
        PromoModel(title: "Low Fees", description: "Enjoy more earnings with our minimal fees.", imageName: "onBoarding1"),
        PromoModel(title: "Messaging System", description: "Connect with buyers easily within our platform.", imageName: "onBoarding1"),
        PromoModel(title: "Customized Focus", description: "Shine with your personalized items in our exclusive marketplace.", imageName: "onBoarding1")
    ]

    
    let countries = [
        ("🇦🇺 Australia", "AU"),
        ("🇦🇹 Austria", "AT"),
        ("🇧🇪 Belgium", "BE"),
        ("🇧🇷 Brazil", "BR"),
        ("🇧🇬 Bulgaria", "BG"),
        ("🇨🇦 Canada", "CA"),
        ("🇨🇾 Cyprus", "CY"),
        ("🇨🇿 Czech Republic", "CZ"),
        ("🇩🇰 Denmark", "DK"),
        ("🇪🇪 Estonia", "EE"),
        ("🇫🇮 Finland", "FI"),
        ("🇫🇷 France", "FR"),
        ("🇩🇪 Germany", "DE"),
        ("🇬🇷 Greece", "GR"),
        ("🇭🇰 Hong Kong", "HK"),
        ("🇭🇺 Hungary", "HU"),
        ("🇮🇳 India", "IN"),
        ("🇮🇪 Ireland", "IE"),
        ("🇮🇹 Italy", "IT"),
        ("🇯🇵 Japan", "JP"),
        ("🇱🇻 Latvia", "LV"),
        ("🇱🇹 Lithuania", "LT"),
        ("🇱🇺 Luxembourg", "LU"),
        ("🇲🇹 Malta", "MT"),
        ("🇲🇽 Mexico", "MX"),
        ("🇳🇱 Netherlands", "NL"),
        ("🇳🇿 New Zealand", "NZ"),
        ("🇳🇴 Norway", "NO"),
        ("🇵🇱 Poland", "PL"),
        ("🇵🇹 Portugal", "PT"),
        ("🇷🇴 Romania", "RO"),
        ("🇸🇬 Singapore", "SG"),
        ("🇸🇰 Slovakia", "SK"),
        ("🇸🇮 Slovenia", "SI"),
        ("🇪🇸 Spain", "ES"),
        ("🇸🇪 Sweden", "SE"),
        ("🇨🇭 Switzerland", "CH"),
        ("🇹🇭 Thailand", "TH"),
        ("🇬🇧 United Kingdom", "GB"),
        ("🇺🇸 United States", "US")
    ]
    
    var currentIndex = 0
    var timer: Timer?
    var pickerContainerView = UIView()
    
    
    
    
    var items = ["Item 1", "Item 2", "Item 3", "Item 4", "Item 5"] // Sample items
    
    
    let titleLabel : UILabel = {
        let label = UILabel()
        label.text = "Join Seller Programme"
        label.font =  UIFont.boldSystemFont(ofSize: 28)
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    
    let scrollableCollectionView : UICollectionView = {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.scrollDirection = .horizontal
        collectionViewLayout.minimumLineSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.decelerationRate = .normal  // makes scrolling smoother
        
        return collectionView
        
        
    }()
    
    
    let becomeSellerButton : CustomButton = {
        let button  = CustomButton(title: "Become Seller",hasBackground: true  ,fontType: .medium)
        return button
    }()
    
    
    let warningLabel :  UILabel = {
        let label  = UILabel()
        label.text =  "By proceeding, I acknowledge and agree to the terms and conditions. I understand that once I set my bank's country, it cannot be changed."
        label.numberOfLines = 0
        label.textColor =  .lightGray
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font =  UIFont.systemFont(ofSize: 10)
        
        
        return label
    }()
    
    let countryPicker = UIPickerView()
    
    let countryTextField : CustomTextField = {
        let textField = CustomTextField(fieldType: .custom)
        textField.placeholder = "Select your bank's country"
        textField.layer.cornerRadius =  2
        return textField
    }()
    
    
    
    // MARK: - Properties
    // All properties and variables you need in your ViewController
    
    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        navigationController?.navigationBar.isHidden =  true
    

    }
    
   
    
    override func setupAuthenticatedUI() {
        super.setupAuthenticatedUI()
        
        if  let seller_id  = UserDefaults.standard.object(forKey: "seller_id") as? String{
            
            Service.shared.getSellerOnBoardingStatus(expecting: ApiResponse<OnBoardingData>.self) { [weak self] result in
                switch result{
                    
                    
                case .success(let response):
                    guard let infoData = response.data else {return}
                    DispatchQueue.main.async {  [weak self]  in
                  
                        self?.delegate?.updateTabController(onBoardingData: infoData)
                       
                       
                        
                    }
                    
                case .failure(_):
                    print("Seller doesn't existing continue to the onboarding")
                    
                }
                
            }
            
            
        }
        
        

        
        
        countryTextField.delegate = self
        
//        pickerContainerView.layer.borderColor = UIColor.black.cgColor
//        pickerContainerView.layer.borderWidth = 1
        setupUI()
//        countryPicker.layer.borderWidth = 1
//        countryPicker.layer.borderColor = UIColor.lightGray.cgColor
//        countryPicker.layer.cornerRadius = 10
//        setupPickerView()
        timer = Timer.scheduledTimer(timeInterval: 30.0, target: self, selector: #selector(autoScroll), userInfo: nil, repeats: true)
        becomeSellerButton.addTarget(self, action: #selector(handleCreatingSellerAccount), for: .touchUpInside)
       }
       
    override func teardownAuthenticatedUI() {
        super.teardownAuthenticatedUI()
       // Remove or hide UI elements that should not be visible when not authenticated
       
       // For example, remove gesture recognizers, hide certain subviews, etc.
     
       
       // Additional teardown logic as needed
    }
    
    
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        Service.shared.checkSellerStatus(expecting: SellerResponse.self) { [weak self] result in
//            switch result{
//               
//            case .success(let data):
//                let hasStartedOnboarding =  data.result.hasStartedOnboarding
//                print(hasStartedOnboarding)
//                if (hasStartedOnboarding){
//                    DispatchQueue.main.async {
//                        let linkController  =  OnBoardingLinkViewController()
//                        
//                        self?.navigationController?.pushViewController(linkController, animated: true)
//                    }
//                }
//            case .failure(let error):
//                print(error)
//                
//            }
//        }
//    }
    
    
    
    // MARK: - UI Setup
    private func setupUI() {
        // Set up all UI elements here
        view.addSubview(titleLabel)
        view.addSubview(scrollableCollectionView)
        
        view.addSubview(becomeSellerButton)
        view.addSubview(warningLabel)
        view.addSubview(countryTextField)

        countryTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        becomeSellerButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        let verticalStack  = UIStackView(arrangedSubviews: [titleLabel, scrollableCollectionView, countryTextField, becomeSellerButton])
        
        verticalStack.axis = .vertical
        verticalStack.distribution = .fill
        verticalStack.alignment = .fill
        verticalStack.spacing = 20
        verticalStack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(verticalStack)
        
        
        scrollableCollectionView.delegate = self
        scrollableCollectionView.dataSource = self
        scrollableCollectionView.register(OnBoardingCell.self, forCellWithReuseIdentifier: identifierBoarding)
        
        
//        titleLabel.anchor( top: view.layoutMarginsGuide.topAnchor, left: view.leadingAnchor, right: view.trailingAnchor, bottom: nil, paddingTop: 0, paddingLeft: 0,paddingRight: 0, paddingBottom: 0, width: nil, height: 100)
        warningLabel.anchor( top: nil, left: view.leadingAnchor, right: view.trailingAnchor, bottom: view.layoutMarginsGuide.bottomAnchor, paddingTop: 0, paddingLeft: 20,paddingRight: -20, paddingBottom: -20, width: nil, height: nil)
//
        verticalStack.anchor( top: view.layoutMarginsGuide.topAnchor, left: view.leadingAnchor, right: view.trailingAnchor, bottom: warningLabel.topAnchor, paddingTop: 20, paddingLeft: 20,paddingRight: -20, paddingBottom: -8, width: nil, height: nil)
        
       
    }
    
//    func setupPickerView() {
//
//           countryPicker.delegate = self
//        countryPicker.dataSource = self
//
//
//           pickerContainerView = UIView(frame: CGRect(x: 0, y: self.view.frame.size.height, width: self.view.frame.size.width, height: 200))
//           pickerContainerView.backgroundColor = UIColor.systemBackground
//
//
//
//           pickerContainerView.addSubview(countryPicker)
//           countryPicker.translatesAutoresizingMaskIntoConstraints = false
//           NSLayoutConstraint.activate([
//            countryPicker.topAnchor.constraint(equalTo: pickerContainerView.topAnchor),
//            countryPicker.leftAnchor.constraint(equalTo: pickerContainerView.leftAnchor),
//            countryPicker.rightAnchor.constraint(equalTo: pickerContainerView.rightAnchor),
//            countryPicker.bottomAnchor.constraint(equalTo: pickerContainerView.bottomAnchor)
//           ])
//            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
//               let window = windowScene.windows.first(where: { $0.isKeyWindow }) {
//                window.addSubview(pickerContainerView)
//                // use the window here
//        }
//
//
//       }
//
    
    // MARK: - IBActions
    // Here you add all your @IBActions (functions called by UI interactions like button taps)
    
    @objc func handleCreatingSellerAccount(){
        print("Becoming a seller")
        
       
        guard let countryText =  countryTextField.text , !countryText.isEmpty else {
            print("Please select the country")
            return
        }
        print(countryText)

        guard let countryTuple = countries.first(where: { $0.0 == countryText })  else {
            print("Please select the country")
            return
        }
        
        let countryCode =  countryTuple.1
        
        print(countryCode)
        
        Service.shared.createConnectAccount(countryCode, expecting: ApiResponse<SellerResult>.self) {  [weak self] result in
            
            guard let self = self else {
                return
            }
            switch result{
                case .success(let response):
                    
                    let success  =  response.status
//                    guard let seller  =  response.data else{
//                        print("Cannot create seller  account")
//                        return
//                    }
                
                   
                
                    if success == "success" {
                            //First time setting the seller id 
                            if  let seller_info = response.data {
                                UserDefaults.standard.set(seller_info.seller_id, forKey: "seller_id")
                            }
                    
                            self.showSeller()
                        
                        
                    }
                
                   
                        
                case .failure(let error):
                
                AlertManager.showInvalidFullNameAlert(on: self)
                
            }
            
        }
        
    }
    
    // MARK: - Navigation
    // Segue preparations and related stuff
    
    // MARK: - Private methods
    // All other functions that you use within the ViewController
    
    func showSeller() {
        print("Handle Become Seller")
        Service.shared.sendVerificationStripeLink(expecting: ApiResponse<String>.self) { [weak self]  result in
            guard let self = self else { return }
            switch result{
                
            
            case .success(let response):
                print("Success")
                print(response)
                let success  = response.status
               
                
                if (success ==  "success"){
                    DispatchQueue.main.async {
                        guard let stripeLink = response.data else { return }
                        
                        
                        guard let url = URL(string: stripeLink) else { return }
                        
                        let safariViewController = SFSafariViewController(url: url)
                        safariViewController.delegate = self
//                        let navigationController = UINavigationController(rootViewController: safariViewController)
                        

                        self.present(safariViewController, animated: true)
                    }
                    
                }else {
                    AlertManager.showUnknownFetchingUserError(on: self)
                }
              
            case .failure(let error):
                print("Error")
                print(error)
            }
        }
    }
}

extension OnBoardingLaunchViewController : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return promos.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            
        //User NOrmal cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifierBoarding, for: indexPath) as! OnBoardingCell
        cell.pageModel =  promos[indexPath.row]
        return cell
            
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width ,height: collectionView.frame.height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
    
    
    
}


extension OnBoardingLaunchViewController{
    @objc func autoScroll() {
            if self.currentIndex < self.promos.count {
                let indexPath = IndexPath(item: currentIndex, section: 0)
                self.scrollableCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
                self.currentIndex += 1
            } else {
                self.currentIndex = 0  // loop back to the first index
            }
    }
    
  
}


extension OnBoardingLaunchViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    // Invoked when the view's layout is complete
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // Initialize your pickerContainerView frame here if needed
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
        
        // Initialize picker and container here
        let countryPicker = UIPickerView()
        
        pickerContainerView = UIView(frame: CGRect(x: 0, y: self.view.frame.size.height, width: self.view.frame.size.width, height: 150))
        pickerContainerView.backgroundColor = UIColor.systemBackground
        
        countryPicker.delegate = self
        countryPicker.dataSource = self
        countryPicker.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        pickerContainerView.backgroundColor = UIColor.red
//        countryPicker.backgroundColor = UIColor.green
        
        pickerContainerView.addSubview(countryPicker)
        countryPicker.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            countryPicker.topAnchor.constraint(equalTo: pickerContainerView.topAnchor),
            countryPicker.bottomAnchor.constraint(equalTo: pickerContainerView.bottomAnchor),
            countryPicker.leadingAnchor.constraint(equalTo: pickerContainerView.leadingAnchor),
            countryPicker.trailingAnchor.constraint(equalTo: pickerContainerView.trailingAnchor)
        ])
        // Add to the view hierarchy
        self.view.addSubview(pickerContainerView)
        
        
        animatePicker(show: true)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        countryTextField.text = countries[row].0
        animatePicker(show: false)
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return countries[row].0
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return countries.count
    }
    
    // MARK: - Helper Methods
    
    private func animatePicker(show: Bool) {
        let height = pickerContainerView.frame.size.height
        UIView.animate(withDuration: 0.3, animations: { [weak self] in
            guard let self = self else { return }
            self.pickerContainerView.frame.origin.y += (show ? -height : height)
        }) { [weak self] (completed) in
            guard let self = self else { return }
            if !show {
                self.pickerContainerView.removeFromSuperview()
            }
        }
    }
}


extension OnBoardingLaunchViewController: SFSafariViewControllerDelegate {
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        // the user may have closed the SFSafariViewController instance before a redirect
        // occurred. Sync with your backend to confirm the correct state
        print("Finished")
        Service.shared.getSellerOnBoardingStatus(expecting: ApiResponse<OnBoardingData>.self) { [weak self] result in
            switch result{
                
                
            case .success(let response):
                guard let infoData = response.data else {return}
                DispatchQueue.main.async {  [weak self]  in
              
                    self?.delegate?.updateTabController(onBoardingData: infoData)
                   
                   
                    
                }
                
            case .failure(_):
                print("Error")
                
            }
            
        }
            
            
            
        
        
       

     
    
              
        
    }
    
   
//    
//    func navigateToController(){
//        let dashBoardVC  =  DashboardViewController()
//        self.navigationController?.pushViewController(dashBoardVC, animated: true)
//        
//        
//    }
    
}
