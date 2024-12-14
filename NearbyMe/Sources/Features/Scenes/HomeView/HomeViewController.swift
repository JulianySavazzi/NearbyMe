//
//  HomeViewController.swift
//  NearbyMe
//
//  Created by Juliany Savazzi on 13/12/24.
//

import Foundation
import UIKit
import MapKit

class HomeViewController: UIViewController {
    private var places: [Place] = []
    private let homeView = HomeView()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = homeView
    }
}
