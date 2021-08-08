//
//  PromotionViewController.swift
//  Food Delivery
//
//  Created by Vignesh J on 05/08/21.
//

import UIKit

final class PromotionViewController: UIViewController {
    
    @IBOutlet private weak var imageView: UIImageView!
    
    private var image: UIImage!
    
    class func initWithImage(_ image: UIImage) -> PromotionViewController {
        let vc = Self.instance
        vc.image = image
        
        return vc
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.imageView.image = self.image
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

extension PromotionViewController: SelfInitViewController {
    
    static var instance: PromotionViewController {
        let storyboard = UIStoryboard(name: "Promotion",
                                      bundle: nil)
        let identifier = String(describing: PromotionViewController.self)
        
        return storyboard.instantiateViewController(withIdentifier: identifier) as! PromotionViewController
    }
}
