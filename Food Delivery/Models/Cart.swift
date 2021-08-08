//
//  Cart.swift
//  Food Delivery
//
//  Created by Vignesh J on 07/08/21.
//

import Foundation

class Cart {
    
    static let shared: Cart = Cart()
    
    var quantityObserver: ((Int) -> Void)?
    var itemsObserver: (([Item: Int]) -> Void)?
    
    private(set) var items = [Item: Int]()
    
    init() {}
    
    func add(item: Item) {
        if let quantity = self.items[item] {
            self.items[item] = quantity + 1
        } else {
            self.items[item] = 1
        }
        self.notifyObserver()
    }
    
    func removeAll(item: Item) {
        self.items[item] = nil
        self.notifyObserver()
    }
    
    private func notifyObserver() {
        let quantity = self.items.compactMap { $1 }.reduce(0, +)
        
        self.quantityObserver?(quantity)
        self.itemsObserver?(self.items)
    }
}
