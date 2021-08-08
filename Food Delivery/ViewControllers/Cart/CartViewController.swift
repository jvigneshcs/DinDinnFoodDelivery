//
//  CartViewController.swift
//  Food Delivery
//
//  Created by Vignesh J on 07/08/21.
//

import UIKit

final class CartViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    
    var cart: Cart!
    
    private let cartItemCellIdentifier = String(describing: CartItemTableViewCell.self)
    
    private lazy var items: [Item: Int] = self.cart.items

    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: self.cartItemCellIdentifier,
                        bundle: nil)

        self.observeItemChange()
        self.tableView.register(nib,
                                forCellReuseIdentifier: self.cartItemCellIdentifier)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    private func observeItemChange() {
        self.cart.itemsObserver = { [weak self] in
            self?.items = $0
        }
    }
    
    private func item(at index: Int) -> Item {
        let keys = Array(self.items.keys)
        
        return keys[index]
    }
}

extension CartViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: self.cartItemCellIdentifier) as? CartItemTableViewCell else {
            return UITableViewCell()
        }
        
        let item = self.item(at: indexPath.row)
        let quantity = self.items[item]!
        
        cell.display(item: item,
                     quantity: quantity)
        cell.removeButton.addTarget(self,
                                    action: #selector(self.onTapRemove(_:)),
                                    for: .touchUpInside)
        
        return cell
    }
    
    @objc private func onTapRemove(_ sender: UIButton) {
        guard let indexPath = self.indexPath(for: sender) else {
            return
        }
        
        let item = self.item(at: indexPath.row)
        self.cart.removeAll(item: item)
        self.tableView.performBatchUpdates ({ [weak self] in
            self?.tableView.deleteRows(at: [indexPath],
                                       with: .automatic)
        }, completion: nil)
    }
    
    private func indexPath(for button: UIButton) -> IndexPath? {
        let touchPoint: CGPoint = button.convert(.zero,
                                                 to: self.tableView)
        
        return self.tableView.indexPathForRow(at: touchPoint)
    }
}

extension CartViewController: SelfInitViewController {
    
    static var instance: CartViewController {
        let storyboard = UIStoryboard(name: "Shopping",
                                      bundle: nil)
        let identifier = String(describing: CartViewController.self)
        
        return storyboard.instantiateViewController(withIdentifier: identifier) as! CartViewController
    }
}
