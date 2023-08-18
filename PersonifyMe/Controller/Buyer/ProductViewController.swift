//
//  Product.swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 04/08/2023.
//

//
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
import DropDown

class ProductViewController: UIViewController {
    
    var product : Product
    
    var shopInfo :  Shop?
    var sellerInfo : Seller?
    
    var isLiked : Bool =  false
    
    var productLike : [String] = []{
        didSet{
            
          
            DispatchQueue.main.async {
                if self.productLike.contains(self.product.productId){
                    self.isLiked = true
                    
                    UIView.transition(with: self.favouriteButton, duration: 0.3, options: .transitionCrossDissolve, animations: {
                        let image = UIImage(systemName: "heart.fill")?.withRenderingMode(.alwaysTemplate)
                        self.favouriteButton.setImage(image , for: .normal)
                    }, completion: nil)
                
                }else {
                    self.isLiked = false
                    UIView.transition(with: self.favouriteButton, duration: 0.3, options: .transitionCrossDissolve, animations: {
                        let image = UIImage(systemName: "heart")?.withRenderingMode(.alwaysTemplate)
                        self.favouriteButton.setImage(image , for: .normal)
                    }, completion: nil)
                    
                  
                }
            }
            
            
        }
    }
    
    weak var delegate: CartUpdateDelegate?

    
    
    var reviews : [Review] = []{
        didSet{
            DispatchQueue.main.async {
                self.reviewTable.reloadData()
                self.reviewTable.layoutIfNeeded()
            }
            
        }
    }
    
    var images :  [String] = []
    
    //MARK: - Identifier
    
    let cellImageProductIdentifier  =  "cellImageProductIdentifier"
    
