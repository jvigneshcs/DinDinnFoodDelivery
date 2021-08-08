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
    
    var formattedPrice: String {
        self.formattedPrice(quantity: 1)
    }
    
    func formattedPriceWithCurrency(quantity: Int) -> String {
        "\(self.formattedPrice(quantity: quantity)) \(self.currency)"
    }
    
    private func formattedPrice(quantity: Int) -> String {
        PriceFormatter.shared.formatted(price: self.price,
                                        quantity: quantity)
    }
}
