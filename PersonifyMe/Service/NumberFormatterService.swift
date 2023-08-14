//
//  NumberFormatter.swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 14/08/2023.
//

import Foundation

import UIKit

struct NumberFormatterService {
    
    static func formatToTwoDecimalPlaces(_ number: Double) -> String {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter.string(from: NSNumber(value: number)) ?? ""

    }
    
    
}