    let reviewCellIdentifier  =  "reviewCellIdentifier"
    // MARK: - Components
    // Here you add all components
    let imageCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .systemBackground
        return cv
    }()
    
    
    let productTitle : UILabel  =  {
        let label = UILabel()
        label.text  =  "Something"
        label.numberOfLines =  2
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = UIColor.gray
        return label
    }()
    
    let currenyLabel : UILabel = {
        let label = UILabel()
        label.text = "$"
        label.font = UIFont.systemFont(ofSize: 24)
        label.textColor = UIColor.gray
        return label
    }()
    
    
    
    let priceLabel : UILabel = {
        let label = UILabel()
        label.text = "100"
        label.font = UIFont.systemFont(ofSize: 35)
        label.textColor = UIColor.gray
        return label
    }()
    
    
    let personalization : LabeledTextView = {
        let label = LabeledTextView(labelText: "Personalization", placeholder: "enter personalization for buyer")
        return label
    }()
    
    
    let addToCartButton : CustomButton =  {
        let button  =  CustomButton(title: "ADD TO CART"  ,  hasBackground : true, fontType: .medium)
        return button
    }()
    
    
    private let starRatingView: StarRatingView = {
        let ratingView = StarRatingView(starMode: .interactive)
            ratingView.translatesAutoresizingMaskIntoConstraints = false
            
            return ratingView
        }()
   
    var accordionTableView: ExpandableTableViewV2 = {
        let tableView = ExpandableTableViewV2(frame: .zero, style: .plain)
        
        tableView.sections = [
            Section(title: "HOW TO PERSONALIZE", items: [GlobalTexts.productionDelivery]),
                   Section(title: "PRODUCT & DELIVERY", items: ["Item 3"]),
                           Section(title: "OUR GUARANTEE", items: ["Item 3"]),
                        Section(title: "FAQ", items: ["Item 3"]),
                          
                          
                          
                   // Add more sections here
               ]
      
        return tableView
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
    
    
    let estimateLabel : UITextView =  {
        let label  =  UITextView()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.borderWidth = 1
        label.layer.borderColor =  UIColor.gray.cgColor
        label.layer.cornerRadius = 4
        label.layer.masksToBounds = true
        label.text = "Place your order today, and receive your package \n between Aug 06 to Aug 08"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14)
        label.textContainerInset = UIEdgeInsets(top: 10, left: 8, bottom: 10, right: 8);
        label.sizeToFit()
        label.isScrollEnabled = false
        label.isUserInteractionEnabled = false
        label.isEditable = false
        return label
    }()
    
    
    let descriptionLabel : UILabel =  {
        let label = UILabel()
        label.text = "Description"
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = UIColor.gray
        return label
    }()
        
    let descriptionTextView : UITextView =  {
        let textView  =  UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.layer.masksToBounds = true
        textView.text = GlobalTexts.placeHolder
        textView.textAlignment = .left
        textView.textContainerInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0);
        textView.font = UIFont.systemFont(ofSize: 14)
        textView.sizeToFit()
        textView.isScrollEnabled = false
        return textView
    }()
    
    let favouriteButton: UIButton = {
        let button = UIButton(type: .system)
//        let image = UIImage(systemName: "heart")?.withRenderingMode(.alwaysTemplate)
//        button.setImage(image, for: .normal)
        button.tintColor = .red
        button.translatesAutoresizingMaskIntoConstraints = false
        button.contentMode = .scaleAspectFill
        button.clipsToBounds = false
        button.isHidden = false
        button.isUserInteractionEnabled = true
        return button
    }()
    
    
    
    
    
    
    
    let reviewTable  : DynamicTableView = {
        let tb = DynamicTableView()
        tb.backgroundColor = .white
        tb.alwaysBounceVertical = false
        tb.tableFooterView =  UIView()
        return tb
    }()
    
    
    let stackViewVariants: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 10
        stack.distribution  = .fillProportionally
        stack.alignment = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    

    
    var placeholderLabel : UILabel!
    let personalizationView : VariantProductTextView = {
        let field = VariantProductTextView()
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    
    let shopLabel : UILabel = {
        let label = UILabel()
        label.text = "Shop"
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = UIColor.gray
        return label
    }()
    
    
    
    
    
    
    // MARK: - Properties
    // All properties and variables you need in your ViewController
    
   
    
    //MARK: - INIT
    
    init(product: Product) {
        self.product = product
        if  product.images.count > 0 {
            self.images = product.images
        
        }
        super.init(nibName: nil, bundle: nil)
    
        
      
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    private func configureUI(){
        productTitle.text =  product.title
        priceLabel.text  = String(product.price)
        descriptionTextView.text = product.description
        
        
        
        
        let isInternational = product.shippingInfo.internationalDelivery?.available ?? false
        let service = DeliveryEstimationService()
        let message = service.deliveryMessage(for: product.shippingInfo, isInternational: isInternational)
        //        print(message)
        
        
        estimateLabel.text = message
        placeholderLabel.text = product.customizationOptions.first?.instructions
        
        if let seller =   product.sellerId{
            switch seller{
                
            case .string(let idString):
                print("idString \(idString)")
                
                
            case .seller(let sellerObject):
                print("idString \(sellerObject)")
                self.sellerInfo =  sellerObject
                switch sellerObject.shopId{
                    
                case .shop(let shopOject):
                    self.shopInfo =  shopOject
                    shopLabel.text  = shopOject.name
                   
                case .string(let idString):
                    print("idString \(idString)")
                    
                case .none:
                    print("None")
                }
                
            }
            
            
            
        }
        
    }
       
        
    @objc
    func handleGotToShop(){
        print("Got to shop")
        
        guard let shopInfo =  self.shopInfo else { return}
        
        guard let sellerId = sellerInfo?.id else {return}
//        ShopViewController(sellerId: <#T##String#>, shopInfo: <#T##Shop#>, )
        let vc = ShopViewController(sellerId: sellerId, shopInfo: shopInfo,admin: false)
        self.navigationController?.pushViewController(vc, animated: true)
    }
       
    
    
    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor  = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = false
        
        favouriteButton.addTarget(self, action: #selector(handleFavouriteButtno), for: .touchUpInside)
        addToCartButton.addTarget(self, action: #selector(handleAddCart), for: .touchUpInside)
        shopLabel.isUserInteractionEnabled = true
        
        shopLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleGotToShop)))
       
        personalizationView.textView.delegate = self
         placeholderLabel = UILabel()
         placeholderLabel.text = "Enter some text..."
         placeholderLabel.font = .italicSystemFont(ofSize: (    personalizationView.textView.font?.pointSize)!)
         placeholderLabel.sizeToFit()
        personalizationView.textView.addSubview(placeholderLabel)
         placeholderLabel.frame.origin = CGPoint(x: 5, y: (    personalizationView.textView.font?.pointSize)! / 2)
         placeholderLabel.textColor = .tertiaryLabel
         placeholderLabel.isHidden = !personalizationView.textView.text.isEmpty
    
        
        configureUI()
        
        imageCollectionView.delegate = self
        imageCollectionView.dataSource = self
        
        reviewTable.delegate = self
        reviewTable.dataSource =  self
        reviewTable.register(ReviewTableViewCell.self, forCellReuseIdentifier: reviewCellIdentifier)
//        reviewTable.rowHeight = .
        
//        reviewTable.estimatedRowHeight = 200 // Or any other value based on your design
        
      
       
        setupUI()
        
        guard let variants = self.product.variations else {return }
        self.setupVariantsWithDelegate(variants)
        fetchProductLikes()
        fecthReviews()
    }
    
    
    
    // MARK: - UI Setup
    private func setupUI() {
        // Set up all UI elements here
        //ScrollView
        if let tabBarController = self.navigationController?.tabBarController as? BuyerTabController {
            self.delegate = tabBarController
        }
        
        containerScrollView.delegate = self
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
        
        imageCollectionView.register(ProductCellImage.self, forCellWithReuseIdentifier: cellImageProductIdentifier)
        

        contentView.addSubview(imageCollectionView)
        contentView.addSubview(favouriteButton)
        contentView.addSubview(productTitle)
      
        
        contentView.addSubview(addToCartButton)
        contentView.addSubview(estimateLabel)
        contentView.addSubview(reviewTable)
        contentView.addSubview(accordionTableView)

//        contentView.addSubview(starRatingView)
//
                
        imageCollectionView.anchor( top: contentView.layoutMarginsGuide.topAnchor, left: contentView.leadingAnchor, right: contentView.trailingAnchor, bottom: nil, paddingTop: 0, paddingLeft: 0,paddingRight: 0, paddingBottom: 0, width: nil, height: self.view.frame.width)
        
        favouriteButton.anchor( top: nil, left: contentView.leadingAnchor, right: nil, bottom: imageCollectionView.bottomAnchor, paddingTop: 0, paddingLeft: 2,paddingRight: 0, paddingBottom: -2, width: 30, height: 30)

        
        productTitle.anchor( top: imageCollectionView.bottomAnchor, left: contentView.leadingAnchor, right: contentView.trailingAnchor, bottom: nil, paddingTop: 10, paddingLeft: 10,paddingRight: -10, paddingBottom: 0, width: nil, height: nil)
        
        let priceStackView  = createStackView(with: [currenyLabel, priceLabel], axis: .horizontal, spacing: 5, distribution: .fillProportionally, alignment: .fill)
        
        contentView.addSubview(priceStackView)
        priceStackView.anchor( top: productTitle.bottomAnchor, left: contentView.leadingAnchor, right: nil, bottom: nil,  paddingTop: 10, paddingLeft: 10,paddingRight: -10, paddingBottom: 0, width: nil, height: nil)
        
        
   
        contentView.addSubview(stackViewVariants)
        
        stackViewVariants.anchor( top: priceStackView.bottomAnchor, left: contentView.leadingAnchor, right: contentView.trailingAnchor, bottom: nil,  paddingTop: 10, paddingLeft: 10,paddingRight: -10, paddingBottom: 0, width: nil, height: nil)
        
        
        contentView.addSubview(personalizationView)
        personalizationView.anchor( top: stackViewVariants.bottomAnchor, left: contentView.leadingAnchor, right: contentView.trailingAnchor, bottom: nil,  paddingTop: 10, paddingLeft: 10,paddingRight: -10, paddingBottom: 0, width: nil, height: nil)
        
        
        
   
        addToCartButton.anchor( top: personalizationView.bottomAnchor, left: contentView.leadingAnchor, right: contentView.trailingAnchor, bottom: nil, paddingTop: 10, paddingLeft: 10,paddingRight: -10, paddingBottom: 0, width: nil, height: 50)
        
        estimateLabel.anchor( top: addToCartButton.bottomAnchor, left: contentView.leadingAnchor, right: contentView.trailingAnchor, bottom: nil, paddingTop: 10, paddingLeft: 10,paddingRight: -10, paddingBottom: 0, width: nil, height: nil)
        
        let descriptionStackView  = createStackView(with: [ descriptionTextView], axis: .vertical, spacing: 5, distribution: .fillProportionally, alignment: .fill)
        contentView.addSubview(descriptionStackView)
        
        descriptionStackView.anchor( top: estimateLabel.bottomAnchor, left: contentView.leadingAnchor, right: contentView.trailingAnchor, bottom: nil,  paddingTop: 25, paddingLeft: 10,paddingRight: -10, paddingBottom: 0, width: nil, height: nil)
        
        
        contentView.addSubview(shopLabel)
        
        shopLabel.anchor(top: descriptionStackView.bottomAnchor, left: contentView.leadingAnchor, right: contentView.trailingAnchor, bottom: nil,  paddingTop: 25, paddingLeft: 10,paddingRight: -10, paddingBottom: 0, width: nil, height: nil)
        
        accordionTableView.anchor( top: shopLabel.bottomAnchor, left: contentView.leadingAnchor, right: contentView.trailingAnchor, bottom: nil,  paddingTop: 25, paddingLeft: 10,paddingRight: -10, paddingBottom: 0, width: nil, height: nil)
        
        reviewTable.anchor( top: accordionTableView.bottomAnchor, left: contentView.leadingAnchor, right: contentView.trailingAnchor, bottom: contentView.bottomAnchor,  paddingTop: 25, paddingLeft: 10,paddingRight: -10, paddingBottom: -100, width: nil, height: nil)
        
        
        
        
        
        
        
        
        
    
    }
    
    
    func setupVariantsWithDelegate(_ variants: [Variant]) {
        // Clear all arranged subviews first
        stackViewVariants.arrangedSubviews.forEach { $0.removeFromSuperview() }

        for variant in variants {
            let fieldView = VariantProductViewField()
            fieldView.label.text = variant.name

            let dropDown = DropDown()
            dropDown.anchorView = fieldView.textField
            dropDown.bottomOffset = CGPoint(x: 0, y: fieldView.textField.bounds.height + 35)
            dropDown.dataSource = variant.options

            dropDown.selectionAction = { [weak self] (index: Int, item: String) in
                print("Selected item: \(item) at index: \(index)")

                // Update the textField with the selected item
                fieldView.textField.text = item

                // Store the selected option for this variant
    
            }

            fieldView.textField.delegate = self
            fieldView.textField.dropDown = dropDown

            stackViewVariants.addArrangedSubview(fieldView)
            
        }
    }
    // MARK: - IBActions
    // Here you add all your @IBActions (functions called by UI interactions like button taps)
    
    // MARK: - Navigation
    // Segue preparations and related stuff
    
    
    // MARK: - Fetching
    
    func fecthReviews(){
      
        Service.shared.fetchReviewForProduct(product.productId, expecting: ApiResponse<[Review]>.self) { [weak self] result in
            guard let self = self else {return }
            switch result {
                
            case .success(let response):
                guard let reviews  = response.data else  {return}
//                print(reviews)
                self.reviews = reviews
                
            case .failure(_):
                print("Couldn't fetch the reviews")
            }
            
        }
        
    }
    
    func fetchProductLikes  (){
        Service.shared.getLikedProducts(expecting: ApiResponse<[Product]>.self) { [weak self] result in
            guard let self = self else {return}
            switch result {
                
            case .success(let response):
                guard let products  =  response.data else {return}
                print(products)
                self.productLike = products.map { $0.productId }
                
            
            case .failure(let error):
                print(error)
                print ("Error")
            }
        }
    }
    // MARK: - Private methods
    // All other functions that you use within the ViewController
    func createStackView(with views: [UIView], axis: NSLayoutConstraint.Axis = .vertical, spacing: CGFloat = 0, distribution: UIStackView.Distribution = .fill , alignment: UIStackView.Alignment = .fill) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: views)
        stackView.axis = axis
        stackView.spacing = spacing
        stackView.distribution = distribution
        stackView.alignment = alignment
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }
    
    
    func configureCell (){
        
    }
    
    
    @objc func handleFavouriteButtno(){
        if isLiked {
            handledisLike()
        }else {
            handleLike()
        }
        
    }
    
    //MARK: OBJECT C
    
     func handledisLike(){
        print("Unlik Product")

        Service.shared.unlikeProduct(productId: product.productId, expecting: ApiResponse<String>.self) { [weak self] result in
            guard let self = self else {return}
            switch result{

            case .success(let response):
                print(response)
                guard let productId2  = response.data else {return}
                
                DispatchQueue.main.async {
//
//                    if self.product.productId == productId2 {
//                        UIView.transition(with: self.favouriteButton, duration: 0.3, options: .transitionCrossDissolve, animations: {
//                              self.favouriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
//                          }, completion: nil)
//                    }
//                    self.delegate?.handleUnlike(cell: self)
                    self.productLike = self.productLike.filter { $0 != productId2 }
                    
                }
            case .failure(let error):
                print(error)
            }
        }
        
       

        
    }
    
     func handleLike(){
        print("Like Product")
   
        Service.shared.likeProduct(productId: product.productId, expecting: ApiResponse<String>.self) { [weak self] result in
            guard let self = self else {return}
            switch result{

            case .success(let response):
                print(response)
                guard let productId2  = response.data else {return}
                
                DispatchQueue.main.async {
                    
//                    if self.product.productId == productId2 {
//                        UIView.transition(with: self.favouriteButton, duration: 0.3, options: .transitionCrossDissolve, animations: {
//                              self.favouriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
//                          }, completion: nil)
//                    }
                    self.productLike.append(productId2)
//                    self.delegate?.handleUnlike(cell: self)
                    
                }
            case .failure(let error):
                print(error)
            }
        }
        
       

        
    }

    
    @objc func handleAddCart(_ sender: UIButton){
     
        
        let personalizationText  = personalizationView.textView.text ?? ""
        
        
        guard  personalizationText != "" else {
            print("Please enter a text")
            AlertManager.showAddToCartError(on: self, message: "Enter personalization ")
          
            return
        }
        
        let variantsArray = getVariantValues()
        
        let cartItem = CartItemSend(productId: product.productId, quantity: 1, price: product.price, hasVariations: true , variations: variantsArray, customizationOptions: [personalizationText], cartItemId: nil, createdAt: nil, updatedAt: nil)
        
        
        let originalColor = sender.backgroundColor
        let originalText  =  sender.title(for: .normal)
        
        addToCartButton.setTitle("ADDED", for: .normal)
        addToCartButton.backgroundColor =  originalColor?.withAlphaComponent(0.5)
        
        // Animate the changes over 0.3 seconds (or any desired duration)
        UIView.animate(withDuration: 0.3, delay: 0.5, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.5, options: [], animations: {
               sender.backgroundColor = originalColor
           }) { _ in
               // Smoothly animate the return of the original title after the background animation finishes
               UIView.transition(with: sender, duration: 0.8, options: .transitionCrossDissolve, animations: {
                   sender.setTitle(originalText, for: .normal)
               }, completion: nil)
           }
        delegate?.addProductToCart(cartItem)
        
        
        
        
    }
    
    func addToCartAnimation() {
        // Create a temporary view for the animation
        let tempView = CustomImageView()// assuming you have a UIImageView for the product
        tempView.loadImageUrlString(urlString: images[0])
        tempView.frame = CGRect(x: tempView.frame.origin.x,
                                y: tempView.frame.origin.y,
                                width: tempView.frame.size.width,
                                height: tempView.frame.size.height)
        
        self.view.addSubview(tempView)

        // Determine the endpoint (the cart's position)
        let cartPosition = addToCartButton.frame.origin // assuming cartButton is the cart's icon or button

        // Animation
        UIView.animate(withDuration: 1.0, animations: {
            // Scale and move the product
            tempView.frame.size.width = 50
            tempView.frame.size.height = 50
            tempView.frame.origin.x = cartPosition.x
            tempView.frame.origin.y = cartPosition.y
            tempView.alpha = 0.5
        }, completion: { _ in
            // Cleanup: Remove the temporary view after animation
            tempView.removeFromSuperview()
        })
    }

    func getVariantValues() -> [VariantCart] {
        var variantCarts: [VariantCart] = []

        for subview in stackViewVariants.arrangedSubviews {
            if let fieldView = subview as? VariantProductViewField,
               let variant = fieldView.label.text,
               let value = fieldView.textField.text,
               !value.isEmpty {

                let variantCart = VariantCart(variant: variant, value: value)
                variantCarts.append(variantCart)
            }
        }

        return variantCarts
    }
    
}

