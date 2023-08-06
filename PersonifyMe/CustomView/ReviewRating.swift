//
//  CustomReview.swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 04/08/2023.
//

import Foundation
import UIKit

class ReviewRating: UIView {
    var rating: Double = 0 {
        didSet {
            updateButtons()
        }
    }
    
    private var buttons = [UIButton]()
    private let stackView = UIStackView()
    
    var numberOfStars = 5
    
    var emptyStarImage = UIImage(systemName: "star")
    var filledStarImage = UIImage(systemName: "star.fill")
    var halfFilledStarImage = UIImage(systemName: "star.leadinghalf.filled")
    
    var ratingDidChange: ((Double) -> Void)?
    
    override func layoutSubviews() {
        if buttons.isEmpty {
            createButtons()
        }
    }
    
    private func createButtons() {
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 0
        stackView.isUserInteractionEnabled = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(stackView)
        
        stackView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
        for i in 0..<numberOfStars {
            let button = UIButton()
            button.setImage(emptyStarImage, for: .normal)
            button.tag = i + 1
            
            button.addTarget(self, action: #selector(starButtonTapped(button:)), for: .touchUpInside)
            
            buttons.append(button)
            stackView.addArrangedSubview(button)
        }
    }
    
    @objc private func starButtonTapped(button: UIButton) {
        rating = Double(button.tag)
        ratingDidChange?(rating)
    }
    
    private func updateButtons() {
        for (index, button) in buttons.enumerated() {
            if rating >= Double(index + 1) {
                button.setImage(filledStarImage, for: .normal)
            } else if rating > Double(index) && rating < Double(index + 1) {
                button.setImage(halfFilledStarImage, for: .normal)
            } else {
                button.setImage(emptyStarImage, for: .normal)
            }
        }
    }
}




class StarRatingView: UIView {
    
    enum Mode {
        case interactive
        case display
    }
    
    private var starMode: Mode
    
    private var selectedRate: Int = 0

    private var emptyStarImage = UIImage(systemName: "star")
    private var filledStarImage = UIImage(systemName: "star.fill")
    private var halfFilledStarImage = UIImage(systemName: "star.leadinghalf.fill")

    var rating: Int {
        return selectedRate
    }

    private lazy var starsContainer: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didSelectRate))
        stackView.addGestureRecognizer(tapGesture)
        return stackView
    }()

    init(starMode: Mode) {
        self.starMode = starMode
        super.init(frame: .zero)
        setupView()
        createStars()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        addSubview(starsContainer)
        starsContainer.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            starsContainer.topAnchor.constraint(equalTo: self.topAnchor),
            starsContainer.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            starsContainer.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            starsContainer.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }

    private func createStars() {
        for index in 1...Constants.starsCount {
            let star = makeStarIcon()
            star.tag = index
            starsContainer.addArrangedSubview(star)
        }
    }

    private func makeStarIcon() -> UIImageView {
        let imageView = UIImageView(image: emptyStarImage, highlightedImage: filledStarImage)
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = true
        return imageView
    }

    @objc private func didSelectRate(gesture: UITapGestureRecognizer) {
        guard starMode == .interactive else {
            // If the mode is 'display', we don't allow changing the rating
            return
        }
        let location = gesture.location(in: starsContainer)
        let starWidth = starsContainer.bounds.width / CGFloat(Constants.starsCount)
        let rate = Int(location.x / starWidth) + 1
        self.selectedRate = rate
        updateStars(to: Double(rate))
    }
    
    func setRating(_ rating: Double) {
        updateStars(to: rating)
    }

    private func updateStars(to rating: Double) {
        starsContainer.arrangedSubviews.forEach { subview in
            guard let starImageView = subview as? UIImageView else {
                return
            }
            let highlighted = Double(starImageView.tag) <= rating
            starImageView.isHighlighted = highlighted
            // Set the correct image based on the rating
            if Double(starImageView.tag) - rating < 1 && Double(starImageView.tag) - rating > 0 {
                starImageView.image = halfFilledStarImage
            } else if highlighted {
                starImageView.image = filledStarImage
            } else {
                starImageView.image = emptyStarImage
            }
        }
    }

    private struct Constants {
        static let starsCount: Int = 5
    }
}
