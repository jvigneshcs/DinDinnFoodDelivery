//
//  PromotionsViewController.swift
//  Food Delivery
//
//  Created by Vignesh J on 08/08/21.
//

import UIKit
import Parchment

final class PromotionsViewController: UIViewController {
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var pageControl: UIPageControl!
    
    let viewControllers: [UIViewController] = [
        PromotionViewController.initWithImage(UIImage(named: "Promo1")!),
        PromotionViewController.initWithImage(UIImage(named: "Promo2")!),
        PromotionViewController.initWithImage(UIImage(named: "Promo3")!),
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        let pageViewController = PageViewController()
        pageViewController.dataSource = self
        pageViewController.delegate = self
        pageViewController.selectViewController(viewControllers[0],
                                                direction: .none)
        let subview = pageViewController.view!
        
        addChild(pageViewController)
        view.addSubview(subview)
        view.constrainToEdges(subview)
        view.sendSubviewToBack(subview)
        pageViewController.didMove(toParent: self)
        self.pageControl.numberOfPages = self.viewControllers.count
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

extension PromotionsViewController: PageViewControllerDataSource {
    func pageViewController(
        _: PageViewController,
        viewControllerBeforeViewController viewController: UIViewController
    ) -> UIViewController? {
        guard let index = viewControllers.firstIndex(of: viewController) else { return nil }
        if index > 0 {
            return viewControllers[index - 1]
        } else {
            return viewControllers[viewControllers.count - 1]
        }
    }

    func pageViewController(
        _: PageViewController,
        viewControllerAfterViewController viewController: UIViewController
    ) -> UIViewController? {
        guard let index = viewControllers.firstIndex(of: viewController) else { return nil }
        if index < viewControllers.count - 1 {
            return viewControllers[index + 1]
        } else {
            return viewControllers[0]
        }
    }
}

extension PromotionsViewController: PageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: PageViewController, willStartScrollingFrom startingViewController: UIViewController, destinationViewController: UIViewController) {
        
    }
    
    func pageViewController(_ pageViewController: PageViewController, isScrollingFrom startingViewController: UIViewController, destinationViewController: UIViewController?, progress: CGFloat) {
        
    }
    
    func pageViewController(_ pageViewController: PageViewController, didFinishScrollingFrom startingViewController: UIViewController, destinationViewController: UIViewController, transitionSuccessful: Bool) {
        guard let index = self.viewControllers.firstIndex(of: destinationViewController) else { return }
        
        self.pageControl.currentPage = index
    }
}

extension PromotionsViewController: SelfInitViewController {
    
    static var instance: PromotionsViewController {
        let storyboard = UIStoryboard(name: "Promotion",
                                      bundle: nil)
        let identifier = String(describing: PromotionsViewController.self)
        
        return storyboard.instantiateViewController(withIdentifier: identifier) as! PromotionsViewController
    }
}
