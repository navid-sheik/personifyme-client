//
//  SellerMenuCollectionView.swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 31/07/2023.
//

import Foundation
import UIKit

class SellerMenuCollectionView : UICollectionView{
    
    let identifierMenuCeller = "sellerCellMenuIdentifier"
    
    let padding: CGFloat = 10
    let spacing: CGFloat = 5
    
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        
        if let layout = layout as? UICollectionViewFlowLayout {
               
                layout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
              // Adjust this to
        }
            
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor =  .systemBackground

//        self.isPagingEnabled = true
//        self.showsHorizontalScrollIndicator = false
//        self.decelerationRate = .normal  // makes scrolling smoother
        self.setUpCollectionView()
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
  
 
    func setUpCollectionView () {
        self.dataSource = self
        self.delegate = self
        self.register(SellerMenuCell.self, forCellWithReuseIdentifier: identifierMenuCeller)
       
    }
    
    
    
    
}


extension SellerMenuCollectionView : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
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
        return CGSize(width: (self.frame.width  - (padding * 2) - spacing) / 2  ,height: 50)
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return spacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return spacing
    }
    

    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let itemSelected  =  SettingsV2.init(rawValue: indexPath.row)
//        delegate?.handleToggle(settingItem: itemSelected)
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
//        return CGSize(width: view.frame.width, height: 50)
//    }
    
}
