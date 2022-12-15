//
//  DiscoverCategoriesView.swift
//  TravelDiscovery
//
//  Created by Hakan Körhasan on 29.11.2022.
//

import SwiftUI
import Kingfisher
import SDWebImageSwiftUI

struct DiscoverCategoriesView: View {
    
    let categories: [Category] = [
        .init(name: "Art", imageName: "paintpalette.fill"),
        .init(name: "Sport", imageName: "sportscourt.fill"),
        .init(name: "Live Events", imageName: "music.mic"),
        .init(name: "Food", imageName: "music.mic"),
        .init(name: "History", imageName: "music.mic")
    ]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false){
            HStack(alignment: .top ,spacing: 14){
                ForEach(categories, id: \.self) { category in
                    NavigationLink {
                        NavigationLazyView(CategoriesDetailView(name: category.name))
                    } label: {
                        VStack(spacing: 8){
                            Image(systemName: category.imageName)
                                .font(.system(size: 20))
                                .foregroundColor(Color(#colorLiteral(red: 0.9132968783, green: 0.5473393202, blue: 0.005006512627, alpha: 1) ) )
                                .frame(width: 68, height: 68)
                                .background(Color.white)
                                .cornerRadius(68)
                                //.shadow(color: .gray, radius: 4, x: 0.0, y: 2)
                            Text(category.name)
                                .font(.system(size: 12, weight: .semibold))
                                .foregroundColor(Color.white)
                                .multilineTextAlignment(.center)
                        }.frame(width: 68)
                    }
                }
            }.padding(.horizontal)
        }
    }
}

struct DiscoverCategoriesView_Previews: PreviewProvider {
    static var previews: some View {
        
        DiscoverView()
    }
}
