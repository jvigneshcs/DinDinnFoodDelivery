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
