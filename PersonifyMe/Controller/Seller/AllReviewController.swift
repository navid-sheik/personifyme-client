//
//  AllReviewController.swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 20/08/2023.
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

enum TypeReviewController {
    case product
    case shop
    case user_logged
    case seller
}

class AllReviewController: UIViewController {
    
    
    var typeReview : TypeReviewController
    let reviewCellIdentifier  =  "reviewCellIdentifier"
    let reviewCellIdentifierAdmin  =  "reviewCellIdentifierAdmin"
    var reviews : [Review] = []{
        didSet{
            DispatchQueue.main.async {
                self.reviewTable.reloadData()
                self.reviewTable.layoutIfNeeded()
            }
            
        }
    }
    
    var sellerId : String?
    
    //    private let starRatingView: StarRatingView = {
    //        let ratingView = StarRatingView(starMode: .interactive)
    //            ratingView.translatesAutoresizingMaskIntoConstraints = false
    //
    //            return ratingView
    //        }()
    //
    //    let reviewTable  : DynamicTableView = {
    //        let tb = DynamicTableView()
    //        tb.backgroundColor = .white
    //        tb.alwaysBounceVertical = false
    ////        tb.tableFooterView =  UIView()
    //        return tb
    //    }()
    
    let reviewTable : DynamicTableView = {
        let table = DynamicTableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor = .systemBackground
        table.separatorStyle = .singleLine
        //
        //        table.rowHeight = UITableView.automaticDimension
        //        table.estimatedRowHeight = 95
        //
        
        
        
        
        return table
    }()
    
    // MARK: - Components
    // Here you add all components
    let label : UILabel  =  {
        let label = UILabel()
        label.text  =  "Something"
        return label
    }()
    

    // MARK: - Properties
    // All properties and variables you need in your ViewController
    
    init(typeReview : TypeReviewController,  reviews: [Review]? , sellerId : String?) {
        self.typeReview = typeReview
        super.init(nibName: nil, bundle: nil)
       
        switch self.typeReview {
            
            
        case .product:
            guard let reviews = reviews else {return}
            self.reviews = reviews
        case .shop:
            guard let reviews = reviews else {return}
            self.reviews = reviews
            return
        case .user_logged:
            return
        case .seller:
            self.sellerId = sellerId
            return
        }
        
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor  = .systemBackground
       
        setUpTableRevieew()
        setupUI()
        fetchReview()
    }
    

    

    
    func fetchReview(){
        switch typeReview {
        case .product:
            return
        case .shop:
            return
        case .user_logged:
            getCurrentUserReviews()
            return
        case .seller:
            sellerReview()
            return
        }
    
    }
    
    func getCurrentUserReviews(){
        Service.shared.getUserLoggedInReviews(  expecting: ApiResponse<[Review]>.self) { [weak self] result  in
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
    
    func sellerReview(){
        guard let sellerId  = sellerId  else {return}
        Service.shared.getSellerReviews( with: sellerId,  expecting: ApiResponse<[Review]>.self) { [weak self] result  in
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
    private func setUpTableRevieew(){
        
        reviewTable.delegate = self
        reviewTable.dataSource =  self
        reviewTable.register(ReviewTableViewCell.self, forCellReuseIdentifier: reviewCellIdentifier)
        reviewTable.register(ReviewAdminViewCell.self, forCellReuseIdentifier: reviewCellIdentifierAdmin)
 
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        // Set up all UI elements here
        view.addSubview(reviewTable)
        
        reviewTable.anchor( top: view.safeAreaLayoutGuide.topAnchor, left: view.leadingAnchor, right: view.trailingAnchor, bottom: view.bottomAnchor, paddingTop: 0, paddingLeft: 0,paddingRight: 0, paddingBottom: 0, width: nil, height: nil)
        
    }
    
    
    // MARK: - IBActions
    // Here you add all your @IBActions (functions called by UI interactions like button taps)
    
    // MARK: - Navigation
    // Segue preparations and related stuff
    
    // MARK: - Private methods
    // All other functions that you use within the ViewController
}


extension AllReviewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        //        cell.backgroundColor = .blue
        
        switch typeReview {
            
        
        case .user_logged , .seller:
            let cell  = tableView.dequeueReusableCell(withIdentifier: reviewCellIdentifierAdmin, for: indexPath) as! ReviewAdminViewCell
            cell.review = reviews[indexPath.row]
            cell.selectionStyle = .none
            return cell
        default:
            let cell  = tableView.dequeueReusableCell(withIdentifier: reviewCellIdentifier, for: indexPath) as! ReviewTableViewCell
            cell.review = reviews[indexPath.row]
            cell.selectionStyle = .none
            return cell
        }
  
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviews.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor =  .systemBackground
        
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 24)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            label.topAnchor.constraint(equalTo: view.topAnchor),
            label.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        switch typeReview {
        case .product:
            label.text = "All Product Reviews"
            // Optionally: getCurrentProductReviews()
        case .shop:
            label.text = "Shop Reviews"
            // Optionally: getShopReviews()
        case .user_logged:
            label.text = "Your Reviews"
        case .seller:
            label.text = "Seller Reviews"

        }
        
        return view
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch typeReview {
        case .seller,.user_logged :
            let product  =  reviews[indexPath.row].productId
            let vc =  ProductViewController(product: product)
            navigationController?.pushViewController(vc, animated: true)
            
        default:
            return

        }
        
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        switch typeReview {
        case .user_logged :
            return true
            
        default:
            return false
        }
    }
        
    
   

    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
         return .delete
     }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
           if editingStyle == .delete {
               // Remove the review from your data source
               let reviewId  = reviews[indexPath.row].reviewId
               Service.shared.deleteReview(with: reviewId, expecting: ApiResponse<String>.self) { [weak self] result in
                   
                   switch result{
                   case .success(_):
                    
                       DispatchQueue.main.async {
                           
                         
                           self?.reviews.remove(at: indexPath.row)
                             // Remove the cell from the table view
                             tableView.deleteRows(at: [indexPath], with: .fade)
                       }
                   case .failure(_):
                       print("Error in deteting review")
                   }
               }
             
           }
       }
    
    
    
    
}
