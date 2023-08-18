//
//  LikesViewController.swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 27/07/2023.
//

import Foundation
import UIKit



class LikesViewController : RestrictedController{
    

    
    
    //MARK: Idenfier
    
    private let likesCellIdentifier =  "likesCellIdentifier"
    
    //MARK: Properties
    
    private var products : [Product]?{
        didSet{
            
            DispatchQueue.main.async {
                self.imageCollectionView.reloadData()
            }
           
        }
    }
    
    
    
  
    
    
    //MARK: - COMPONENTS
    let imageCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .systemBackground
    
        return cv
    }()

    
    
    //MARK: Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Likes"
        
        imageCollectionView.register(ProductLikeCell.self, forCellWithReuseIdentifier: likesCellIdentifier)
        imageCollectionView.delegate  = self
        imageCollectionView.dataSource = self
        imageCollectionView.backgroundColor = .systemBackground
        setUpView()
        fetchProductLikes()
        
    }
    
    
    
    //MARK: Methods
    
  
    private func setUpView(){
        
        self.view.addSubview(imageCollectionView)
        
        imageCollectionView.anchor( top: self.view.layoutMarginsGuide.topAnchor, left: self.view.leadingAnchor, right: self.view.trailingAnchor, bottom: self.view.bottomAnchor, paddingTop: 0, paddingLeft: 0,paddingRight: 0, paddingBottom: 0, width: nil, height: nil)
    
        
    
        
    }
    
    
    //MARK: Selectors
    
    
    //MARK: Helpers
    
    func fetchProductLikes  (){
        Service.shared.getLikedProducts(expecting: ApiResponse<[Product]>.self) { [weak self] result in
            guard let self = self else {return}
            switch result {
                
            case .success(let response):
                guard let products  =  response.data else {return}
                print(products)
                self.products =  products
                
            
            case .failure(let error):
                print(error)
                print ("Error")
            }
        }
    }
}


extension LikesViewController  :  UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  products?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: likesCellIdentifier, for: indexPath) as! ProductLikeCell
        
        //Assign image and if liked or not to cell
    
        cell.product =  products?[indexPath.row]
        cell.delegate = self
        
        
        return cell
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Select item")
        guard let product =  products?[indexPath.row] else {return}
        let controller = ProductViewController(product: product)

        self.navigationController?.pushViewController(controller, animated: true)
    }


    
    
    

}
extension LikesViewController: ProductLikeCellDelegate{
    func handleUnlike(cell: CustomCell) {
        DispatchQueue.main.async {
            if let indexPath = self.imageCollectionView.indexPath(for: cell) {
                // Update your data source first
                self.products?.remove(at: indexPath.item)
                
                // Then delete the item from the collection view with an animation
                self.imageCollectionView.deleteItems(at: [indexPath])
            }
        }
    }
        
    
    
    
}
