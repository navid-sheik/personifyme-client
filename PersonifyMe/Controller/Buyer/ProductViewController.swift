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

class ProductViewController: UIViewController {
    
    var product : Product?{
        didSet{
            guard let product = product else {return}
            productTitle.text = product.title
            imageCollectionView.reloadData()
        }
    
    }
    
    var reviews : [Review] = []{
        didSet{
            DispatchQueue.main.async {
                self.reviewTable.reloadData()
                self.reviewTable.layoutIfNeeded()
            }
            
        }
    }
    
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
            Section(title: "Section 1", items: [GlobalTexts.productionDelivery]),
                   Section(title: "Section 2", items: ["Item 3"])
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
    
    
    
    
    
    
    
    
    
    let reviewTable  : DynamicTableView = {
        let tb = DynamicTableView()
        tb.backgroundColor = .white
        tb.alwaysBounceVertical = false
        tb.tableFooterView =  UIView()
        return tb
    }()

    
    
    // MARK: - Properties
    // All properties and variables you need in your ViewController
    
    
    
    
    //MARK: - INIT
    
    
    
    
    
    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor  = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = false
        
        
        imageCollectionView.delegate = self
        imageCollectionView.dataSource = self
        
        reviewTable.delegate = self
        reviewTable.dataSource =  self
        reviewTable.register(ReviewTableViewCell.self, forCellReuseIdentifier: reviewCellIdentifier)
//        reviewTable.rowHeight = .
        
//        reviewTable.estimatedRowHeight = 200 // Or any other value based on your design
        
        
    
       
        setupUI()
        fecthReviews()
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        // Set up all UI elements here
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
        
        imageCollectionView.register(ProductCellImage.self, forCellWithReuseIdentifier: cellImageProductIdentifier)
        

        contentView.addSubview(imageCollectionView)
        contentView.addSubview(productTitle)
        contentView.addSubview(addToCartButton)
        contentView.addSubview(estimateLabel)
        contentView.addSubview(reviewTable)
        contentView.addSubview(accordionTableView)

//        contentView.addSubview(starRatingView)
//
                
        imageCollectionView.anchor( top: contentView.layoutMarginsGuide.topAnchor, left: contentView.leadingAnchor, right: contentView.trailingAnchor, bottom: nil, paddingTop: 0, paddingLeft: 10,paddingRight: -10, paddingBottom: 0, width: nil, height: self.view.frame.width)
    
        productTitle.anchor( top: imageCollectionView.bottomAnchor, left: contentView.leadingAnchor, right: contentView.trailingAnchor, bottom: nil, paddingTop: 10, paddingLeft: 10,paddingRight: -10, paddingBottom: 0, width: nil, height: nil)
        
        let priceStackView  = createStackView(with: [currenyLabel, priceLabel], axis: .horizontal, spacing: 5, distribution: .fillProportionally, alignment: .fill)
        
        contentView.addSubview(priceStackView)
        priceStackView.anchor( top: productTitle.bottomAnchor, left: contentView.leadingAnchor, right: nil, bottom: nil,  paddingTop: 10, paddingLeft: 10,paddingRight: -10, paddingBottom: 0, width: nil, height: nil)
        
        addToCartButton.anchor( top: priceStackView.bottomAnchor, left: contentView.leadingAnchor, right: contentView.trailingAnchor, bottom: nil, paddingTop: 10, paddingLeft: 10,paddingRight: -10, paddingBottom: 0, width: nil, height: 50)
        
        estimateLabel.anchor( top: addToCartButton.bottomAnchor, left: contentView.leadingAnchor, right: contentView.trailingAnchor, bottom: nil, paddingTop: 10, paddingLeft: 10,paddingRight: -10, paddingBottom: 0, width: nil, height: nil)
        
        let descriptionStackView  = createStackView(with: [ descriptionTextView], axis: .vertical, spacing: 5, distribution: .fillProportionally, alignment: .fill)
        contentView.addSubview(descriptionStackView)
        
        descriptionStackView.anchor( top: estimateLabel.bottomAnchor, left: contentView.leadingAnchor, right: contentView.trailingAnchor, bottom: nil,  paddingTop: 25, paddingLeft: 10,paddingRight: -10, paddingBottom: 0, width: nil, height: nil)
        
        accordionTableView.anchor( top: descriptionStackView.bottomAnchor, left: contentView.leadingAnchor, right: contentView.trailingAnchor, bottom: nil,  paddingTop: 25, paddingLeft: 10,paddingRight: -10, paddingBottom: 0, width: nil, height: nil)
        
        reviewTable.anchor( top: accordionTableView.bottomAnchor, left: contentView.leadingAnchor, right: contentView.trailingAnchor, bottom: contentView.bottomAnchor,  paddingTop: 25, paddingLeft: 10,paddingRight: -10, paddingBottom: -100, width: nil, height: nil)
        
        
        
        
        
        
        
        
        
    
    }
    
    
    // MARK: - IBActions
    // Here you add all your @IBActions (functions called by UI interactions like button taps)
    
    // MARK: - Navigation
    // Segue preparations and related stuff
    
    
    // MARK: - Fetching
    
    func fecthReviews(){
        guard let  productId = product?.productId  else {
            print("We couldn't fetch the product the id")
            return
        }
        Service.shared.fetchReviewForProduct(productId, expecting: ApiResponse<[Review]>.self) { [weak self] result in
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
    
}

extension ProductViewController : AddReviewDelegate {
    func addReview() {
        print("Add new review")
        guard let productId  = product?.productId else {
            print("Product id is nil")
            return
        }
        let vc =  CreateReviePopController(productId: productId)
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
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell  =  collectionView.dequeueReusableCell(withReuseIdentifier: cellImageProductIdentifier, for: indexPath) as! ProductCellImage
        
        if let imageString = product?.images[0]{
            cell.mainImage.loadImageUrlString(urlString: imageString)
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

