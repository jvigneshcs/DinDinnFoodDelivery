//
//  Item.swift
//  Food Delivery
//
//  Created by Vignesh J on 07/08/21.
//

import Foundation

struct Item: Decodable {
    let name: String
    let description: String
    let quantity: String
    let price: Double
    let currency: String
    let imageName: String
}
