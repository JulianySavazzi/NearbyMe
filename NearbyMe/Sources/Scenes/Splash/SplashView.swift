//
//  SplashView.swift
//  NearbyMe
//
//  Created by Juliany Savazzi on 10/12/24.
//

import Foundation
import UIKit

class SplashView: UIView {
    //layout da tela
    override init(frame: CGRect) { //sobreescrever o construtor
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let logoImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "logoImage")
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let backgroundImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "backgroundImage")
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private func setupUI() {
        self.addSubview(logoImageView)
        self.addSubview(backgroundImageView)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            logoImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            logoImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            backgroundImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
