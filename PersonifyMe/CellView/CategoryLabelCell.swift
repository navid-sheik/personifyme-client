//
//  CategoryLabelCell.swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 05/08/2023.
//

import UIKit

class CategoryLabelCell: UITableViewCell {
    // define icon and label
    let iconImageView: CustomImageView = {
        let imageView = CustomImageView()
        imageView.image  =  UIImage(systemName: "trash")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    let categoryLabel: UILabel = {
        let label = UILabel()
        label.text =  "Similar"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // Add the image view and label to the cell's content view
       
     
       
        self.addSubview(iconImageView)
        self.addSubview(categoryLabel)
        
        iconImageView.anchor( top: nil, left: self.leadingAnchor, right: nil, bottom: nil, paddingTop: 0, paddingLeft: 5,paddingRight: 0, paddingBottom: 0, width: 30, height: 30)
        iconImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        categoryLabel.anchor( top: nil, left: self.iconImageView.trailingAnchor, right: self.trailingAnchor, bottom: nil, paddingTop: 0, paddingLeft: 5,paddingRight: -5, paddingBottom: 0, width: nil, height: nil)
        categoryLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
       
        
        // set accessoryType to display chevron to the left (instead of the default right)
        accessoryType = .disclosureIndicator
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureWith(category: Category) {
        categoryLabel.text = category.name
        // Set the image view's image here
        // iconImageView.image = UIImage(named: ...)
    }
}
