//
//  PlaceModel.swift
//  NearbyMe
//
//  Created by Juliany Savazzi on 13/12/24.
//

import Foundation

//Models contem a regra de negocio e o modelo de dados das classes - são feitas usando struct (estrutura de dados)
struct Place: Decodable { //model sera populada pela API do backend
    let id: String
    let name: String
    let description: String
    let coupons: Int
    let latitude: Double
    let longitude: Double
    let address: String
    let phone: String
    let cover: String
    let categoryId: String
}

