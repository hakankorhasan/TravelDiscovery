//
//  RestaurantDetailsView.swift
//  TravelDiscovery
//
//  Created by Hakan Körhasan on 8.12.2022.
//

import SwiftUI
import Kingfisher

struct RestaurantDetailsView: View {
    
    let restaurant: Restaurant
   
    @ObservedObject var vm = RestaurantDetailsViewModel()
    
    var body: some View {
        
        ScrollView{
            
            ZStack(alignment: .bottomLeading) {
                
                KFImage(URL(string: vm.details?.thumbnail ?? ""))
                    .resizable()
                    .scaledToFill()
                
                LinearGradient(gradient: Gradient(colors: [Color.clear, Color.black]), startPoint: .center, endPoint: .bottom)
                
                HStack {
                    VStack(spacing: 8) {
                        
                        Text("Japan's Finest Tapas")
                            .foregroundColor(.white)
                            .font(.system(size: 18, weight: .bold))
                        
                        HStack {
                            ForEach(0..<5, id: \.self) { num in
                                
                                Image(systemName: "star.fill")
                                    .foregroundColor(.orange)
                            }
                        }
                    }
                    
                    Spacer()
                    
                    NavigationLink {
                        RestaurantPhotosView()
                    } label: {
                        Text("See more photos")
                            .foregroundColor(.white)
                            .font(.system(size: 14, weight: .regular))
                            .frame(width: 80)
                            .multilineTextAlignment(.trailing)
                        
                    }

                }
                .padding()
            }
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Location & Description")
                    .font(.system(size: 18, weight: .bold))
                
                Text("Tokyo, Japan")
                    
                HStack {
                    ForEach(0..<5, id: \.self) { num in
                        Image(systemName: "dollarsign.circle.fill")
                            .foregroundColor(.orange)
                    }
                }
                
                HStack { Spacer() }
            }
            .padding(.top)
            .padding(.horizontal)
            
            Text(vm.details?.description ?? "")
                .padding(.top, 8)
                .font(.system(size: 14, weight: .regular))
                .padding(.horizontal)
                .padding(.bottom)
            HStack{
                Text("Popular Dishes")
                    .font(.system(size: 18, weight: .bold))
                Spacer()
            }
            .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false){
                HStack{
                    ForEach(vm.details?.popularDishes ?? [], id: \.self) { popularDishes in
                        DishCellView(popularDishes: popularDishes)
                    }
                }
                .padding(.horizontal)
                .padding(.bottom)
            }
            
            if let reviews = vm.details?.reviews {
                ReviewsListView(reviews: reviews)
            }
        
        }
        .navigationBarTitle("Restaurant Details", displayMode: .inline)
    }
}





struct RestaurantDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            RestaurantDetailsView(restaurant: .init(name: "Japan's Finest Tapas", imageName: "eyfel"))
        }
    }
}
