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
        //instanciando nossa Splash -> direcionamento e carregamento de telas
        let startViewController = SplashViewController()
        
        //atribuindo valor ao nosso navigationController -> ele instancia a Splash
        self.navigationController = startViewController
        
        //expor a navigationController para a Scene utilizar
        return navigationController
    }
}
