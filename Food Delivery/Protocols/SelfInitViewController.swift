//
//  SelfInitViewController.swift
//  Food Delivery
//
//  Created by Vignesh J on 07/08/21.
//

import UIKit

protocol SelfInitViewController: UIViewController {
    static var instance: Self { get }
}
