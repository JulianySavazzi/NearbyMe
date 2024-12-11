//
//  SplashFlowDelegate.swift
//  NearbyMe
//
//  Created by Juliany Savazzi on 11/12/24.
//

import Foundation

//criar protocolo de navegacao
public protocol SplashFlowDelegate: AnyObject {
    func decideNavigationFlow()
}
