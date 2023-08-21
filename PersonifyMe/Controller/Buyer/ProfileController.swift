//
//  ProfileController.swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 08/08/2023.
//

import Foundation


import UIKit

class ProfileController: UIViewController {
    
    
    var paymentMethods : [PaymentMethod] = []{
        didSet{
            DispatchQueue.main.async {
                self.collectionViewPayment.reloadData()
            }
        }
    }
    
    var user : User? {
        didSet{
            DispatchQueue.main.async {
                guard let user = self.user else {return}
                self.topPart.fullNameLabel.text = user.name
                self.topPart.countryLabel.text =  user.country
                self.topPart.emailLabel.text =  user.email
                if let imageUlr  =  user.image{
                    self.topPart.mainImage.loadImageUrlString(urlString: imageUlr)
                }
             
            }
          
        }
    }
    
    //MARK: -IDENTIFIER
    
    let shippingCellIdentifier = "shippingCellIdentifier"
    let paymentCellIdentifier = "paymentCellIdentifier"
    
    let shippingHeaderIdentifier = "shippingHeaderIdentifier"
    let paymentHeaderIdentifier = "paymentHeaderIdentifier"
    
    let generalKind  = "generalKind"
    
    
    
    
    
    // MARK: - Components
    // Here you add all components
    let label : UILabel  =  {
        let label = UILabel()
        label.text  =  "Something"
        return label
    }()
    
    
    let topPart : ProfileTopPart =  {
        let view = ProfileTopPart()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let orderPart : ProfileOrders = {
        let view = ProfileOrders()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let collectionViewShipping : UICollectionView =  {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout )
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false

        return collectionView
    }()
    
    let collectionViewPayment : UICollectionView =  {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout )
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .systemBackground
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isScrollEnabled = true
        

        return collectionView
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
    
    let signOutButton : CustomButton = {
        let button = CustomButton(title: "Sign Out", hasBackground: true, fontType: .medium)
        return button
    }()
    
    // MARK: - Properties
    // All properties and variables you need in your ViewController
    
    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor  = .systemBackground
        topPart.delegate = self
        signOutButton.addTarget(self, action: #selector(handleSignOut), for: .touchUpInside)
        setUpNavigationBar()
        setUpCollectionView()
        setupUI()
        fecthUserDetails()
        fetchPaymentMethod()
    }
    
    @objc func handleSignOut(){
        print("Sign out")
        Service.shared.logout(expecting: ApiResponse<String>.self) { [weak self] result in
            switch result{
            case .success(_):
                print("Success in logout")
                AuthManager.clearUserDefaults()
                AlertManager.showLogoutAlert(on: self!)
            case .failure(let error):
                ErrorManager.handleServiceError(error, on: self)
            }
            
        }
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        // Set up all UI elements here
        
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
        
        
        contentView.addSubview(topPart)
        
        topPart.anchor( top: contentView.topAnchor, left: contentView.leadingAnchor, right: contentView.trailingAnchor, bottom: nil, paddingTop: 0, paddingLeft: 0,paddingRight: 0, paddingBottom: 0, width: nil, height: nil)
        
        contentView.addSubview(orderPart)
        orderPart.anchor( top:  topPart.bottomAnchor, left: contentView.leadingAnchor, right: contentView.trailingAnchor, bottom: nil, paddingTop: 20, paddingLeft: 0,paddingRight: 0, paddingBottom: 0, width: nil, height: nil)
        
        contentView.addSubview(collectionViewShipping)
        
        
        collectionViewShipping.anchor( top:  orderPart.bottomAnchor, left: contentView.leadingAnchor, right: contentView.trailingAnchor, bottom: nil, paddingTop: 20, paddingLeft: 10,paddingRight: -10, paddingBottom: 0, width: nil, height: 150)
        
        
        contentView.addSubview(collectionViewPayment)
      
        collectionViewPayment.anchor( top:  collectionViewShipping.bottomAnchor, left: contentView.leadingAnchor, right: contentView.trailingAnchor, bottom: nil, paddingTop: 20, paddingLeft: 10,paddingRight: -10, paddingBottom: 0, width: nil, height: 120)
        
        contentView.addSubview(signOutButton)
        signOutButton.anchor( top:  collectionViewPayment.bottomAnchor, left: contentView.leadingAnchor, right: contentView.trailingAnchor, bottom: contentView.bottomAnchor, paddingTop: 20, paddingLeft: 10,paddingRight: -10, paddingBottom: -10, width: nil, height: 40)
        
        
    
        
    }
    
    
    func fecthUserDetails(){
        Service.shared.getCurrentDetails(expecting: ApiResponse<User>.self) { [weak self] result in
            
            guard let self = self else {return}
            switch result{
                
            case .success(let response):
                guard let user = response.data else {return}
                self.user = user
            case .failure(_):
                print("Failure getting the suer in the profile controller ")
            }
        }
    }
    
    private func setUpNavigationBar (){
        //IMAGE BAR BUTTON
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.title =  "My Profile"
        let settingButton  = UIBarButtonItem(image: UIImage(systemName: "gearshape"), style: .plain, target: self, action: #selector(handleSetting))
        
        self.navigationItem.rightBarButtonItem = settingButton
        
        
    }
    
    
    private func setUpCollectionView(){
        
    
     
     
        
        collectionViewShipping.delegate = self
        collectionViewShipping.dataSource = self
        collectionViewShipping.register(ProfileShippingCell.self, forCellWithReuseIdentifier: shippingCellIdentifier)
        collectionViewShipping.register( ProfileCollectionViewHeader.self, forSupplementaryViewOfKind:  UICollectionView.elementKindSectionHeader, withReuseIdentifier: "ship")
        
        collectionViewPayment.delegate = self
        collectionViewPayment.dataSource = self
        collectionViewPayment.register(ProfilePaymentCell.self, forCellWithReuseIdentifier: paymentCellIdentifier)
      
        collectionViewPayment.register( ProfileCollectionViewHeader.self, forSupplementaryViewOfKind:  UICollectionView.elementKindSectionHeader, withReuseIdentifier: "pay")
    
                                        
        
                                        
    }
    
    func fetchPaymentMethod (){
        Service.shared.getSavedPaymentMethods(expecting: ApiResponse<[PaymentMethod]>.self) { [weak self]  result in
            guard let self =  self else {return}
            switch result{
                
            case .success(let response ):
                guard let methods  = response.data else {return}
                self.paymentMethods = methods
            case .failure(_):
                print("Erorr getting payment")
            }
        }
    }
    
    
    // MARK: - IBActions
    // Here you add all your @IBActions (functions called by UI interactions like button taps)
    
    @objc func handleSetting(){
        print("Setting ")
        guard let user  = user  else {return}
        
        let vc = SettingViewController(user: user )
        vc.delegate = self

        self.present(vc, animated: true)
    }
    
    // MARK: - Navigation
    // Segue preparations and related stuff
    
    // MARK: - Private methods
    // All other functions that you use within the ViewController
    
    private func createImageStacker (imageName : String, title : String) -> UIStackView {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: imageName)
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .gray
        imageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        
        let label = UILabel()
        label.text = title
        label.font = UIFont.systemFont(ofSize: 14)
        
        let stackView = StackManager.createStackView(with: [imageView, label], axis: .vertical, spacing: 4, distribution: .fillEqually, alignment: .center)
    
        return stackView
    }
    
    
        
    
}



extension ProfileController : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
          if collectionView == collectionViewShipping {
              return 10
          }else if  collectionView == collectionViewPayment {
              return paymentMethods.count
          }
            return 10
        
      }
      
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collectionViewShipping {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: shippingCellIdentifier, for: indexPath) as! ProfileShippingCell
            return cell
            
        }else if  collectionView == collectionViewPayment {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: paymentCellIdentifier, for: indexPath) as! ProfilePaymentCell
             let paymethod  = paymentMethods[indexPath.row]
            cell.paymentMethod =  paymethod
        
          
            return cell
        }
        
        
        
        return UICollectionViewCell()
    }
