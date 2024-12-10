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
    
    //ciclo de vida da tela
    override func viewDidLoad(){
        //quando a tela acaba de carregar, executa o q esta aqui dentro
        super.viewDidLoad()
        setup()
    }
    
    //construtor da tela
    private func setup() {
        guard let createdView = contentView else {return}
        //adicionar a view
        self.view.addSubview(createdView)
        setupConstraints()
    }
    
    private func setupConstraints() {
        
    }
}
