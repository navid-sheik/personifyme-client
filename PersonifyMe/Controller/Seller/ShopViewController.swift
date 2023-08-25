//
//  ShopViewController.swift
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
import MessageUI

import UIKit

class   ShopViewController : UIViewController {
    
    private var products : [Product] = []{
        didSet{
           
           
            DispatchQueue.main.async {
                if self.products.isEmpty {
                      self.productCollectionView.setEmptyMessage("You have 0 active listing")
                  } else {
                      self.productCollectionView.restore()
                  }
                self.shopProductsValue.text = "\(self.products.count)"
                self.resultLabel.text =  "Results - \(self.products.count) items"
                self.productCollectionView.reloadData()
            }
        }
    }
    
    var reviews : [Review] = []{
        didSet{
            DispatchQueue.main.async {
                
                let average = ReviewManager.calculateAverageRating(from: self.reviews)
                self.starRatingView.setRating(average)
                self.averageReview.text =   "\(average)"
                self.totalReview.text   =  "(\(self.reviews.count))"
               
            }
            
        }
    }

    
    private  var isAdmin : Bool
    
    private var shopInfo : Shop?{
        didSet{
            
            DispatchQueue.main.async {
                guard let user_id  = UserDefaults.standard.object(forKey: "user_id") as? String else {return}
                if ((self.shopInfo?.followers?.contains(user_id)) == true){
                    self.followBUtton.setTitle("Unfollow", for: .normal)
            
                    
                }else {
                    self.followBUtton.setTitle("Follow", for: .normal)
                }
                
                
                self.configureShopInfoUI()
            }
           
            
        }
    }
    
    private let cellIdentifierProductCell : String  = "cellIdentifierProductCell"
    // MARK: - Components
    // Here you add all components
    
    let shopImage : CustomImageView =  {
        let imageView =  CustomImageView()
        imageView.contentMode =  .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image =  UIImage(named: "placeholder")
        return imageView
    }()
    let editImageButton : UIButton =  {
        let button  =  UIButton()
        button.setImage(UIImage(systemName: "pencil"), for: .normal)
        button.isHidden = true
        button.isEnabled =  false
        return button
    }()
    
    
    
    
    
    private let averageReview : UILabel = {
        let label  = UILabel()
        label.lineBreakMode = .byWordWrapping
        label.text  = "5.0"
        label.textAlignment = .center
        label.font =  UIFont.systemFont(ofSize: 13)
        label.textAlignment = .right
        return label
    }()
    
    private  let totalReview  : UILabel =  {
        let label  =  UILabel()
        label.text  = "(2.4k)"
        label.font =  UIFont.systemFont(ofSize: 13)
        return label
    }()
    private let starRatingView: StarRatingView = {
        let ratingView = StarRatingView(starMode: .display)
        ratingView.setRating(5)
        ratingView.isUserInteractionEnabled = false
            ratingView.translatesAutoresizingMaskIntoConstraints = false
            
            return ratingView
        }()
    
    
    let shopProducts : UILabel =  {
        let label  = UILabel()
        label.text = "Items"
        label.textAlignment =  .center
        label.font = UIFont.systemFont(ofSize: 14)
        
        return label
    }()
    
    
    let shopProductsValue : UILabel =  {
        let label  = UILabel()
        label.text = ""
        label.textAlignment =  .center
        label.font = UIFont.systemFont(ofSize: 16)
        
        return label
    }()
    
    
    
    let shopLikes : UILabel =  {
        let label  = UILabel()
        label.text = "Likes"
        label.textAlignment =  .center
        label.font = UIFont.systemFont(ofSize: 14)
        
        return label
    }()
    
    let shopLikesValue : UILabel =  {
        let label  = UILabel()
        label.text = ""
        label.textAlignment =  .center
        label.font = UIFont.systemFont(ofSize: 16)
        
        return label
    }()
    
    
    
