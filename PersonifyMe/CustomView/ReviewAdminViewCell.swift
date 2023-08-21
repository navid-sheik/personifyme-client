//
//  ReviewAdminViewCell.swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 20/08/2023.
//

import Foundation
import UIKit
class ReviewAdminViewCell : UITableViewCell {
    
    
    var review : Review?{
        didSet{
            guard let  username = review?.user_info.name else {return }
            guard let  user_id_from_server = review?.user_info.userId else {return }
            guard let user_id  = UserDefaults.standard.object(forKey: "user_id") as? String else {return}
            guard let rating = review?.rating else {return }
            guard let text = review?.text else {return }
            guard let dateCreated = review?.updatedAt else {return }
            self.starRatingView.setRating(Double(rating))
            if user_id_from_server == user_id {
                self.describingLabel.text =  "You left a review \(TimeManager.timeAgo(from: dateCreated))"
            }else {
                self.describingLabel.text =  "\(username) left a review \(TimeManager.timeAgo(from: dateCreated))"
            }
         
            if let imageUrl  =  review?.productId.images.first {
                self.mainImage.loadImageUrlString(urlString: imageUrl)
            }
            
        }
    }
    
//    var profileUserimage : String?{
//        didSet{
//            guard let profileUserimageString  = profileUserimage else {return}
//            mainImage.loadImageUrlString(urlString: profileUserimageString)
//        }
//    }
    
   
     
    
    
    
    
    let mainImage : CustomImageView  = {
        let imageView  = CustomImageView()
        imageView.image =  UIImage(named: "image-placeholder")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius =  .init(10)
        
        imageView.clipsToBounds = true
        imageView.backgroundColor =  .init(white: 0.9, alpha: 0.5)
        return imageView
    }()
    
    let  describingLabel : UILabel = {
        let label = UILabel()
        label.text = "Username left review ,24 ago"
        label.font = UIFont.italicSystemFont(ofSize: 14)
        return label
    }()

    
    
    
    
    
    lazy var starRatingView: StarRatingView = {
        let ratingView = StarRatingView(starMode: .display)
            ratingView.translatesAutoresizingMaskIntoConstraints = false
            
            return ratingView
        }()
   

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    
        backgroundColor = .white
        starRatingView.setRating(5)
        setUpCell()
       
    }
    

      

    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    let reviewTetxt : UITextView =  {
        let textView  =  UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.layer.masksToBounds = true
//        textView.text = "Great thigns"
        textView.textAlignment = .left
        textView.textContainer.lineFragmentPadding = 0
        textView.textContainerInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0);
        textView.font = UIFont.systemFont(ofSize: 14)
        textView.sizeToFit()
        textView.isScrollEnabled = false
        return textView
    }()
    let separator : UIView =  {
        let view  =  UIView()
        view.backgroundColor =  .lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    func setUpCell (){
        
        
        
      
    
        
//        starRatingView.widthAnchor.constraint(equalToConstant: reviewWidth).isActive = true
//        starRatingView.heightAnchor.constraint(equalToConstant: 50).isActive = true
//

        
        let imageWidth = self.frame.width / 4

       
        mainImage.heightAnchor.constraint(equalToConstant: imageWidth).isActive = true
        mainImage.widthAnchor.constraint(equalToConstant: imageWidth).isActive = true
//        let reviewStackWithImage = StackManager.createStackView(with: [mainImage, reviewStack], axis: .horizontal, spacing: 5, distribution: .fillProportionally, alignment: .top)
//
       
        self.addSubview(mainImage)
        mainImage.anchor( top: self.topAnchor, left: self.leadingAnchor, bottom: nil, paddingTop: 20, paddingLeft: 10,paddingRight: 0, paddingBottom: 10, width: nil, height: nil)
        
        let reviewWidth  = self.frame.width / 2
    
        self.addSubview(starRatingView)
        starRatingView.anchor( top: self.topAnchor, left: mainImage.trailingAnchor, right: nil, bottom: nil, paddingTop: 20, paddingLeft: 10,paddingRight: -10, paddingBottom: 0, width: reviewWidth, height: imageWidth / 2.5)
        
        self.addSubview(describingLabel)
//        describingLabel.backgroundColor =  .brown
        describingLabel.anchor( top: starRatingView.bottomAnchor, left: mainImage.trailingAnchor, right: self.trailingAnchor, bottom: nil, paddingTop: 5, paddingLeft: 10,paddingRight: -10, paddingBottom: 0, width: nil, height: 10 )
        

        self.addSubview(reviewTetxt)
        reviewTetxt.anchor( top: mainImage.bottomAnchor, left: self.leadingAnchor, right: self.trailingAnchor, bottom: self.bottomAnchor, paddingTop: 0, paddingLeft: 10,paddingRight: -10, paddingBottom: 0, width: nil, height: nil)

      
//        self.addSubview(separator)
//        separator.anchor(top: mainImage.bottomAnchor, left: self.leadingAnchor, right: self.trailingAnchor, bottom:  self.bottomAnchor, paddingTop: 5, paddingLeft: 10, paddingRight: 0, paddingBottom: 0, width: nil, height: 1)
//

        
        
        
    }
    

    
    
    
}


    

