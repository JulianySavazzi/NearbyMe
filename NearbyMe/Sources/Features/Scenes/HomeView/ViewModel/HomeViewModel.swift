//
//  HomeViewModel.swift
//  NearbyMe
//
//  Created by Juliany Savazzi on 14/12/24.
//

import Foundation
import CoreLocation

//ViewModel: guarda as regras de negocio do app - recupera dados do backend
class HomeViewModel {
//    private let baseURL = "http://127.0.0.1:3333" //url do backend - API
    private let baseURL = "http://192.168.1.5:3333" //ip da interface de rede do server - ifconfig: en0 Mac
    var userLatitude = -23.561187293883442
    var userLongitude = -46.656451388116494
    var categories: [PlaceCetegory] = []
    var places: [Place] = []
    var filteredPlaces: [Place] = [] //usar os botoes de filtrar lugares
    
    //para as chamadas de API usaremos Callbacks e Closures
    var didUpdateCategories: (() -> Void)? //variavel do tipo Closure -> arrow function
    var didUpdatePlaces: (() -> Void)? //Closure -> arrow function
    
    func fetchInitialData(completion: @escaping ([PlaceCetegory]) -> Void) {
        fetchCategories { categories in
            completion(categories)
            if let foodCategory = categories.first(where: {$0.name == "Alimentação"}) {
                //precisamos usar o self. para referenciar variaveis dentro do if let
                self.fetchPlaces(for: foodCategory.id, userLocation: CLLocationCoordinate2D(latitude: self.userLatitude, longitude: self.userLongitude))
            }
        }
    }
    
    func fetchCategories(completion: @escaping ([PlaceCetegory]) -> Void){
        //passando a variavel com a url da API para o guard let
        guard let url = URL(string: "\(baseURL)/categories") else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print("Erro ao fazer requisição para \(self.baseURL)! \(error)")
                return
            }
            
            guard let data = data else {
                completion([])
                return
            }
            
            do {
                let categories = try JSONDecoder().decode([PlaceCetegory].self, from: data)
                DispatchQueue.main.async {
                    completion(categories)
                }
            } catch {
                print("Erro ao trazer categorias do data: \(data) !")
                completion([])
            }
            
        }.resume()
        
    }
    
    func fetchPlaces(for categoryID: String, userLocation: CLLocationCoordinate2D){
        //passando a variavel com a url da API para o guard let
        guard let url = URL(string: "\(baseURL)/markets/category/\(categoryID)") else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print("Erro ao fazer requisição!")
                return
            }
            
            guard let data = data else {
                return
            }
            
            do {
                self.places = try JSONDecoder().decode([Place].self, from: data)
                DispatchQueue.main.async {
                    self.didUpdatePlaces?()
                }
            } catch {
                print("Erro ao trazer lugares do data!")
            }
            
        }.resume()
        
    }
    
}
