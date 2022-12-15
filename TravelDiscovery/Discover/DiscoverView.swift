//
//  ContentView.swift
//  TravelDiscovery
//
//  Created by Hakan Körhasan on 28.11.2022.
//

import SwiftUI

extension Color {
    static let discoverBackground = Color(.init(white: 0.95, alpha: 1))
    static let defaultbackground = Color("defaultBackground")
}

struct DiscoverView: View {
    
    @State var searcText = ""
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [
            .foregroundColor: UIColor.white
        ]
    }
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        NavigationView {
            
            ZStack{
                
                LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.9075794816, green: 0.5958385468, blue: 0, alpha: 1)), Color(#colorLiteral(red: 0.9249581099, green: 0.4243946671, blue: 0, alpha: 1))]), startPoint: .top, endPoint: .center)
                    .ignoresSafeArea()
                
                Color.discoverBackground
                    .offset(y: 400)
                
                ScrollView{
                    
                    HStack {
                        Image(systemName: "magnifyingglass")
                        TextField("Where do you want to go?", text: $searcText)
                            
                    }
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.white)
                    .padding()
                    .background(Color(.init(white: 1, alpha: 0.3)))
                    .cornerRadius(10)
                    .padding(16)
                    
                    DiscoverCategoriesView()
                    
                    VStack {
                        PopularDestinationView()
                        
                        PopularPlacesView()
                        
                        TrendingCreatorsView()
                    }
                    .background(Color.defaultbackground)
                    .cornerRadius(16)
                    .padding(.top, 32)
                }
            }
            .navigationTitle("Discover")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        DiscoverView()
            .colorScheme(.dark)
        DiscoverView()
            .colorScheme(.light)
    }

}


