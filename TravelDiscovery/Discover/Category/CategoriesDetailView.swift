//
//  CategoryDetailView.swift
//  TravelDiscovery
//
//  Created by Hakan Körhasan on 3.12.2022.
//

import SwiftUI
import Kingfisher
import SDWebImageSwiftUI



struct CategoriesDetailView: View{
    
    private let name: String
    @ObservedObject private var vm: CategoryDetailsViewModel
    
    init(name: String) {
        print("for: \(name)")
        self.name = name
        self.vm = .init(name: name)
    }
    
    //let name: String
    //@State var isLoading = true
    //@ObservedObject var vm = CategoryDetailsViewModel()
    
    var body: some View{
        ZStack{
            if vm.isLoading {
                VStack {
                    ActvityIndicatorView()
                    Text("Loading..")
                        .foregroundColor(.white)
                        .font(.system(size: 16, weight: .semibold))
                }
                .padding()
                .background(.black)
                .cornerRadius(10)
                
            } else {
                ZStack{
                    
                    if !vm.errorMessages.isEmpty {
                        VStack(spacing: 12) {
                            Image(systemName: "xmark.octagon.fill")
                                .font(.system(size: 64, weight: .semibold))
                                .foregroundColor(.red)
                            Text(vm.errorMessages)
                        }
                    }
                    
                    
                    ScrollView {
                        ForEach(vm.places, id: \.self) { place in
                            VStack(alignment: .leading, spacing: 0){
                                //KFImage(URL(string: place.thumbnail))
                                WebImage(url: URL(string: place.thumbnail))
                                    .resizable()
                                    .indicator(.activity) // Activity Indicator
                                        .transition(.fade(duration: 0.5)) // Fade Transition with duration
                                    .scaledToFill()
                                Text(place.name)
                                    .font(.system(size: 12, weight: .semibold))
                                    .padding()
                            }
                            .asTile()
                            .padding()
                        }
                        
                    }
                }
            }
        }
        .navigationBarTitle(name, displayMode: .inline)
    }
}


struct CategoryDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CategoriesDetailView(name: "Food")
        }
        DiscoverView()
    }
}
