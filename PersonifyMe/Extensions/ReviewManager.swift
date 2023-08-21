//
//  ReviewManager.swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 20/08/2023.
//

import Foundation


class ReviewManager {
    
    // Static function to calculate average rating
    static func calculateAverageRating(from reviews: [Review]) -> Double {
        let totalRating = reviews.reduce(0) { $0 + $1.rating }
        return reviews.isEmpty ? 0 : Double(totalRating) / Double(reviews.count)
    }
    
    // Static function to concatenate review texts
    static func concatenateReviewTexts(from reviews: [Review]) -> String {
        return reviews.compactMap { $0.text }.joined(separator: "\n")
    }
}
