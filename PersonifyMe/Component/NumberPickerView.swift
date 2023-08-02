//
//  NumberPickerView.swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 01/08/2023.
//

import Foundation
import UIKit

protocol NumberPickerDelegate: AnyObject {
    func didSelectNumber(_ number: Int)
}
class NumberPickerView: UIView, UIPickerViewDelegate, UIPickerViewDataSource {

    weak var delegate: NumberPickerDelegate?
    private var numbers: [Int] = []
    private let pickerView = UIPickerView()

    init(numbers: [Int], frame: CGRect) {
        super.init(frame: frame)
        self.numbers = numbers
        pickerView.delegate = self
        pickerView.dataSource = self
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        self.backgroundColor = .white
        self.addSubview(pickerView)
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pickerView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            pickerView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            pickerView.widthAnchor.constraint(equalTo: self.widthAnchor),
            pickerView.heightAnchor.constraint(equalToConstant: 200)
        ])

//        let selectButton = UIButton(type: .system)
//        selectButton.setTitle("Select", for: .normal)
//        selectButton.addTarget(self, action: #selector(didTapSelectButton), for: .touchUpInside)
//
//        self.addSubview(selectButton)
//        selectButton.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            selectButton.topAnchor.constraint(equalTo: pickerView.bottomAnchor, constant: 20),
//            selectButton.centerXAnchor.constraint(equalTo: self.centerXAnchor)
//        ])
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return numbers.count
    }

    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedNumber = numbers[pickerView.selectedRow(inComponent: 0)]
        delegate?.didSelectNumber(selectedNumber)

        // Animation
        UIView.animate(withDuration: 0.3, animations: {
            self.frame = CGRect(x: 0, y: self.frame.origin.y + self.frame.height, width: self.frame.width, height: self.frame.height)
        }) { _ in
            self.removeFromSuperview()
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(numbers[row])"
    }

//    @objc private func didTapSelectButton() {
//        
//    }
}
