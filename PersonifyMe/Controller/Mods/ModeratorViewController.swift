//
//  ModeratorViewController.swift
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

class ModeratorViewController: UIViewController {
    
    var  products : [Product] = [] {
        didSet{
            DispatchQueue.main.async {
                self.productCollectionView.reloadData()
            }
           
        }
        
    }
    
    let identifierCell : String  = "collecitonViewModIdentifier"
    // MARK: - Components
    // Here you add all components
    let label : UILabel  =  {
        let label = UILabel()
        label.text  =  "Something"
        return label
    }()
    
    let productCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
       
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.isScrollEnabled = true
        cv.backgroundColor = .systemBackground
        cv.contentInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    
        return cv
    }()
    
    
    // MARK: - Properties
    // All properties and variables you need in your ViewController
    
    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor  = .systemBackground
        
        setUpnavigationController()
        setupCollectionView()
        setupUI()
        fetchUnverifiedPorducts()
    }
    
    

 
//    override func viewDidDisappear(_ animated: Bool) {
//        super.viewDidDisappear(animated)
//        navigationController?.navigationBar.isHidden = true
////        navigationController?.navigationBar.prefersLargeTitles = true
////        navigationItem.title =  "Moderation"
//    }
//
    
    private func setUpnavigationController (){
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.title =  "Moderation"

    }
    private func fetchUnverifiedPorducts(){
        Service.shared.getAllUniverifiedProducts(expecting: ApiResponse<[Product]>.self) { [weak self] result in
            
            guard let self = self else {return}
            switch result{
                
            case .success(let response):
                guard let products  = response.data else {return}
                self.products =  products
            case .failure(_):
                print("Moderation products errro ")
            }
        }
        
    }
    private func setupCollectionView() {
        productCollectionView.delegate = self
        productCollectionView.dataSource = self
        productCollectionView.register(ModerationCellView.self, forCellWithReuseIdentifier: identifierCell)
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        // Set up all UI elements here
        view.addSubview(productCollectionView)
        
        productCollectionView.anchor( top: view.layoutMarginsGuide.topAnchor, left: view.leadingAnchor, right: view.trailingAnchor, bottom: view.bottomAnchor, paddingTop: 0, paddingLeft: 0,paddingRight: 0, paddingBottom: 0, width: nil, height: nil)
        
    }
    
    
    // MARK: - IBActions
    // Here you add all your @IBActions (functions called by UI interactions like button taps)
    
    // MARK: - Navigation
    // Segue preparations and related stuff
    
    // MARK: - Private methods
    // All other functions that you use within the ViewController
}


extension ModeratorViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifierCell, for: indexPath) as! ModerationCellView
     

        cell.delegate = self
        cell.product = products[indexPath.row]
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        let width = (view.frame.width / 2) - 10
        let height = width * 1.3
        return CGSize(width: width, height: height)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2.5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let product =  products[indexPath.row]
        let vc  = ProductViewController(product: product)
        navigationController?.pushViewController(vc, animated: true)
    }
}


extension ModeratorViewController : ModerationCellViewDelegate{
    func approveItem(on cell: ModerationCellView, with product: Product) {
        print("delegate")
        
        Service.shared.approveItem(with: product.productId, expecting: ApiResponse<Product>.self) { [weak self] result in
            guard let self  = self else {return}
            switch result{
                
            case .success(let response):
                guard let productObject = response.data else {return}
                
                
                DispatchQueue.main.async {
                    if let indexPath = self.productCollectionView.indexPath(for: cell) {
                          // Perform deletion
                        self.productCollectionView.performBatchUpdates({
                              // Remove item from data source
                            self.products.remove(at: indexPath.item)
                              // Remove item from collection view
                            self.productCollectionView.deleteItems(at: [indexPath])
                          }, completion: nil)
                      }
                }
            
            case .failure(_):
                print ("Error")
            }
        }
    }
    
    func disapproveItem(on cell: ModerationCellView, with product: Product) {
        
        
        let alertController = UIAlertController(title: "Disapprove Item", message: "Please enter a reason for disapproving the item.", preferredStyle: .alert)
           
           // Add a text field to the alert controller
           alertController.addTextField { (textField) in
               textField.placeholder = "Enter reason"
           }
        
        let okAction = UIAlertAction(title: "Confirm", style: .default) { [weak self, weak alertController] _ in
            guard let self = self, let textField = alertController?.textFields?.first, let reason = textField.text else {
                return
            }
            self.rejectProjectWithMessage(on: cell, with: product, and: reason)
            
            
            
        }
        alertController.addAction(okAction)
        
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    func rejectProjectWithMessage ( on cell: ModerationCellView, with product: Product, and message : String){
        
        Service.shared.dissaproveItem(with: product.productId, and : message,   expecting: ApiResponse<Product>.self) { [weak self] result in
            guard let self  = self else {return}
            switch result{
                
            case .success(let response):
                guard let productObject = response.data else {return}
                
                
                DispatchQueue.main.async {
                    if let indexPath = self.productCollectionView.indexPath(for: cell) {
                          // Perform deletion
                        self.productCollectionView.performBatchUpdates({
                              // Remove item from data source
                            self.products.remove(at: indexPath.item)
                              // Remove item from collection view
                            self.productCollectionView.deleteItems(at: [indexPath])
                          }, completion: nil)
                      }
                }
            
            case .failure(_):
                print ("Error")
            }
        }

    }
    
    
}
