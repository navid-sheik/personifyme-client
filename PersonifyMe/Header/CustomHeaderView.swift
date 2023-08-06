//
//  CustomHeaderView.swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 05/08/2023.
//

import Foundation
import UIKit
class CustomHeaderView: UITableViewHeaderFooterView {
    var titleLabel: UILabel!
    var chevronImageView: UIImageView!

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        titleLabel = UILabel()
        chevronImageView = UIImageView(image: UIImage(systemName: "chevron.down")) // Default image
        chevronImageView.tintColor = .black

        let stackView = UIStackView(arrangedSubviews: [titleLabel, chevronImageView])
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            stackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
