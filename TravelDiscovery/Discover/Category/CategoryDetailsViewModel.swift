//
//  CategoryDetailsViewModel.swift
//  TravelDiscovery
//
//  Created by Hakan Körhasan on 3.12.2022.
//

import Foundation


class CategoryDetailsViewModel: ObservableObject {
    
    
    @Published var isLoading = true
    @Published var places = [Place]()
    @Published var errorMessages = ""
    
    init(name: String) {
        
        guard let url = URL(
            string: "https://travel.letsbuildthatapp.com/travel_discovery/category?name=\(name.lowercased().addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")") else {
            
            self.isLoading = false
            return
            
        }
                
        URLSession.shared.dataTask(with: url) { data, response, err in
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                
                if let statusCode = (response as? HTTPURLResponse)?.statusCode,
                   statusCode >= 400 {
                    self.isLoading = false
                    self.errorMessages = "Bad Status: \(statusCode)"
                    return
                }
                
                guard let data = data else {return}
                
                do{
                    self.places = try JSONDecoder().decode([Place].self, from: data)
                    
                } catch {
                    print("failed decoding error: ", error)
                    self.errorMessages = error.localizedDescription

                }
                self.isLoading = false
                
            }
        }.resume()
    }
    
}
