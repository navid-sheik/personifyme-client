//
//  DashboardViewController.swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 27/07/2023.
//

//
//  PersonifyMe
//
//  Created by Navid Sheikh on 27/07/2023.
//

import Foundation


import UIKit
import SafariServices


enum StatusSeller {
    case Verified
    case Pending
    case Unverified
    
    var imageString : String {
        switch self {
        case .Verified:
            return "checkmark.circle.fill"
        case .Pending:
            return "clock.fill"
        case .Unverified:
            return "xmark.circle.fill"
        }
    }
    
    var title : String {
        switch self {
        case .Verified:
            return "Verified"
        case .Pending:
            return "Pending"
        case .Unverified:
            return "Unverified (Action Required)"
        }
    }
    
}
class DashboardViewController : RestrictedController {
    
    var status : StatusSeller = .Unverified
    
    
    var onBoardingInfo : OnBoardingData?{
        didSet{
            
            DispatchQueue.main.async {
                
                guard let info =  self.onBoardingInfo else {return}
                if info.payouts_enabled && info.charges_enabled && info.requirements.currently_due.isEmpty == true{
                    //Verified
                    self.status =  .Verified
                    self.verificationStatus.label.text =  self.status.title
                    self.verificationStatus.iconMenu.image = UIImage(systemName: self.status.imageString)
                }else if  (info.requirements.pending_verification.isEmpty == false) && (info.requirements.currently_due.isEmpty == true){
                    //Pending
                    self.status =  .Pending
           
                    self.verificationStatus.displayInfoVerificationButton.isHidden =  true
                    self.verificationStatus.label.text =  self.status.title
                    self.verificationStatus.iconMenu.image = UIImage(systemName: self.status.imageString)
                }else{
                    //Unverified
                    self.status =  .Unverified
                    
                    self.verificationStatus.label.text =  "\(self.status.title)" 
                    self.verificationStatus.iconMenu.image = UIImage(systemName: self.status.imageString)
                }
            }
            
           
         
        }
        
    }
    
    let identifierMenuCeller = "sellerCellMenuIdentifier"
    
    let padding: CGFloat = 10
    let spacing: CGFloat = 5
    
//    var stripeRequirements : StripeStatusResponse?{
//        didSet{
//            DispatchQueue.main.async {[weak self] in
//                if let verifed =  self?.stripeRequirements?.isVerified {
//                    self?.label.text =   verifed ? "Verified"  : "Pending"
//                }
//
//            }
//
//
//        }
//    }
    
    
    
    // MARK: - Components
    // Here you add all components
    
    var label : UILabel  =  {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .black
        return label
    }()
    
    var sellerMenuCollection   :   SellerMenuCollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collection = SellerMenuCollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        

        return collection
    }()
    
    
    var verificationStatus  =  VerificationStatusView ()
    
    
    var orderStat : DashBoardStatsElement  = {
        let view = DashBoardStatsElement(placeholder: "Orders", value: "10")
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    
    }()

    var viewStat : DashBoardStatsElement  = {
        let view = DashBoardStatsElement(placeholder: "Views", value: "100")
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    
    }()
    
    
    var impresssionStat : DashBoardStatsElement  = {
        let view = DashBoardStatsElement(placeholder: "Impressions", value: "20.0K")
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    
    }()
    
    
    var sortStatsButton : CustomButton =  {
        let button  = CustomButton(title: "Today ▼", hasBackground: true, fontType: .medium)
        return button
    }()
    // MARK: - Properties
    // All properties and variables you need in your ViewController
    
    // MARK: - Lifecycle methods
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//
//    }
    var alreadyFetchedInfo : Bool
    
    init(alreadyFetchedInfo: Bool) {
        self.alreadyFetchedInfo = alreadyFetchedInfo
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.checkStripeStatus()
        
        verificationStatus.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(updateOnBoardingLink)))
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Dashboard"
        view.backgroundColor = .systemBackground
        sellerMenuCollection.register(SellerMenuCell.self, forCellWithReuseIdentifier:identifierMenuCeller )
        sellerMenuCollection.dataSource = self
        sellerMenuCollection.delegate = self
        if let flowLayout = sellerMenuCollection.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
            // other properties
        }

        setupUI()
        if !alreadyFetchedInfo{
            fetchStatus()
        }
