//
//  DeliveryEstimationService.swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 13/08/2023.
//

import Foundation


struct DeliveryEstimationService {

    private func estimateDeliveryDateRange(for info: ShippingInfo, isInternational: Bool = false) -> (earliest: Date, latest: Date) {
        let currentDate = Date()
        let calendar = Calendar.current

        let minProcessingDate = calendar.date(byAdding: .day, value: info.processingTime.min, to: currentDate)!
        let maxProcessingDate = calendar.date(byAdding: .day, value: info.processingTime.max, to: currentDate)!

        let delivery = isInternational ? (info.internationalDelivery ?? info.standardDelivery) : info.standardDelivery

        let earliestDeliveryDate = calendar.date(byAdding: .day, value: delivery.deliveryTime.min, to: minProcessingDate)!
        let latestDeliveryDate = calendar.date(byAdding: .day, value: delivery.deliveryTime.max, to: maxProcessingDate)!

        return (earliestDeliveryDate, latestDeliveryDate)
    }

    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd"
        return formatter.string(from: date)
    }

    func deliveryMessage(for info: ShippingInfo, isInternational: Bool = false) -> String {
        let (earliest, latest) = estimateDeliveryDateRange(for: info, isInternational: isInternational)
        
        let earliestStr = formatDate(earliest)
        let latestStr = formatDate(latest)
        
        return "Place your order today, and receive your package \n between \(earliestStr) to \(latestStr)"
    }
}

// MARK: - Usage


