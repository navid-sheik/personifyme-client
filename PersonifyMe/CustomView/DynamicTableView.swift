//
//  DynamicTableView.swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 05/08/2023.
//

import Foundation
import UIKit

class DynamicTableView: UITableView {

    /// Will assign automatic dimension to the rowHeight variable
    /// Will asign the value of this variable to estimated row height.
    var dynamicRowHeight: CGFloat = UITableView.automaticDimension {
        didSet {
            rowHeight = UITableView.automaticDimension
            estimatedRowHeight = dynamicRowHeight
        }
    }

    public override var intrinsicContentSize: CGSize { contentSize }

    public override func layoutSubviews() {
        super.layoutSubviews()
        if !bounds.size.equalTo(intrinsicContentSize) {
            invalidateIntrinsicContentSize()
        }
    }
}
