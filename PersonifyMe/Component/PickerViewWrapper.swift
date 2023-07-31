//
//  PickerViewWrapper.swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 29/07/2023.
//

import Foundation
import UIKit

class PickerViewWrapper: UIView, UIScrollViewDelegate {
    let pickerView = UIPickerView()
    let scrollView = UIScrollView()

    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(scrollView)
        scrollView.addSubview(pickerView)

        scrollView.delegate = self
        scrollView.decelerationRate = UIScrollView.DecelerationRate.fast // or .normal
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
