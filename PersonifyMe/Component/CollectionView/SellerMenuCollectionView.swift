//
//  SellerMenuCollectionView.swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 31/07/2023.
//

import Foundation
import UIKit

class SellerMenuCollectionView : UICollectionView{
    
  
    
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        
      
            
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor =  .systemBackground

//        self.isPagingEnabled = true
//        self.showsHorizontalScrollIndicator = false
//        self.decelerationRate = .normal  // makes scrolling smoother
       
//
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func reloadData() {
           super.reloadData()
           self.invalidateIntrinsicContentSize()
       }

       override var intrinsicContentSize: CGSize {
           return collectionViewLayout.collectionViewContentSize
       }
  
 
   
    
    
    
    
}


