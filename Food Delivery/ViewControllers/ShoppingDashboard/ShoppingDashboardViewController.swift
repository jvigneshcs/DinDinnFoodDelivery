//
//  ShoppingDashboardViewController.swift
//  Food Delivery
//
//  Created by Vignesh J on 07/08/21.
//

import UIKit
import Parchment

class ShoppingDashboardViewController: PagingViewController {
    
    var cart: Cart!
    
    private let viewControllers = [
        CartViewController.instance,
        OrdersViewController.instance,
        InformationViewController.instance,
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        (self.viewControllers.first as? CartViewController)?.cart = self.cart
        self.dataSource = self
        // Customize the menu styling.
        self.menuItemSize = .selfSizing(estimatedWidth: 150,
                                        height: 40)
        self.font = .systemFont(ofSize: 24,
                                weight: .medium)
        self.selectedFont = .systemFont(ofSize: 24,
                                        weight: .medium)
        self.textColor = .lightGray
        self.selectedTextColor = .black
        self.indicatorOptions = .hidden
        self.borderOptions = .hidden
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ShoppingDashboardViewController: PagingViewControllerDataSource {
    
    func numberOfViewControllers(in pagingViewController: PagingViewController) -> Int {
        self.viewControllers.count
    }
    
    func pagingViewController(_: PagingViewController, viewControllerAt index: Int) -> UIViewController {
        self.viewControllers[index]
    }
    
    func pagingViewController(_: PagingViewController, pagingItemAt index: Int) -> PagingItem {
        PagingIndexItem(index: index,
                        title: self.titleForViewController(at: index))
    }
    private func titleForViewController(at index: Int) -> String {
        let vc = self.viewControllers[index]
        
        if vc.isMember(of: CartViewController.self) {
            return "Cart"
        } else if vc.isMember(of: OrdersViewController.self) {
            return "Orders"
        } else if vc.isMember(of: InformationViewController.self) {
            return "Information"
        } else {
            return ""
        }
    }
}
