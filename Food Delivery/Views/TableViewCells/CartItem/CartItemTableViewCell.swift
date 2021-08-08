//
//  CartItemTableViewCell.swift
//  Food Delivery
//
//  Created by Vignesh J on 08/08/21.
//

import UIKit

class CartItemTableViewCell: UITableViewCell {
    
    @IBOutlet private(set) weak var removeButton: UIButton!
    @IBOutlet private weak var itemImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func display(item: Item,
                 quantity: Int) {
        var title = item.name
        if quantity > 1 {
            title += "  x \(quantity)"
        }
        self.itemImageView?.image = UIImage(named: item.imageName)
        self.titleLabel.text = title
        self.priceLabel.text = item.formatterPriceWithCurrency(quantity: quantity)
    }
}
