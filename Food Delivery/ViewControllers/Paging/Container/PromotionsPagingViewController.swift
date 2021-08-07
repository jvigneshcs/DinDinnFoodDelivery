//
//  PromotionsPagingViewController.swift
//  Food Delivery
//
//  Created by Vignesh J on 07/08/21.
//

import UIKit
import Parchment

class PromotionsPagingViewController: PagingViewController {
    
    override func loadView() {
        self.view = PromotionsContainerPagingView(options: self.options,
                                                  collectionView: self.collectionView,
                                                  pageView: self.pageViewController.view)
    }

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
