//
//  PromotionsPagingViewController.swift
//  Food Delivery
//
//  Created by Vignesh J on 07/08/21.
//

import UIKit
import Parchment
import UIKitExtension

class PromotionsPagingViewController: PagingViewController {
    
    override func loadView() {
        self.view = PromotionsContainerPagingView(options: self.options,
                                                  collectionView: self.collectionView,
                                                  pageView: self.pageViewController.view)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let view = self.view as? PromotionsContainerPagingView else {
            return
        }
        let vc = PromotionsViewController.instance
        
        self.addChild(vc)
        view.headerView.addSubview(vc.view)
        view.headerView.constrainToEdges(vc.view)
        vc.didMove(toParent: self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard let view = (self.view as? PromotionsContainerPagingView)?.collectionView else {
            return
        }
        
        let bounds = view.bounds
        view.roundCorners(corners: [.topLeft, .topRight],
                          radius: bounds.height)
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