//          } else {
//              let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell2", for: indexPath)
//              cell.backgroundColor = .blue
//              return cell
//          }
      
    

      
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
//        return  CGSize(width: collectionView.frame.width, height: 50)
//
//    }
//
//    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//
//        if kind == UICollectionView.elementKindSectionHeader {
//
//
//            if collectionView == collectionViewShipping {
//                let headerView = collectionView.dequeueReusableSupplementaryView(ofKind:  UICollectionView.elementKindSectionHeader, withReuseIdentifier: "ship", for: indexPath) as! ProfileCollectionViewHeader
//                headerView.label.text = "Shipping Addresses"
//                return headerView
//            } else if collectionView == collectionViewPayment {
//                let headerView = collectionView.dequeueReusableSupplementaryView(ofKind:  UICollectionView.elementKindSectionHeader, withReuseIdentifier: "pay", for: indexPath) as! ProfileCollectionViewHeader
//                headerView.label.text = "Payments"
//                return headerView
//
//            }
//
//        }
//        return UICollectionReusableView()
//    }

    
      func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
          if collectionView == collectionViewShipping {
              return CGSize(width: collectionView.frame.width  * 2/3 , height: collectionView.frame.height) // Provide desired item size
          }else if  collectionView == collectionViewPayment {
              return CGSize(width: collectionView.frame.width  * 2/3 , height: 100) // Provide desired item size
          }
          return CGSize(width: collectionView.frame.width, height: collectionView.frame.width)
            
      }
    
}


extension ProfileController : SettingViewControllerDelegate{
    func updateUser(with updatedUser: User) {
        print("The update user")
       
        Service.shared.updateCurrentUser(with: updatedUser, expecting: ApiResponse<User>.self) { [weak self] result in
            guard let self = self else {return}
            switch result{
                
            case .success(let response):
                guard let responseUser = response.data else {return}
                
                self.user = responseUser
                
            case .failure(_):
                print("Updating the user")
            }
        }
        
      
        
    }
    
    
}

extension ProfileController: ProfileTopPartDelegate{
    func didTapWishList() {
        print("Tap")
    }
    
    func didTapShop() {
        print("Tap")
    }
    
    func didTapReviews() {
        print("Tap")
        let vc =  AllReviewController(typeReview: .user_logged, reviews: nil, sellerId: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func didTapMessage() {
        print("Tap")
    }
    
    
}