    let shopOrders : UILabel =  {
        let label  = UILabel()
        label.text = "Orders"
        label.textAlignment =  .center
        label.font = UIFont.systemFont(ofSize: 14)
        
        return label
    }()
    let shopOrdersValue : UILabel =  {
        let label  = UILabel()
        label.text = ""
        label.textAlignment =  .center
        label.font = UIFont.systemFont(ofSize: 16)
        
        return label
    }()
    
    
    let shopFollow : UILabel =  {
        let label  = UILabel()
        label.text = "Follows"
        label.textAlignment =  .center
        label.font = UIFont.systemFont(ofSize: 14)
        
        return label
    }()
    let shopFollowValue : UILabel =  {
        let label  = UILabel()
        label.text = ""
        label.textAlignment =  .center
        label.font = UIFont.systemFont(ofSize: 16)
        
        return label
    }()
    
    
    
    let messegeButton : CustomButton =  {
        let button  =  CustomButton(title: "Message"  ,  hasBackground : true, fontType: .medium)
        
        return button
    }()
    
    
    let followBUtton : CustomButton =  {
        let button  =  CustomButton(title: "Follow"  ,  hasBackground : true, fontType: .medium)
        
        return button
    }()
    
    
    
    
    
    
    private let shopNameLabel : UILabel = {
        let label  = UILabel()
        label.text = "Shop Name"
        label.numberOfLines = 1
        label.font =  UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    private let descriptionShopLabel : UILabel = {
        let label  = UILabel()
        label.numberOfLines = 0
        label.font =  UIFont.systemFont(ofSize: 14)
        label.text = "Jewellery | United States | Open Since 2016"
        return label
    }()
    
    
    //BOTTOM PART
    
    let resultLabel  : UILabel  = {
        let label  = UILabel()
        label.text =  "Results - 281 items"
        label.font =  UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    let filterButton : UIButton =  {
        let button  =  UIButton()
        button.setImage(UIImage(systemName: "slider.horizontal.3"), for: .normal)
        return button
    }()
    
    
    let separator : UIView =  {
        let view  =  UIView()
        view.backgroundColor =  .lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //MARK: - COMPONENTS
    let productCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
       
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.isScrollEnabled = true
        cv.backgroundColor = .systemBackground
    
        return cv
    }()

    
    
    let sellerId : String
    
    init(sellerId: String, shopInfo : Shop?, admin : Bool){
        self.sellerId = sellerId
        self.shopInfo = shopInfo
        self.isAdmin = admin
        super.init(nibName: nil, bundle: nil)
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
    var reviewStackView : UIStackView!
    
     
    
    
    // MARK: - Properties
    // All properties and variables you need in your ViewController
    
    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor  = .systemBackground
        
        if isAdmin {
            
            Service.shared.getShopOfSeller(expecting: ApiResponse<Shop>.self) { [weak self] result in
                guard let self = self else {return}
                
                switch result {
                    
                case .success(let response):
                    guard let shopData =  response.data else {return}
                    
                    
                    DispatchQueue.main.async {
                        self.editImageButton.isHidden = false
                        self.editImageButton.isEnabled = true
                        self.setUpNavigationBar()
                        self.layoutView()
                        self.shopInfo = shopData
                    }
                  
                case .failure(_):
                    DispatchQueue.main.async {
                      
                        self.showErrorAlert()
                    }
                }
            }
        }
        else {
            self.layoutView()
        }
        
       
        
       
    }
    
    private func showErrorAlert() {
        let alert = UIAlertController(title: "Error", message: "You are not authorized.", preferredStyle: .alert)
        self.present(alert, animated: true, completion: nil)
        
        // Dismiss the alert automatically after 2 seconds
        let deadline = DispatchTime.now() + 2.0
        DispatchQueue.main.asyncAfter(deadline: deadline) {
            alert.dismiss(animated: true) {
                // After dismissing the alert, also dismiss the view controller
                self.dismiss(animated: true )
            }
        }
    }
    
    private func  layoutView(){
        self.filterButton.isHidden = true
        followBUtton.isUserInteractionEnabled = true
        followBUtton.addTarget(self, action: #selector(didTapFollowButton), for: .touchUpInside)
        messegeButton.addTarget(self, action: #selector(didTapMessageButton), for: .touchUpInside)
        setupCollectionView()
        configureShopInfoUI()
        setupUI()
        reviewStackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showAllReviews)))
        performFetch()
    }
    
    private func setupCollectionView() {
        productCollectionView.delegate = self
        productCollectionView.dataSource = self
        productCollectionView.register(ProductCell.self, forCellWithReuseIdentifier: cellIdentifierProductCell)
    }
    func performFetch (){
        fetchProducts()
        fetchNumberOrders()
        fetchShopReviews()
    }
    
    
    private func fetchProducts  (){
        print(self.sellerId)
        
     
        
        Service.shared.getShopProducts(with: self.sellerId, expecting: ApiResponse<[Product]>.self) { [weak self] result in
            guard let self = self else {return}
        
            switch result{
                
            case .success(let response):
        
                guard let products = response.data else {return}
                
                self.products = products
            case .failure(_):
                print("Error fetching product for shop")
            }
        }
    }
    
    private func fetchNumberOrders() {
        Service.shared.getShopNUmberOrders(with: self.sellerId, expecting: ApiResponse<Int>.self) { [weak self] result in
            guard let self = self else {return}
        
            switch result{
                
            case .success(let response):
        
                guard let count = response.data else {return}
                DispatchQueue.main.async {
                               // Here you can update your UI elements related to the second data
                        self.shopOrdersValue.text =  "\(count)"
                }
                           
                
                
                
               
            case .failure(_):
                print("Error fetching product for shop")
            }
        }
    }
    
 
        
        
    func fetchShopReviews(){

        Service.shared.getSellerReviews( with: self.sellerId,  expecting: ApiResponse<[Review]>.self) { [weak self] result  in
            guard let self = self else{return}
            switch result{
                
                
                
            case .success(let response):
                guard let reviews = response.data else {return}
                
                self.reviews =  reviews
            case .failure(_):
                print("Failing to get reviews")
            }
        }
    }

        
    
 
    
    
    private func followShop(){
        guard let shopID = self.shopInfo?.sellerShopID else {return}
        Service.shared.followShop(with: shopID, expecting: ApiResponse<Shop>.self) { [weak self] result in
            guard let self = self else {return}
        
            switch result{
                
            case .success(let response):
        
                guard let shop = response.data else {return}
                

                        self.shopInfo =  shop
                   
                           
                
                
                
             
            case .failure(_):
                print("Error fetching product for shop")
            }
        }
    }
    
    private func unfollowShop(){
        guard let shopID = self.shopInfo?.sellerShopID else {return}
        
        Service.shared.unfollowShop(with: shopID, expecting: ApiResponse<Shop>.self) { [weak self] result in
            guard let self = self else {return}
        
            switch result{
                
            case .success(let response):
        
                
                guard let shop = response.data else {return}

                    self.shopInfo =  shop
                    
                
                           
                
                
                
                
            case .failure(_):
                print("Error fetching product for shop")
            }
        }
    }
    private func setUpNavigationBar(){
        navigationItem.largeTitleDisplayMode =  .never
        let rightButton  =  UIBarButtonItem(image: UIImage(systemName: "ellipsis")?.withRenderingMode(.alwaysTemplate), style: .plain, target: self, action: #selector(didTapRightButton))
        
        rightButton.tintColor = DesignConstants.primaryColor
        
        self.navigationItem.rightBarButtonItem = rightButton
    }
    

  
    
    
    
    // MARK: - UI Setup
    private func setupUI() {
        // Set up all UI elements here
        view.addSubview(shopImage)
        let imagewidth  = self.view.frame.width / 4
        shopImage.anchor(top: view.layoutMarginsGuide.topAnchor, left: view.leadingAnchor, right: nil, bottom: nil, paddingTop: 10, paddingLeft: 10, paddingRight: 0, paddingBottom: 0, width: imagewidth, height: imagewidth)

        starRatingView.widthAnchor.constraint(equalToConstant: self.view.frame.width / 4).isActive = true

        averageReview.sizeToFit()
        totalReview.sizeToFit()
        
        reviewStackView = StackManager.createStackView(with: [averageReview, starRatingView, totalReview], axis: .horizontal, spacing: 3, distribution: .fillProportionally , alignment: .center)

//        reviewStackView = StackManager.createStackView(with: [averageReview, starRatingView, totalReview], axis: .horizontal, spacing: 3, distribution: .fillProportionally , alignment: .fill)
        view.addSubview(reviewStackView)
        reviewStackView.anchor(top: view.layoutMarginsGuide.topAnchor, left: shopImage.trailingAnchor, right: nil, bottom: nil, paddingTop: 10, paddingLeft: 5, paddingRight: 0, paddingBottom: 0, width: nil, height: nil)

        let productStack = StackManager.createStackViewWithLabels(with: [shopProductsValue, shopProducts])
        let orderStack = StackManager.createStackViewWithLabels(with: [shopOrdersValue, shopOrders])
        let followStack = StackManager.createStackViewWithLabels(with: [shopFollowValue, shopFollow])
        let likesStack = StackManager.createStackViewWithLabels(with: [shopLikesValue,  shopLikes])
        
        let statsStack = StackManager.createStackView(with: [productStack, orderStack, followStack, likesStack], axis: .horizontal, spacing: 8, distribution: .fillEqually , alignment: .fill)

        let buttonsStack = StackManager.createStackView(with: [messegeButton, followBUtton], axis: .horizontal, spacing: 20, distribution: .fillEqually , alignment: .fill)
        followBUtton.isEnabled = true
        
        let mainStack = StackManager.createStackView(with: [statsStack, buttonsStack], axis: .vertical, spacing: 12, distribution: .fillEqually , alignment: .fill)

        view.addSubview(mainStack)
        mainStack.anchor(top: reviewStackView.bottomAnchor, left: shopImage.trailingAnchor, right: view.trailingAnchor, bottom: shopImage.bottomAnchor, paddingTop: 12, paddingLeft: 10, paddingRight: -10, paddingBottom: 0, width: nil, height: nil)

        view.addSubview(shopNameLabel)
        shopNameLabel.anchor(top: shopImage.bottomAnchor, left: view.leadingAnchor, right: nil, bottom: nil, paddingTop: 15, paddingLeft: 10, paddingRight: 0, paddingBottom: 0, width: nil, height: nil)

        view.addSubview(descriptionShopLabel)
        descriptionShopLabel.anchor(top: shopNameLabel.bottomAnchor, left: view.leadingAnchor, right: nil, bottom: nil, paddingTop: 8, paddingLeft: 10, paddingRight: 0, paddingBottom: 0, width: nil, height: nil)

        view.addSubview(separator)
        separator.anchor(top: descriptionShopLabel.bottomAnchor, left: view.leadingAnchor, right: view.trailingAnchor, bottom: nil, paddingTop: 20, paddingLeft: 10, paddingRight: -10, paddingBottom: 0, width: nil, height: 1)

        view.addSubview(resultLabel)
        resultLabel.anchor(top: separator.bottomAnchor, left: view.leadingAnchor, right: nil, bottom: nil, paddingTop: 20, paddingLeft: 10, paddingRight: 0, paddingBottom: 0, width: nil, height: nil)

        view.addSubview(filterButton)
        filterButton.anchor(top: nil, left: nil, right: view.trailingAnchor, bottom: nil, paddingTop: 0, paddingLeft: 0, paddingRight: -10, paddingBottom: 0, width: 40, height: 40)
        filterButton.centerYAnchor.constraint(equalTo: resultLabel.centerYAnchor).isActive = true

        view.addSubview(productCollectionView)
        productCollectionView.anchor(top: filterButton.bottomAnchor, left: view.leadingAnchor, right: view.trailingAnchor, bottom: view.bottomAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: nil, height: nil)
    }
    
    
    @objc  func didTapFollowButton(){
        performActionOrAuthorize { success in
            if success {
                guard let user_id  = UserDefaults.standard.object(forKey: "user_id") as? String else {return}
                if ((self.shopInfo?.followers?.contains(user_id)) == true){
                    self.unfollowShop()
            
                    
                }else {
                    self.followShop()
                }
                
            }else {
                print("Something wrong")
            }
        
        }
        
        
       
        
        
        
//        if isFollowed(shopInfo){
//            unfollowShop()
//        }else {
//            followShop()
//        }
//
    }
    
    @objc func didTapRightButton(){
        print("Edit")
        guard let shopInfo = shopInfo else {return}
        
        let vc =  SettingsShopController(shopInfo: shopInfo)
        vc.delegate = self
        self.present(vc, animated: true)
    }
    
    @objc func didTapMessageButton (){
        guard let shopName = shopInfo?.name else {
            // ... handle the case where 'shopInfo?.name' is nil ...
            return
        }

        let subject = "Inquiry from \(shopName) on Personify me"
        let message = """
        Hello,

        I am interested in your products listed on your \(shopName) (PersonifyMe). Can you please provide more information?

        Thank you,
        [Your Name]
        """

    

        self.sendEmail(to: shopInfo!.emailSupport, with: subject, and: message)
        
    }
    
    @objc func showAllReviews(){
        
        let vc =  AllReviewController(typeReview: .shop, reviews: self.reviews, sellerId: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func sendEmail(to email: String, with subject: String, and body: String) {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients([email])
            mail.setSubject(subject)
            mail.setMessageBody(body, isHTML: true)
            
            present(mail, animated: true)
        } else {
            // Show an alert informing the user that mail features are not available.
        }
    }
   
    
    
    func configureShopInfoUI(){
        self.shopNameLabel.text =  shopInfo?.name
        if let  imageUrl =  shopInfo?.image{
            self.shopImage.loadImageUrlString(urlString: imageUrl)
        }

        if let follows = shopInfo?.follows {
            self.shopFollowValue.text = "\(follows)"
        } else {
            self.shopFollowValue.text = "N/A" // or some default value
        }

        if let totalLikes = shopInfo?.totalLikes {
            self.shopLikesValue.text = "\(totalLikes)"
        } else {
            self.shopLikesValue.text = "N/A" // or some default value
        }

        if let categoryName = shopInfo?.categoryName,
           let location = shopInfo?.location,
           let createdAt = shopInfo?.createdAt,
           let description = shopInfo?.description {
               
            let year = TimeManager.openSinceYear(from: createdAt)
            self.descriptionShopLabel.text = "\(categoryName) | \(location) | \(year) \n\(description)"
            
        } else {
            self.descriptionShopLabel.text = "N/A" // or some default value
        }

        
        guard let user_id  = UserDefaults.standard.object(forKey: "user_id") as? String else {return}
        if ((shopInfo?.followers?.contains(user_id)) == true){
            self.followBUtton.setTitle("Unfollow", for: .normal)
    
            
        }else {
            self.followBUtton.setTitle("Follow", for: .normal)
        }
     
        
        
        
        
    }
    // MARK: - IBActions
    // Here you add all your @IBActions (functions called by UI interactions like button taps)
    
    // MARK: - Navigation
    // Segue preparations and related stuff
    
    // MARK: - Private methods
    // All other functions that you use within the ViewController
}
extension ShopViewController : UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = productCollectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifierProductCell, for: indexPath) as! ProductCell
        let product  =  products[indexPath.row]
        if let imageUrl =  product.images.first {
            cell.mainImage.loadImageUrlString(urlString: imageUrl)
        }
       
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let product = products[indexPath.row]
        let vc = ProductViewController(product: product)
        self.navigationController?.pushViewController(vc, animated: true)
    

    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        return CGSize(width: (view.frame.width - 3) / 2 , height:  view.frame.width / 2)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 3
    }
    
    
    
}


extension ShopViewController : MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
}


extension ShopViewController : SettingsShopControllerDelegate {
    func didDeactivateShop(shop: Shop) {
        print("Deactivate ")
    }
    
    func didUpdateShop(shop: Shop) {
        self.shopInfo =  shop
    }
    
}
