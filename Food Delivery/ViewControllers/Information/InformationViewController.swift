//
//  InformationViewController.swift
//  Food Delivery
//
//  Created by Vignesh J on 07/08/21.
//

import UIKit

final class InformationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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

extension InformationViewController: SelfInitViewController {
    
    static var instance: InformationViewController {
        let storyboard = UIStoryboard(name: "Shopping",
                                      bundle: nil)
        let identifier = String(describing: InformationViewController.self)
        
        return storyboard.instantiateViewController(withIdentifier: identifier) as! InformationViewController
    }
}
