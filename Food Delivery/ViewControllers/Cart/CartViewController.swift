//
//  CartViewController.swift
//  Food Delivery
//
//  Created by Vignesh J on 07/08/21.
//

import UIKit

final class CartViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    
    private var footerView: CartTableFooterView?
    
    var cart: Cart!
    
    private let cartItemCellIdentifier = String(describing: CartItemTableViewCell.self)
    private let footerIdentifier = String(describing: CartTableFooterView.self)
    
    private lazy var items: [Item: Int] = self.cart.items
    private lazy var priceFormatter: PriceFormatter = PriceFormatter.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.customizeTableView()
        self.updateFooter(for: self.items)
        self.observeItemChange()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    private func customizeTableView() {
        let cellNib = UINib(nibName: self.cartItemCellIdentifier,
                            bundle: nil)
        let footerNib = UINib(nibName: self.footerIdentifier,
                              bundle: nil)
        
        self.tableView.register(cellNib,
                                forCellReuseIdentifier: self.cartItemCellIdentifier)
        self.tableView.register(footerNib,
                                forHeaderFooterViewReuseIdentifier: self.footerIdentifier)
        
        let footerView = self.tableView.dequeueReusableHeaderFooterView(withIdentifier: self.footerIdentifier) as? CartTableFooterView
        
        self.footerView = footerView
        self.tableView.tableFooterView = footerView
    }

    private func observeItemChange() {
        self.cart.itemsObserver = { [weak self] in
            self?.items = $0
            self?.updateFooter(for: $0)
        }
    }
    
    private func item(at index: Int) -> Item {
        let keys = Array(self.items.keys)
        
        return keys[index]
    }
    
    private func updateFooter(for items: [Item: Int]) {
        if items.isEmpty {
            let attributes: [NSAttributedString.Key: Any] = [
                .foregroundColor: UIColor.black,
                .font: UIFont.systemFont(ofSize: 24,
                                         weight: .medium),
            ]
            let attributedText = NSAttributedString(string: "Your Cart is empty",
                                                    attributes: attributes)
            
            self.footerView?.titleLabel.textAlignment = .center
            self.footerView?.titleLabel.attributedText = attributedText
        } else {
            let currency = items.first!.key.currency
            let price = items.compactMap { $0.key.price }
                .reduce(0, +)
            let deliveryAttributes: [NSAttributedString.Key: Any] = [
                .foregroundColor: UIColor.lightGray,
                .font: UIFont.systemFont(ofSize: 14,
                                         weight: .light),
            ]
            let valueAttributes: [NSAttributedString.Key: Any] = [
                .foregroundColor: UIColor.black,
                .font: UIFont.systemFont(ofSize: 14,
                                         weight: .light),
            ]
            let priceAttributes: [NSAttributedString.Key: Any] = [
                .foregroundColor: UIColor.black,
                .font: UIFont.systemFont(ofSize: 32,
                                         weight: .semibold),
            ]
            let attributedText = NSMutableAttributedString(string: "Delivery is free\n", attributes: deliveryAttributes)
            let valueText = NSAttributedString(string: "Value:",
                                               attributes: valueAttributes)
            let priceString = " \(self.priceFormatter.formatted(price: price, quantity: 1, currency: currency))"
            let priceText = NSAttributedString(string: priceString,
                                               attributes: priceAttributes)
            
            attributedText.append(valueText)
            attributedText.append(priceText)
            
            self.footerView?.titleLabel.textAlignment = .left
            self.footerView?.titleLabel.attributedText = attributedText
        }
        
        guard let footerView = self.footerView else {
            return
        }
        let width = self.tableView.bounds.size.width
        let fittingSize = CGSize(width: width,
                                 height: UIView.layoutFittingCompressedSize.height)
        let size = footerView.systemLayoutSizeFitting(fittingSize)
        
        if footerView.frame.size.height != size.height {
            footerView.frame.size.height = size.height
            self.tableView.tableFooterView = footerView
        }
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
