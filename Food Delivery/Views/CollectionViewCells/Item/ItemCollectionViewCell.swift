//
//  ItemCollectionViewCell.swift
//  Food Delivery
//
//  Created by Vignesh J on 07/08/21.
//

import UIKit

class ItemCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var additionalInfoLabel: UILabel!
    @IBOutlet private weak var priceButton: UIButton!
    @IBOutlet private weak var addedLabel: UILabel!
    
    var addTapped: (() -> Void)?
    
    private var shadowLayer: CAShapeLayer!
    private var cornerRadius: CGFloat = 25.0
    private var fillColor: UIColor = .blue

    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Apply rounded corners to contentView
        contentView.layer.cornerRadius = cornerRadius
        contentView.layer.masksToBounds = true
        
        // Set masks to bounds to false to avoid the shadow
        // from being clipped to the corner radius
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = false
        
        // Apply a shadow
        layer.shadowRadius = 8.0
        layer.shadowOpacity = 0.10
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0,
                                    height: 5)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.shadowPath = UIBezierPath(
            roundedRect: bounds,
            cornerRadius: cornerRadius
        ).cgPath
    }
    
    @IBAction private func onTapButton(_ sender: UIButton) {
        self.addTapped?()
    }

    func display(item: Item) {
        self.imageView.image = UIImage(named: item.imageName)
        self.titleLabel.text = item.name
        self.descriptionLabel.text = item.description
        self.additionalInfoLabel.text = item.quantity
        self.priceButton.setTitle(item.formatterPriceWithCurrency(quantity: 1),
                                  for: .normal)
    }
    
    func animateAdded() {
        let duration: TimeInterval = 0.15
        self.addedLabel.alpha = 0
        self.addedLabel.isHidden = false
        
        UIView.animate(withDuration: duration) { [weak self] in
            self?.addedLabel.alpha = 1
        } completion: { [weak self] _ in
            UIView.animate(withDuration: duration,
                           delay: 0.3,
                           options: .curveEaseInOut) {
                self?.addedLabel.alpha = 0
            } completion: { _ in
                self?.addedLabel.isHidden = true
            }
        }
    }
}
