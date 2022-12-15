//
//  RestaurantDetailsViewModel.swift
//  TravelDiscovery
//
//  Created by Hakan Körhasan on 8.12.2022.
//

import Foundation

class RestaurantDetailsViewModel: ObservableObject {
    
    @Published var isLoading = true
    
    @Published var details: RestaurantDetail?
    
    init() {
        
        let urlString = "https://travel.letsbuildthatapp.com/travel_discovery/restaurant?id=0"
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data else { return }
            
            do{
                self.details = try JSONDecoder().decode(RestaurantDetail.self, from: data)
            }catch {
                print("Failed to error: ", error)
            }
            
        }.resume()
        
    }
}

