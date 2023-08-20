//
//  PayoutHistoryCell.swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 09/08/2023.
//

import Foundation
import UIKit

class PayoutHistoryCell : CustomCell{
    
    
    //MARK: - PROPERTIES
    
    var payout: StripePayoutDetail?{
        didSet{
            guard let payout =  payout else {return}
            if payout.status == "paid"{
                self.statusIcon.image = UIImage(systemName: "checkmark.circle")
            }else{
                self.statusIcon.image = UIImage(systemName: "clock.fill")
            
            }
            if  let currecyCountry = GlobalArrays.currencySymbols[payout.currency.uppercased()]{
                
                self.amountLabel.text =   "\(payout.bankAccountDetails.country) \(currecyCountry)\(StripeManager.convertStripeAmountToDouble(payout.amount)) \(payout.status)"
            }else {
                self.amountLabel.text =   "\(payout.bankAccountDetails.country) \(StripeManager.convertStripeAmountToDouble(payout.amount)) \(payout.status)"
            }
        
            //Make string entroplation
        
            self.bankLabel.text = "\(payout.bankAccountDetails.bankName) ***\(payout.bankAccountDetails.last4)"
            self.dateLabel.text =  TimeManager.formatStripeDate(payout.arrivalDate)
        }
    }
    
    let statusIcon  : UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
//        imageView.image = UIImage(systemName: "checkmark.circle.fill")
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let amountLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
//        label.text = "US $20.13 paid"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = UIColor.gray
        return label
    }()
    
    let dateLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
//        label.text = "on 13 Jul, 02:02"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = UIColor.gray
        return label
    }()
    
    let bankLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
//        label.text = "NAT TEST BANK ****6789"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = UIColor.gray
        return label
    }()
    
    

    
    
    override func setUpCell() {
        contentView.addSubview(statusIcon)
        statusIcon.anchor(top: nil, left: self.leadingAnchor, right: nil, bottom: nil, paddingTop: 0, paddingLeft: 10, paddingRight: 0, paddingBottom: 0, width: 20, height: 20)
        statusIcon.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        
        let bankStack =  StackManager.createStackView(with: [bankLabel, dateLabel], axis: .horizontal, spacing: 3, distribution: .fillProportionally, alignment: .center)
        
        let mainStack  =  StackManager.createStackView(with: [amountLabel, bankStack], axis: .vertical, distribution: .fillEqually, alignment: .leading)
        
        contentView.addSubview(mainStack)
        mainStack.anchor(top: nil, left: self.statusIcon.trailingAnchor, right: self.trailingAnchor, bottom: nil, paddingTop: 0, paddingLeft: 10, paddingRight: 0, paddingBottom: 0, width: nil, height: nil)
        
        mainStack.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
    
    }
    
    
}
