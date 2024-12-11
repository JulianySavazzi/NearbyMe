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
        label.textColor = Colors.gray600
        label.text = "Boas vindas ao Nearby Me!"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = Colors.gray600
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
    
    private let startButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Começar", for: .normal)
        button.backgroundColor = Colors.purpleBase
        button.setTitleColor(Colors.gray100, for: .normal)
        button.layer.cornerRadius = 8 //bordas arredondadas
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
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
        addSubview(logoImageView)
        addSubview(welcomeLabel)
        addSubview(descriptionLabel)
        addSubview(tipsStackView)
        addSubview(startButton)
        setupConstraints()
    }
    
    private func setupConstraints() {
        //ao posicionar o constraint: sempre que a constante for para baixo e para direita ela é negativa
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            logoImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            logoImageView.widthAnchor.constraint(equalToConstant: 48),
            logoImageView.heightAnchor.constraint(equalToConstant: 48),
            
            welcomeLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 24),
            welcomeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            
            descriptionLabel.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 8),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            
            tipsStackView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 24),
            tipsStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            tipsStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            
            startButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -24),
            startButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            startButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            startButton.heightAnchor.constraint(equalToConstant: 56)
        ])
    }
    
    private func setupTips() {
        //usando guard let para verificar se o icone existe antes de usa-lo
        guard let icon1 = UIImage(named: "mapIcon") else {return}
        let tip1 = TipsView(
            icon: icon1,
            title: "Encontre estabelecimentos",
            description: "Veja locais perto de você que são parceiros Nearby")
        
        //usando ternario para usar o icone ou um objeto vazio do msm tipo
        let tip2 = TipsView(
            icon: UIImage(named: "qrcodeIcon") ?? UIImage(),
            title: "Ative o cupom com QR Code",
            description: "Escaneie o código no estabelecimento para usar o benefício")
        
        let tip3 = TipsView(
            icon: UIImage(named: "ticketIcon") ?? UIImage(),
            title: "Garanta vantagens perto de você",
            description: "Ative cupons onde estiver, em diferentes tipos de estabelecimento ")
        
        //  //forcando o app a usar o icone quando eu tenho certeza que ele existe -> nao recomendado pois se nao achar o icone, o app trava
        //        let tip3 = TipsView(
        //            icon: UIImage(named: "ticketIcon")!,
        //            title: "Garanta vantagens perto de você",
        //            description: "Ative cupons onde estiver, em diferentes tipos de estabelecimento ")
        
        //adicionando os componentes no componente StackView
        tipsStackView.addArrangedSubview(tip1)
        tipsStackView.addArrangedSubview(tip2)
        tipsStackView.addArrangedSubview(tip3)
    }
    
}
