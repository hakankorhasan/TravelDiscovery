//
//  PopularPlacesView.swift
//  TravelDiscovery
//
//  Created by Hakan Körhasan on 29.11.2022.
//

import SwiftUI

struct PopularPlacesView: View{
    
    let restaurants: [Restaurant] = [
        .init(name: "Japan's Finest Tapas", imageName: "newyork"),
        .init(name: "Bar & Grill", imageName: "tokyo")
    ]
    
    var body: some View{
        VStack{
            HStack{
                Text("Popular places to eat")
                    .font(.system(size: 14, weight: .semibold))
                Spacer()
                Text("See all")
                    .font(.system(size: 12, weight: .semibold))
            }
            .padding(.horizontal)
            .padding(.top)
        
        ScrollView(.horizontal ,showsIndicators: false) {
            HStack(spacing: 8.0) {
                ForEach(restaurants, id: \.self) { restaurant in
                    NavigationLink {
                        RestaurantDetailsView(restaurant: restaurant)
                    } label: {
                        RestaurantTile(restaurant: restaurant)
                            .foregroundColor(Color(.label))
                    }
                    .padding(.bottom)
                }
            }
            .padding(.horizontal)
            .padding(.bottom)
        }
        }
    }
}

struct RestaurantTile: View{
    
    let restaurant: Restaurant
    
    var body: some View{
        HStack(spacing: 8) {
            Image(restaurant.imageName)
                .resizable()
                .scaledToFill()
                .frame(width: 60, height: 60)
                .clipped()
                .cornerRadius(5)
                .padding(.leading, 6)
                .padding(.vertical, 6)
            
            VStack(alignment: .leading, spacing: 6){
                HStack{
                    Text(restaurant.name)
                    Spacer()
                    Button {
                        
                    } label: {
                        Image(systemName: "ellipsis")
                            .foregroundColor(.gray)
                    }

                }
               
                HStack{
                    Image(systemName: "star.fill")
                    Text("4.7 - Sushi - $$")
            
                }

                Text("Tokyo, Japan")
                
            }.font(.system(size: 12, weight: .semibold))
            
            Spacer()
        }
        .frame(width: 240)
        .asTile()
    }
}

struct PopularPlacesView_Previews: PreviewProvider {
    static var previews: some View {
        PopularPlacesView()
        DiscoverView()
    }
}
