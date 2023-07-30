//
//  CountryPickerView.swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 29/07/2023.
//

import UIKit
import Foundation

class CountryPickerView: UIView, UIPickerViewDataSource, UIPickerViewDelegate {
    let pickerView = UIPickerView()
    var countries = ["United States", "United Kingdom", "Germany", "India", "Russia", "Japan", "Canada"]

    var selectedCountry: String? {
        didSet {
            if let selectedCountry = selectedCountry,
               let index = countries.firstIndex(of: selectedCountry) {
                pickerView.selectRow(index, inComponent: 0, animated: false)
            }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    private func commonInit() {
        pickerView.delegate = self
        pickerView.dataSource = self
        addSubview(pickerView)

        pickerView.translatesAutoresizingMaskIntoConstraints = false
        pickerView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        pickerView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        pickerView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        pickerView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return countries.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return countries[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedCountry = countries[row]
    }
}
