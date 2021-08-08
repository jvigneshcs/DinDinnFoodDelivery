//
//  PromotionsContainerPagingView.swift
//  Food Delivery
//
//  Created by Vignesh J on 07/08/21.
//

import UIKit
import Parchment

class PromotionsContainerPagingView: PagingView {

    static let HeaderHeight: CGFloat = 450

    var headerHeightConstraint: NSLayoutConstraint?

    private(set) lazy var headerView: UIView = UIView()

    override func setupConstraints() {
        addSubview(headerView)

        pageView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        headerView.translatesAutoresizingMaskIntoConstraints = false

        headerHeightConstraint = headerView.heightAnchor.constraint(
            equalToConstant: PromotionsContainerPagingView.HeaderHeight
        )
        headerHeightConstraint?.isActive = true

        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: options.menuHeight),
            collectionView.topAnchor.constraint(equalTo: headerView.bottomAnchor),

            headerView.topAnchor.constraint(equalTo: topAnchor),
            headerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: trailingAnchor),

            pageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            pageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            pageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            pageView.topAnchor.constraint(equalTo: topAnchor),
        ])
    }
}
