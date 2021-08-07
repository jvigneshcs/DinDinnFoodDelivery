//
//  MenuViewController.swift
//  Food Delivery
//
//  Created by Vignesh J on 07/08/21.
//

import UIKit

final class MenuViewController: UICollectionViewController {
    
    var menu: Menu!
    
    private let cellIdentifier = String(describing: ItemCollectionViewCell.self)
    
    private var compositionalLayout: UICollectionViewCompositionalLayout {
        let size = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                          heightDimension: .absolute(400))
        let item = NSCollectionLayoutItem(layoutSize: size)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: size,
                                                       subitem: item,
                                                       count: 1)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 16,
                                                        leading: 16,
                                                        bottom: 16,
                                                        trailing: 16)
        section.interGroupSpacing = 0
        
        return UICollectionViewCompositionalLayout(section: section)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let nib = UINib(nibName: "ItemCollectionViewCell",
                        bundle: nil)
        self.collectionView.register(nib,
                                     forCellWithReuseIdentifier: self.cellIdentifier)
        self.collectionView.collectionViewLayout = self.compositionalLayout
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

extension MenuViewController {
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.menu.items.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellIdentifier,
                                                            for: indexPath) as? ItemCollectionViewCell else {
            return UICollectionViewCell()
        }
        let item = self.menu.items[indexPath.item]
        
        cell.display(item: item)
        cell.addTapped = {
            cell.animateAdded()
        }
        
        return cell
    }
}

extension MenuViewController: SelfInitViewController {
    
    static var instance: MenuViewController {
        let storyboard = UIStoryboard(name: "Main",
                                      bundle: nil)
        let identifier = String(describing: MenuViewController.self)
        
        return storyboard.instantiateViewController(withIdentifier: identifier) as! MenuViewController
    }
}
