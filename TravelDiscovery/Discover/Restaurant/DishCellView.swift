//
//  DishCell.swift
//  TravelDiscovery
//
//  Created by Hakan Körhasan on 8.12.2022.
//

import SwiftUI
import Kingfisher

struct DishCellView: View {
    let popularDishes: Dish
    var body: some View {
        VStack(alignment: .leading) {
            
            ZStack(alignment: .bottomLeading) {
                KFImage(URL(string: popularDishes.photo))
                    .resizable()
                    .scaledToFill()
                    .overlay(RoundedRectangle(
                        cornerRadius: 5)
                        .stroke(Color.gray))
                    .shadow(radius: 2)
                    .padding(.vertical, 2)
                LinearGradient(gradient: Gradient(colors: [Color.clear, Color.black]), startPoint: .center, endPoint: .bottom)
                
                Text(popularDishes.price)
                    .font(.system(size: 12, weight: .bold))
                    .foregroundColor(.white)
                    .padding(.horizontal, 6)
                    .padding(.bottom, 4)
            }
            .frame(height: 120)
            .cornerRadius(5)
        
            Text(popularDishes.name)
                .font(.system(size: 13, weight: .bold))
                .multilineTextAlignment(.leading)
            Text("\(popularDishes.numPhotos) photos")
                .font(.system(size: 11, weight: .regular))
                .foregroundColor(.gray)
        }
    }
}

struct DishCell_Previews: PreviewProvider {
    static var previews: some View {
        DishCellView(popularDishes: .init(name: "haakn", price: "12.66", photo: "", numPhotos: 7))
    }
}
