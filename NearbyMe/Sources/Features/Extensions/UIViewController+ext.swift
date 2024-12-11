//
//  UIViewController+ext.swift
//  NearbyMe
//
//  Created by Juliany Savazzi on 11/12/24.
//

//extensao da classe UIViewController -> toda classe ViewController vai poder usar essa extensao

import Foundation
import UIKit

extension UIViewController {
    public func setupContentViewToViewController(contentView: UIView) {
        //desativando constraints do storyboard
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        //ligando as ancoras top, left, right e bottom da view as ancoras da viewController
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
