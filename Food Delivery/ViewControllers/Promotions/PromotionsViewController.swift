//
//  PromotionsViewController.swift
//  Food Delivery
//
//  Created by Vignesh J on 08/08/21.
//

import UIKit

final class PromotionsViewController: UIViewController {
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var pageControl: UIPageControl!
    
    let images = [
        UIImage(named: "Promo1")!,
        UIImage(named: "Promo2")!,
        UIImage(named: "Promo3")!,
    ]
    
    private let identifier = String(describing: PromotionCollectionViewCell.self)
    
    private lazy var flowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.estimatedItemSize = self.collectionView.frame.size
        
        return layout
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        let nib = UINib(nibName: self.identifier,
                        bundle: nil)
        
        self.collectionView.register(nib,
                                     forCellWithReuseIdentifier: self.identifier)
        self.collectionView.collectionViewLayout = self.flowLayout
        self.pageControl.numberOfPages = self.images.count
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

extension PromotionsViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.identifier,
                                                            for: indexPath) as? PromotionCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.set(image: self.images[indexPath.item])
        
        return cell
    }
}

extension PromotionsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        collectionView.frame.size
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let index = Int(scrollView.contentOffset.x / scrollView.frame.width)
        
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
