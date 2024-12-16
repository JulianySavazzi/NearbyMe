//
//  WelcomeViewController.swift
//  NearbyMe
//
//  Created by Juliany Savazzi on 11/12/24.
//

import Foundation
import UIKit

class WelcomeViewController: UIViewController {
    let contentView: WelcomeView
    
    weak var flowDelegate: WelcomeFlowDelegate?
    
    init(contentView: WelcomeView) {
        self.contentView = contentView
        super.init(nibName: nil, bundle: nil)
        
        contentView.didTapButton = { [weak self] in
            self?.flowDelegate?.goToHome()
        }
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        self.view.addSubview(contentView)
        view.backgroundColor = Colors.gray100
        setupConstraints()
    }
    
    private func setupConstraints() {
        self.setupContentViewToViewController(contentView: contentView)
    }
    
}
