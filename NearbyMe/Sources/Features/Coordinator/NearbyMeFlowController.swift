//
//  NearbyMeFlowController.swift
//  NearbyMe
//
//  Created by Juliany Savazzi on 10/12/24.
//

import Foundation
import UIKit

//controlar o fluxo do app -> navegacao entre telas
class NearbyMeFlowController {
    private var navigationController: UINavigationController?
    
    //construtor da classe -> executado sempre que ela for instanciada
    public init() {
        
    }
    
    func start() -> UINavigationController? {
        let contentView = SplashView()
        //instanciando nossa Splash -> direcionamento e carregamento de telas
//        let startViewController = SplashViewController(contentView: contentView, delegate: self)
        let startViewController = HomeViewController()
        //atribuindo valor ao nosso navigationController
        self.navigationController = UINavigationController(rootViewController: startViewController)
        
        //expor a navigationController para a Scene utilizar
        return navigationController
    }
}

extension NearbyMeFlowController: SplashFlowDelegate {
    func decideNavigationFlow() {
        let contentView = WelcomeView()
        let welcomeViewController = WelcomeViewController(contentView: contentView)
        navigationController?.pushViewController(welcomeViewController, animated: true)
    }
}
