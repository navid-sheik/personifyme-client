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


import UIKit

class   ShopViewController : UIViewController {
    
    private var products : [Product] =  []
    
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
        let ratingView = StarRatingView(starMode: .interactive)
        ratingView.setRating(5)
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
        label.text = "1"
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
        label.text = "1"
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
        label.text = "1"
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
        label.text = "1"
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
        label.font =  UIFont.systemFont(ofSize: 14)
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

    
    
    
    
    
    
    
    
    
    // MARK: - Properties
    // All properties and variables you need in your ViewController
    
    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor  = .systemBackground
        setupCollectionView()
        setupUI()
    
    }
    
    private func setupCollectionView() {
        productCollectionView.delegate = self
        productCollectionView.dataSource = self
        productCollectionView.register(ProductCell.self, forCellWithReuseIdentifier: cellIdentifierProductCell)
    }
    
    
    
    
    // MARK: - UI Setup
    private func setupUI() {
        // Set up all UI elements here
        
        let topContainer  =  UIView()
        topContainer.backgroundColor =  .yellow
        view.addSubview(topContainer)
        
        topContainer.anchor( top: view.layoutMarginsGuide.topAnchor, left: view.leadingAnchor, right: view.trailingAnchor, bottom: nil, paddingTop: 0, paddingLeft: 10,paddingRight: -10, paddingBottom: 0, width: nil, height: nil)
        
        
        topContainer.addSubview(shopImage)
        
        let imagewidth  = self.view.frame.width / 4
        shopImage.anchor( top: topContainer.layoutMarginsGuide.topAnchor, left: topContainer.leadingAnchor, right: nil, bottom: nil, paddingTop: 0, paddingLeft: 0,paddingRight: 0, paddingBottom: 0, width: imagewidth, height: imagewidth)
        
        
//        starRatingView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        starRatingView.widthAnchor.constraint(equalToConstant: self.view.frame.width / 4).isActive = true
        
     
        let reviewStackView = StackManager.createStackView( with:  [averageReview, starRatingView, totalReview], axis: .horizontal, spacing: 3, distribution: .fillProportionally , alignment: .fill)
       
        
        topContainer.addSubview(reviewStackView)
        reviewStackView.anchor( top: topContainer.layoutMarginsGuide.topAnchor, left: shopImage.trailingAnchor, right: topContainer.trailingAnchor, bottom: nil, paddingTop: 0, paddingLeft: 5,paddingRight: 0, paddingBottom: 0, width: nil, height: nil)

        
        let productStack =  StackManager.createStackViewWithLabels(with: [shopProductsValue, shopProducts ])
        
        
        let orderStack =  StackManager.createStackViewWithLabels(with: [shopOrdersValue, shopOrders ])
        
        
        let followStack =  StackManager.createStackViewWithLabels(with: [shopFollowValue, shopFollow ])
        
        let likesStack =  StackManager.createStackViewWithLabels(with: [shopLikesValue,  shopLikes ])
        
        let statsStack  = StackManager.createStackView( with:  [productStack, orderStack, followStack, likesStack ], axis: .horizontal, spacing: 8, distribution: .fillEqually , alignment: .fill)
        
        
        
        let buttonsStack  = StackManager.createStackView( with:  [messegeButton, followBUtton ], axis: .horizontal, spacing: 20, distribution: .fillEqually , alignment: .fill)
        
        let mainStack =  StackManager.createStackView( with:  [ statsStack, buttonsStack ], axis: .vertical, spacing: 12, distribution: .fillEqually , alignment: .fill)
        
        topContainer.addSubview(mainStack)
        mainStack.anchor( top: reviewStackView.bottomAnchor, left: shopImage.trailingAnchor, right: topContainer.trailingAnchor, bottom: shopImage.bottomAnchor, paddingTop: 12, paddingLeft: 10,paddingRight: 0, paddingBottom: 0, width: nil, height: nil)
      
        
        
        
        topContainer.addSubview(shopNameLabel)
        shopNameLabel.anchor( top: shopImage.bottomAnchor, left: topContainer.leadingAnchor, right: nil, bottom: nil, paddingTop: 15, paddingLeft: 0,paddingRight: 0, paddingBottom: 0, width: nil, height: nil)
        
        topContainer.addSubview(descriptionShopLabel)
        descriptionShopLabel.anchor( top: shopNameLabel.bottomAnchor, left: topContainer.leadingAnchor, right: nil, bottom: nil, paddingTop: 8, paddingLeft: 0,paddingRight: 0, paddingBottom: 0, width: nil, height: nil)
        
      
        
//
//        let bottomContainer  =  UIView()
//        bottomContainer.backgroundColor = .cyan
//        view.translatesAutoresizingMaskIntoConstraints = false
//
//        bottomContainer.anchor( top: descriptionShopLabel.bottomAnchor, left: view.leadingAnchor, right: view.trailingAnchor, bottom: nil, paddingTop: 20, paddingLeft: 10,paddingRight: -10, paddingBottom: 0, width: nil, height: nil)
//
//
        
        topContainer.addSubview(separator)
        
        separator.anchor( top: descriptionShopLabel.bottomAnchor, left: topContainer.leadingAnchor, right: topContainer.leadingAnchor, bottom: nil, paddingTop: 20, paddingLeft: 0,paddingRight: 0, paddingBottom: 0, width: nil, height: 10)
        
        
        topContainer.addSubview(resultLabel)
        resultLabel.anchor( top: separator.bottomAnchor, left: topContainer.leadingAnchor, right: nil, bottom: nil, paddingTop: 20, paddingLeft: 0,paddingRight: 0, paddingBottom: 0, width: nil, height: nil)
//
        topContainer.addSubview(filterButton )
        filterButton.anchor( top: nil, left:  nil,  right: topContainer.trailingAnchor, bottom: nil, paddingTop: 0, paddingLeft: 0,paddingRight: 0, paddingBottom: 0, width: 40, height: 40)
        filterButton.centerYAnchor.constraint(equalTo: resultLabel.centerYAnchor).isActive = true
        
        
        view.addSubview(productCollectionView)
        productCollectionView.anchor( top: filterButton.bottomAnchor, left:  view.leadingAnchor,  right: view.trailingAnchor, bottom: view.bottomAnchor, paddingTop: 0, paddingLeft: 0,paddingRight: 0, paddingBottom: 0, width: nil, height: nil)
       
        
        

    
        
        
//        topContainer.addSubview(statsStack)
       
        
        
        
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
        return 20
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = productCollectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifierProductCell, for: indexPath) as! ProductCell
        return cell
    }
    
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//
//    }
    
    
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

