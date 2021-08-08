//
//  DashboardViewController.swift
//  Food Delivery
//
//  Created by Vignesh J on 05/08/21.
//

import UIKit
import Parchment
import FoundationExtension

class DashboardViewController: UIViewController {
    
    @IBOutlet private weak var floatingButton: FAB!
    /// Cache the view controllers in an array to avoid re-creating them
    /// while swiping between pages. Since we only have three view
    /// controllers it's fine to keep them all in memory.
    private var viewControllers = [MenuViewController]()

    private let pagingViewController = PromotionsPagingViewController()
    
    private lazy var cart: Cart = Cart.shared

    private var headerConstraint: NSLayoutConstraint {
        let pagingView = pagingViewController.view as! PromotionsContainerPagingView
        return pagingView.headerHeightConstraint!
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add the paging view controller as a child view controller.
        self.addChild(pagingViewController)
        self.view.addSubview(pagingViewController.view)
        self.pagingViewController.didMove(toParent: self)
        
        // Customize the menu styling.
        self.pagingViewController.menuItemSize = .selfSizing(estimatedWidth: 100,
                                                             height: 40)
        self.pagingViewController.font = .systemFont(ofSize: 24,
                                                     weight: .medium)
        self.pagingViewController.selectedFont = .systemFont(ofSize: 24,
                                                             weight: .medium)
        self.pagingViewController.textColor = .lightGray
        self.pagingViewController.selectedTextColor = .black
        self.pagingViewController.indicatorOptions = .hidden
        self.pagingViewController.borderOptions = .hidden
        
        // Contrain the paging view to all edges.
        pagingViewController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pagingViewController.view.topAnchor.constraint(equalTo: view.topAnchor),
            pagingViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            pagingViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pagingViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        
        self.view.bringSubviewToFront(self.floatingButton)
        self.transparentNavigationBar()
        self.loadMenus()
        self.observeCart()
        
        // Set the data source for our view controllers
        self.pagingViewController.dataSource = self
        
        // Set our delegate so we get notified when the user swipes
        // between pages. We will use these delegates to move the
        // UIScrollViewDelegate and update the content offset.
        self.pagingViewController.delegate = self
        
        // Set the UIScrollViewDelegate on the initial view controller
        // so we can update the header view while scrolling.
        self.viewControllers.first?.collectionView.delegate = self
    }
    
    @IBAction private func onTapCart(_ sender: FAB) {
        let shoppingDashboardVC = ShoppingDashboardViewController()
        shoppingDashboardVC.cart = self.cart
        self.navigationController?.pushViewController(shoppingDashboardVC,
                                                      animated: true)
    }
    
    private func transparentNavigationBar() {
        let nb = self.navigationController?.navigationBar
        
        nb?.setBackgroundImage(UIImage(),
                               for: .default)
        nb?.shadowImage = UIImage()
        nb?.isTranslucent = true
    }
    
    private func loadMenus() {
        let menus = try? Bundle.main.initInstance(of: [Menu].self,
                                                  forResource: "Menus")
        guard let vcs = menus?.compactMap({ menu -> MenuViewController? in
            let vc = MenuViewController.instance
            vc.menu = menu
            vc.cart = cart
            
            return vc
        }) else {
            return
        }
        
        self.viewControllers = vcs
    }
    
    private func observeCart() {
        self.cart.quantityObserver = { [weak self] in
            self?.floatingButton.animateBadge(number: $0)
        }
    }
}

extension DashboardViewController: PagingViewControllerDataSource {
    func pagingViewController(_: PagingViewController, viewControllerAt index: Int) -> UIViewController {
        let viewController = viewControllers[index]
        viewController.title = viewController.menu.name

        // Inset the table view with the height of the menu height.
        let height = pagingViewController.options.menuHeight + PromotionsContainerPagingView.HeaderHeight
        let insets = UIEdgeInsets(top: height, left: 0, bottom: 0, right: 0)
        viewController.collectionView.contentInset = insets
        viewController.collectionView.scrollIndicatorInsets = insets

        return viewController
    }

    func pagingViewController(_: PagingViewController, pagingItemAt index: Int) -> PagingItem {
        let viewController = self.viewControllers[index]
        return PagingIndexItem(index: index, title: viewController.menu.name)
    }

    func numberOfViewControllers(in _: PagingViewController) -> Int {
        return viewControllers.count
    }
}

extension DashboardViewController: PagingViewControllerDelegate {
    func pagingViewController(_: PagingViewController, didScrollToItem _: PagingItem, startingViewController: UIViewController?, destinationViewController: UIViewController, transitionSuccessful: Bool) {
        guard let startingViewController = startingViewController as? MenuViewController else { return }
        guard let destinationViewController = destinationViewController as? MenuViewController else { return }

        // Set the delegate on the currently selected view so that we can
        // listen to the scroll view delegate.
        if transitionSuccessful {
            startingViewController.collectionView.delegate = nil
            destinationViewController.collectionView.delegate = self
        }
    }

    func pagingViewController(_: PagingViewController, willScrollToItem _: PagingItem, startingViewController _: UIViewController, destinationViewController: UIViewController) {
        guard let destinationViewController = destinationViewController as? MenuViewController else { return }

        // Update the content offset based on the height of the header
        // view. This ensures that the content offset is correct if you
        // swipe to a new page while the header view is hidden.
        if let scrollView = destinationViewController.collectionView {
            let offset = headerConstraint.constant + pagingViewController.options.menuHeight
            scrollView.contentOffset = CGPoint(x: 0, y: -offset)
            updateScrollIndicatorInsets(in: scrollView)
        }
    }
}

extension DashboardViewController: UICollectionViewDelegate {
    
    func updateScrollIndicatorInsets(in scrollView: UIScrollView) {
        let offset = min(0, scrollView.contentOffset.y) * -1
        let insetTop = max(pagingViewController.options.menuHeight, offset)
        let insets = UIEdgeInsets(top: insetTop, left: 0, bottom: 0, right: 0)
        scrollView.scrollIndicatorInsets = insets
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard scrollView.contentOffset.y < 0 else {
            // Reset the header constraint in case we scrolled so fast that
            // the height was not set to zero before the content offset
            // became negative.
            if headerConstraint.constant > 0 {
                headerConstraint.constant = 0
            }
            return
        }

        // Update the scroll indicator insets so they move alongside the
        // header view when scrolling.
        updateScrollIndicatorInsets(in: scrollView)

        // Update the height of the header view based on the content
        // offset of the currently selected view controller.
        let height = max(0, abs(scrollView.contentOffset.y) - pagingViewController.options.menuHeight)
        headerConstraint.constant = height
    }
}

