//
//  FAB.swift
//  Food Delivery
//
//  Created by Vignesh J on 07/08/21.
//

import UIKit
import BadgeSwift

class FAB: UIControl {
    
    @IBOutlet private weak var button: UIButton!
    @IBOutlet private weak var badge: BadgeSwift!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.registerNib(for: FAB.self)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.registerNib(for: FAB.self)
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    @IBAction private func onTapButton(_ sender: UIButton) {
        self.sendActions(for: .touchUpInside)
    }
    
    /// Registers the corresponding NIB file
    private func registerNib(for aClass: AnyClass) {
        let bundle = Bundle(for: aClass)
        let nib = UINib(nibName: String(describing: aClass),
                        bundle: bundle)
        guard let view = nib.instantiate(withOwner: self,
                                         options: nil).first as? UIView else {
            return
        }
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth,
                                 .flexibleHeight]
        self.addSubview(view)
    }
    
    private func addShadow() {
        // Apply a shadow
        self.layer.shadowRadius = 8.0
        self.layer.shadowOpacity = 0.10
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0,
                                         height: 5)
    }
}
