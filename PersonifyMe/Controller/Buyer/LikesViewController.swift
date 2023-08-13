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
            imageCollectionView.reloadData()
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
        
        
    }
    
    
    
    //MARK: Methods
    
  
    private func setUpView(){
        
        self.view.addSubview(imageCollectionView)
        
        imageCollectionView.anchor( top: self.view.layoutMarginsGuide.topAnchor, left: self.view.leadingAnchor, right: self.view.trailingAnchor, bottom: self.view.bottomAnchor, paddingTop: 0, paddingLeft: 0,paddingRight: 0, paddingBottom: 0, width: nil, height: nil)
    
        
    
        
    }
    
    
    //MARK: Selectors
    
    
    //MARK: Helpers
}


extension LikesViewController  :  UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: likesCellIdentifier, for: indexPath) as! ProductLikeCell
        
        //Assign image and if liked or not to cell 
        
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
