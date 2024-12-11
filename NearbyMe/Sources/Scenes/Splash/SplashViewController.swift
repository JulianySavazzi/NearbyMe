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
    let contentView: SplashView
    //usamos weak var para evitar memory leak -> "gerenciador de memoria do swift = ARC"
    weak var delegate: SplashFlowDelegate?
        
    //obrigatorio ter construtor
    init(contentView: SplashView, delegate: SplashFlowDelegate) {
        self.contentView = contentView
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //ciclo de vida da tela
    override func viewDidLoad(){
        //quando a tela acaba de carregar, executa o q esta aqui dentro
        super.viewDidLoad()
        setup()
        
        decideFlow()
    }
    
    //construtor da tela
    private func setup() {
        //adicionar a view
        self.view.addSubview(contentView)
        self.navigationController?.navigationBar.isHidden = true
        self.view.backgroundColor = Colors.purpleLight
        
        setupConstraints()
    }
    
    //conteudo que aparece dentro da tela
    private func setupConstraints() {
        //desativando constaints do storyboard
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        //ligando as ancoras top, left, right e bottom da view as ancoras da viewController
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    //decide para qual tela o usuario vai -> home ou tela de dicas
    private func decideFlow() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5){ [weak self] in
            self?.delegate?.decideNavigationFlow()
        }
    }
}
