//
//  Item.swift
//  Food Delivery
//
//  Created by Vignesh J on 07/08/21.
//

import Foundation

struct Item: Decodable {
    let identifier: String
    let name: String
    let description: String
    let quantity: String
    let price: Double
    let currency: String
    let imageName: String
}

extension Item: Equatable,
                Hashable {
    
    static func == (lhs: Item, rhs: Item) -> Bool {
        lhs.identifier == rhs.identifier
    }
}

extension Item {
    
    private static var valueFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 2
        
        return formatter
    }()
    
    var formatterPrice: String {
        self.formattedPrice(quantity: 1)
    }
    
    func formatterPriceWithCurrency(quantity: Int) -> String {
        "\(self.formattedPrice(quantity: quantity)) \(self.currency)"
    }
    
    private func formattedPrice(quantity: Int) -> String {
        let number = NSNumber(value: self.price * Double(quantity))
        
        return Self.valueFormatter.string(from: number)!
    }
}
