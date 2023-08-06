//
//  ReviewCell.swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 04/08/2023.
//

import Foundation
import UIKit


class ReviewTableViewCell : UITableViewCell {
    
    
    var review : Review?{
        didSet{
            guard let  username = review?.username else {return }
            guard let rating = review?.rating else {return }
            guard let text = review?.text else {return }
            guard let dateCreated = review?.updatedAt else {return }
            self.usernameLabel.text = username
            self.starRatingView.setRating(Double(rating))
            self.reviewTetxt.text = text
            self.dateLabel.text =  "Reviewed on \(TimeManager.timeAgo(from: dateCreated))"
        
            
        }
    }
    
    var profileUserimage : String?{
        didSet{
            guard let profileUserimageString  = profileUserimage else {return}
            mainImage.loadImageUrlString(urlString: profileUserimageString)
        }
    }
    
   
     
    
    
    
    
    let mainImage : CustomImageView  = {
        let imageView  = CustomImageView()
        imageView.image =  UIImage(named: "image-placeholder")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius =  .init(10)
        
        imageView.clipsToBounds = true
        imageView.backgroundColor =  .init(white: 0.9, alpha: 0.5)
        return imageView
    }()
    
    let  usernameLabel : UILabel = {
        let label = UILabel()
        label.text = "Navid Sheikh"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    let  dateLabel : UILabel = {
        let label = UILabel()
        label.text = "Navid Sheikh"
        label.font = UIFont.italicSystemFont(ofSize: 10)
        label.numberOfLines = 1
        return label
    }()
    
    
    let reviewTetxt : UITextView =  {
        let textView  =  UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.layer.masksToBounds = true
        textView.text = "Great thigns"
        textView.textAlignment = .left
        textView.textContainer.lineFragmentPadding = 0
        textView.textContainerInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0);
        textView.font = UIFont.systemFont(ofSize: 14)
        textView.sizeToFit()
        textView.isScrollEnabled = false
        return textView
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

    
    
    func setUpCell (){
        
        let reviewWidth  = self.frame.width / 4
    
        
        starRatingView.widthAnchor.constraint(equalToConstant: reviewWidth).isActive = true
        starRatingView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        let  reviewStack =  StackManager.createStackView(with: [usernameLabel, starRatingView], axis: .vertical, spacing: 5, distribution: .fillProportionally, alignment: .leading)
        
        let imageWidth = self.frame.width / 6

       
        mainImage.heightAnchor.constraint(equalToConstant: imageWidth).isActive = true
        mainImage.widthAnchor.constraint(equalToConstant: imageWidth).isActive = true
        let reviewStackWithImage = StackManager.createStackView(with: [mainImage, reviewStack], axis: .horizontal, spacing: 5, distribution: .fillProportionally, alignment: .top)
        
       
        self.addSubview(reviewStackWithImage)
        reviewStackWithImage.anchor( top: self.topAnchor, left: self.leadingAnchor, right: self.trailingAnchor, bottom: nil, paddingTop: 10, paddingLeft: 10,paddingRight: -10, paddingBottom: 0, width: nil, height: nil)
        
    
        self.addSubview(dateLabel)
        dateLabel.anchor( top: reviewStackWithImage.bottomAnchor, left: self.leadingAnchor, right: self.trailingAnchor, bottom: nil, paddingTop: 5, paddingLeft: 10,paddingRight: -10, paddingBottom: 0, width: nil, height: nil)
        
        

        self.addSubview(reviewTetxt)
        reviewTetxt.anchor( top: dateLabel.bottomAnchor, left: self.leadingAnchor, right: self.trailingAnchor, bottom: self.bottomAnchor, paddingTop: 5, paddingLeft: 10,paddingRight: -10, paddingBottom: -10, width: nil, height: nil)
        
        
        
    }
    

    
    
    
}


    