//
    }
    
    
    
    // MARK: - UI Setup
    private func setupUI() {
        
        
        // Set up all UI elements here
        self.navigationItem.hidesBackButton = true
     
        view.addSubview(verificationStatus)
        view.addSubview(sortStatsButton)
        
//        view.addSubview(label)
        view.addSubview(sellerMenuCollection)
        view.addSubview(orderStat)
        view.addSubview(viewStat)
        view.addSubview(impresssionStat)
        
        
   
       
        let bottomStackView  = UIStackView(arrangedSubviews: [orderStat, viewStat, impresssionStat])
        bottomStackView.alignment = .fill
        bottomStackView.axis =  .horizontal
        bottomStackView.distribution = .fillEqually
        bottomStackView.spacing =  10
        bottomStackView.translatesAutoresizingMaskIntoConstraints =  false
        view.addSubview(bottomStackView)
        
        sortStatsButton.anchor( top: view.layoutMarginsGuide.topAnchor, left: nil, right: view.trailingAnchor, bottom: nil, paddingTop: 5, paddingLeft: 0,paddingRight: -10, paddingBottom: 0, width: (self.view.frame.width / 3) - 10, height: 30)
        bottomStackView.anchor( top: sortStatsButton.bottomAnchor, left: view.leadingAnchor, right: view.trailingAnchor, bottom: nil, paddingTop: 15, paddingLeft: 10,paddingRight: -10, paddingBottom: 0, width: nil, height: 120)
        sellerMenuCollection.anchor( top: bottomStackView.bottomAnchor, left: view.leadingAnchor, right: view.trailingAnchor, bottom: nil, paddingTop: 20, paddingLeft: 0,paddingRight: 0, paddingBottom: 0, width: nil, height: nil)
        //For setting the  collection view resizable, set the bottom anchor less or equal
        sellerMenuCollection.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        (verificationStatus).anchor( top: sellerMenuCollection.bottomAnchor, left: view.leadingAnchor, right: view.trailingAnchor, bottom: nil, paddingTop: 20, paddingLeft: 10,paddingRight: -10, paddingBottom: 0, width: nil, height: 60)
        
        
        
    }
   
    
    
    func fetchStatus (){
        Service.shared.getSellerOnBoardingStatus(expecting: ApiResponse<OnBoardingData>.self) { [weak self]result in
            guard let self =  self else {return}
            
            switch result{
                
            case .success(let response):
                guard let onBoardingInfo = response.data else {return}
                self.onBoardingInfo = onBoardingInfo
            case .failure(let error):
                print("Error")
            }
        }
    }
    
    func getOnBoardingLinkNew(){
        Service.shared.getOnBoardingUpdateLink(expecting: ApiResponse<AccountLink>.self) { [weak self]result in
            guard let self =  self else {return}
            
            switch result{
                
            case .success(let response):
                guard let linkdata = response.data else {return}
                guard let url = URL(string: linkdata.url) else { return }
                
                let safariViewController = SFSafariViewController(url: url)
                safariViewController.delegate = self
                DispatchQueue.main.async {
//                    let navigationController = UINavigationController(rootViewController: safariViewController)
                    

                    self.present(safariViewController, animated: true)
                }
               
                
            case .failure(_):
                print("Error")
            }
                
 
        }
    }
    
    
    // MARK: - IBActions
    // Here you add all your @IBActions (functions called by UI interactions like button taps)
    @objc func updateOnBoardingLink(){
        print("Show ")
        getOnBoardingLinkNew()
    }
    // MARK: - Navigation
    // Segue preparations and related stuff
    
    // MARK: - Private methods
    // All other functions that you use within the ViewController
    
//    func checkStripeStatus (){
//        Service.shared.statusStripeAccount(expecting: ApiResponse<StripeStatusResponse>.self) { [weak self ] result in
//            guard let self =  self else {return}
//            switch result{
//
//            case .success(let response):
//                let success  =  response.status
//                guard let stripeData  =  response.data else {
//                    print ("Not data available")
//                    return
//                }
//                self.stripeRequirements = stripeData
//
//
//
//            case .failure(let error):
//                print(error)
//                print("Error displaying for verification for verification")
//            }
//
//
//        }
//
//
//    }
}



///For seller Menu
extension DashboardViewController : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return SellerMenu.allCases.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            
        //User NOrmal cell
        
        let setting  =  SellerMenu.init(rawValue: indexPath.row)

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifierMenuCeller, for: indexPath) as! SellerMenuCell
        cell.label.text =   setting?.description
        if let stringImage  = setting?.imageSetting {
            cell.iconMenu.image =  UIImage(systemName: stringImage)
        }
        
       
        return cell
            
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (self.view.frame.width  - (padding * 2) - spacing) / 2  ,height: 50)
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return spacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return spacing
    }
    

    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let itemSelected  =  SellerMenu.init(rawValue: indexPath.row)
        switch itemSelected{
            
       
            
        case .some(.ListItem):
            let controller  = AddListingViewController()
          
            self.navigationController?.pushViewController(controller, animated: true)
            
        case .none:
            return
        case .some(.Orders):
            let controller  = ManageOrderController()
          
            self.navigationController?.pushViewController(controller, animated: true)
        case .some(.Listings):
            let controller  = ManageListingController()
          
            self.navigationController?.pushViewController(controller, animated: true)
        case .some(.Messages):
            let controller  =  BalanceViewController()
            
            self.navigationController?.pushViewController(controller, animated: true)
            return 
        case .some(.Reviews):
            return
        case .some(.Shop):
            guard let seller_id  = UserDefaults.standard.object(forKey: "seller_id") as? String else {return}
         
            let controller  =  ShopViewController(sellerId: seller_id, shopInfo: nil, admin: true)
            self.navigationController?.pushViewController(controller, animated: true)
          
        case .some(.MyInfo):
            return
        case .some(.Support):
            return
        }
        
      
       
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
//        return CGSize(width: view.frame.width, height: 50)
//    }
    
}
extension DashboardViewController: SFSafariViewControllerDelegate {
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        // the user may have closed the SFSafariViewController instance before a redirect
        // occurred. Sync with your backend to confirm the correct state
        print("Finished")
        Service.shared.getSellerOnBoardingStatus(expecting: ApiResponse<OnBoardingData>.self) { [weak self] result in
            switch result{
                
                
            case .success(let response):
                guard let infoData = response.data else {return}
              
                self?.onBoardingInfo = infoData
                    
                   
                    
            
                
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
