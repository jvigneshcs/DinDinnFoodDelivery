//
//  PriceFormatter.swift
//  Food Delivery
//
//  Created by Vignesh J on 08/08/21.
//

import Foundation

struct PriceFormatter {
    
    private var valueFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 2
        
        return formatter
    }()
    
    static let shared = PriceFormatter()
    
    init() {}
    
    func formatted(price: Double,
                   quantity: Int,
                   currency: String) -> String {
        "\(self.formatted(price: price, quantity: quantity)) \(currency)"
    }
    
    func formatted(price: Double,
                   quantity: Int) -> String {
        let number = NSNumber(value: price * Double(quantity))
        
        return self.valueFormatter.string(from: number)!
    }
}