extension ProductViewController: UIScrollViewDelegate{
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
}

extension ProductViewController : UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        placeholderLabel.isHidden = !textView.text.isEmpty
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        placeholderLabel.isHidden = !textView.text.isEmpty
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        placeholderLabel.isHidden = true
    }
}


extension ProductViewController:  UITextFieldDelegate{
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//        textField.resignFirstResponder()
//        dropDown.show()
//    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        textField.dropDown?.show()
        return false // Prevents the keyboard from showing
    }

    
}

extension ProductViewController : AddReviewDelegate {
    func addReview() {
        print("Add new review")
//        if let  productId  = product.productId else {
//            print("Product id is nil")
//            return
//        }
        let vc =  CreateReviePopController(productId: product.productId)
        vc.modalPresentationStyle = .overCurrentContext
        vc.delegate = self
//        vc.modalTransitionStyle = .crossDissolve
//        vc.modalPresentationStyle = .popover
        
        //representative of actually presented VC
        self.definesPresentationContext = true //*** adding this line should solve your issue ***
        self.present(vc, animated: true, completion: nil)
        
    }
    
    
}

extension ProductViewController :  PopReviewControllerDelegate{
    func createNewReview(description: String, rating: Int, productId: String) {
        print("Creating the review")
        Service.shared.createNewReview(rating, description, productId, expecting: ApiResponse<Review>.self) { [weak self] result in
            guard let self = self else {return}
            
            switch result {
                
            case .success(let response):
                guard let review  = response.data else  {return}
                self.reviews.append(review)
//                let newIndexPath = IndexPath(row: data.count, section: 0)
//                data.append(newData) // Append your new data to your data array
//                tableView.insertRows(at: [newIndexPath], with: .automatic)
                DispatchQueue.main.async {
                    self.reviewTable.reloadData()
                    self.reviewTable.layoutSubviews()

                }
            case .failure(let _):
                AlertManager.showReviewError(on: self, message: "Couldn't create a review")
                
                
            }
        }
        
    }
    
    
}


extension ProductViewController  : UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count == 0 ? 1 : images.count
    
    
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell  =  collectionView.dequeueReusableCell(withReuseIdentifier: cellImageProductIdentifier, for: indexPath) as! ProductCellImage
        
        if images.count != 0 {
            cell.mainImage.loadImageUrlString(urlString: images[indexPath.row])
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.imageCollectionView.frame.width, height: self.imageCollectionView.frame.height)
    
    }
    
}

 
extension ProductViewController :  UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: reviewCellIdentifier, for: indexPath) as! ReviewTableViewCell
//        cell.backgroundColor = .blue
        cell.review = reviews[indexPath.row]
        return cell
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviews.count
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 120
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header  =  ReviewProductHeader()
        header.totalReview =  self.reviews.count
        header.delegate = self
        return header
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//        guard let mealId =  mealsFilteredByLetter?[indexPath.row].idMeal else {
//            return
//        }
//        let controller  =  MealViewController(idMeal: mealId)
//        present(controller, animated: true, completion: nil)
//    }
}

