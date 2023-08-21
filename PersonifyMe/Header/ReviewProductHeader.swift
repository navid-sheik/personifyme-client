//
//  ReviewProductHeader.swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 04/08/2023.
//

import Foundation
import UIKit


protocol AddReviewDelegate : class {
    func addReview()
}



class ReviewProductHeader: UIView {

        
    //Components of header view
    
    weak var delegate : AddReviewDelegate?
    
    var totalReview : Int? {
        didSet{
            guard let totalReview = totalReview else {return }
            self.totalReviewsLabel.text =  "Total \(totalReview) reviews"
        }
    }
    
    var averageReview : Double?{
        didSet{
            guard let averageReview = averageReview else {return }
            self.averageRatingReview.text = "\(averageReview) out of 5"
            self.starRatingView.setRating(averageReview)
        }
    }
    
    
    
    
    let titleHeader : UILabel = {
        let label = UILabel()
        label.text = "Custom Review"
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = UIColor.lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let plusButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName:  "plus" ), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    

    
    lazy var  starRatingView: StarRatingView = {
        let ratingView = StarRatingView(starMode: .display)
            ratingView.translatesAutoresizingMaskIntoConstraints = false
            return ratingView
    }()
    
    let averageRatingReview : UILabel =  {
        let label = UILabel()
        label.text = "0.0 out of 5"
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = UIColor.lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let totalReviewsLabel : UILabel = {
        let label = UILabel()
        label.text = "Total 0 Reviews"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    
   
  
    
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.backgroundColor = .systemBackground
        plusButton.addTarget(self, action: #selector(addReview), for: .touchUpInside)
        setUpView()
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpView(){
        
        
        let reviewWidth  = self.frame.width / 4
   
        starRatingView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        starRatingView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        let reviewStackView  =  StackManager.createStackView(with: [starRatingView, averageRatingReview] , axis: .horizontal, spacing: 5, distribution: .fillProportionally, alignment: .fill)
        
        
        self.addSubview(titleHeader)
        titleHeader.anchor( top: self.topAnchor, left: self.leadingAnchor, right: self.trailingAnchor, bottom: nil, paddingTop: 10, paddingLeft: 10,paddingRight: -10, paddingBottom: 0, width: nil, height: nil)
        
    
        self.addSubview(plusButton)
        plusButton.anchor( top:  nil, left:  nil, right: self.trailingAnchor, bottom: nil, paddingTop: 10, paddingLeft: 0,paddingRight: -10, paddingBottom: 0, width: 40, height: 40)
        plusButton.centerYAnchor.constraint(equalTo: titleHeader.centerYAnchor).isActive = true
        
        
        self.addSubview(reviewStackView)
        reviewStackView.anchor( top:  titleHeader.bottomAnchor, left: self.leadingAnchor, right: nil, bottom: nil, paddingTop: 10, paddingLeft: 10,paddingRight: 0, paddingBottom: 0, width: nil, height: nil)
        
        self.addSubview(totalReviewsLabel)
        
        totalReviewsLabel.anchor( top:  reviewStackView.bottomAnchor, left: self.leadingAnchor, right: self.trailingAnchor, bottom: nil, paddingTop: 10, paddingLeft: 10,paddingRight: 10, paddingBottom: 0, width: nil, height: nil)
        
        
        
        
    }
    
    
    
    //Private Method
    
    @objc func addReview (){
        delegate?.addReview()
    
    }
    

    
}
