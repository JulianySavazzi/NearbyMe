//
//  SplashViewController.swift
//  NearbyMe
//
//  Created by Juliany Savazzi on 10/12/24.
//

import Foundation
import UIKit

//classe root
class SplashViewController: UIViewController {
    let contentView: SplashView?
        
    //obrigatorio ter construtor
    init(contentView: SplashView) {
        self.contentView = contentView
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
