//
//  WelcomeView.swift
//  NearbyMe
//
//  Created by Juliany Savazzi on 11/12/24.
//

import Foundation
import UIKit

class WelcomeView:UIView {
    private let logoImageView: UIImageView = {
        let image = UIImageView(image: UIImage(named: "logoIcon"))
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = "Boas vindas ao Nearby Me!"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Tenha cupons de vantagem para usar em seus estabelecimentos favoritos."
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //UIStackView -> componente que cria uma pilha de outros componentes
    private let tipsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 16
        stackView.axis = .vertical //eixo y ou x
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        setupTips() //metodo para utilizar o componente para a tela de tips
        setupConstraints()
    }
    
    private func setupConstraints() {
        NS
    }
    
    private func setupTips() {
        
        let tip1 = TipsView(icon: UIImage(named: "mapIcon"), title: "Encontre estabelecimentos", description: "Veja locais perto de você que são parceiros Nearby")
    }
    
}
