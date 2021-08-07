//
//  Menu.swift
//  Food Delivery
//
//  Created by Vignesh J on 07/08/21.
//

import Foundation

struct Menu: Decodable {
    let name: String
    let items: [Item]
}
