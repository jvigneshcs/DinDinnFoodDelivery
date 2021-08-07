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
        self.initialCustomization()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.registerNib(for: FAB.self)
        self.initialCustomization()
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
    
    func animateBadge(number: Int) {
        if number > 0 {
            self.badge.isHidden = false
            self.animateBadge(with: "\(number)")
        } else {
            self.badge.text = nil
            self.badge.isHidden = true
        }
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
    
    private func initialCustomization() {
        self.addShadow()
        self.badge.isHidden = true
        self.badge.font = .systemFont(ofSize: 12,
                                      weight: .light)
        self.badge.textColor = .white
    }
    
    private func addShadow() {
        // Apply a shadow
        self.layer.shadowRadius = 8.0
        self.layer.shadowOpacity = 0.10
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0,
                                         height: 5)
    }
    
    private func animateBadge(with text: String) {
        let duration: TimeInterval = 0.2
        
        UIView.animate(withDuration: duration) { [weak self] in
            self?.badge.transform = CGAffineTransform(scaleX: 0.5,
                                                      y: 0.5)
            self?.badge.text = text
        } completion: { [weak self] _ in
            UIView.animate(withDuration: duration,
                           delay: .leastNonzeroMagnitude,
                           usingSpringWithDamping: 0.5,
                           initialSpringVelocity: 5,
                           options: .curveEaseInOut) {
                self?.badge.transform = CGAffineTransform(scaleX: 1,
                                                          y: 1)
            } completion: { _ in
                
            }
        }
    }
}
