//
//  PromotionCollectionViewCell.swift
//  Food Delivery
//
//  Created by Vignesh J on 09/08/21.
//

import UIKit

class PromotionCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var imageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func set(image: UIImage) {
        self.imageView.image = image
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        setNeedsLayout()
        layoutIfNeeded()
        
        return layoutAttributes
    }
}
