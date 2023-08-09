//
//  ReusableProgressBar.swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 07/08/2023.
//

import Foundation
import UIKit

class ReusableProgressBar: UIView {
    
    private var progressView: UIProgressView = {
        let pView = UIProgressView(progressViewStyle: .default)
        pView.translatesAutoresizingMaskIntoConstraints = false
        return pView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        addSubview(progressView)
        
        NSLayoutConstraint.activate([
            progressView.leadingAnchor.constraint(equalTo: leadingAnchor),
            progressView.trailingAnchor.constraint(equalTo: trailingAnchor),
            progressView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    func setProgress(_ progress: Progress) {
        progressView.observedProgress = progress
    }
}
