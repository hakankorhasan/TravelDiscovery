//
//  ReviewsList.swift
//  TravelDiscovery
//
//  Created by Hakan Körhasan on 8.12.2022.
//

import SwiftUI
import Kingfisher

struct ReviewsListView: View {
    
    let reviews: [Review]
    
    var body: some View {
        HStack {
            Text("Customer Reviews")
                .font(.system(size: 18, weight: .bold))
            Spacer()
        }
        .padding(.horizontal)
        
      //  if let reviews = vm.details?.reviews {
            ForEach(reviews, id: \.self) { reviews in
                
                HStack {
                    KFImage(URL(string: reviews.user.profileImage))
                        .resizable()
                        .scaledToFill()
                        .frame(width: 40)
                        .clipShape(Circle())
                    VStack(alignment: .leading, spacing: 4) {
                        Text("\(reviews.user.firstName) \(reviews.user.lastName)")
                            .font(.system(size: 14, weight: .bold))
                        HStack(spacing: 4) {
                            ForEach(0..<reviews.rating, id: \.self) { num in
                                Image(systemName: "star.fill")
                                    .foregroundColor(.orange)

                            }
                            
                            ForEach(0..<5 - reviews.rating, id: \.self) { num in
                                Image(systemName: "star.fill")
                                    .foregroundColor(.gray)
                            }
                           
                        }
                        .font(.system(size: 12))
                    }
                    
                    Spacer()
                    Text("Dec 2020")
                        .font(.system(size: 12))
                }
                Text(reviews.text)
                    .font(.system(size: 12, weight: .regular))
                Divider()
            }
            .padding(.horizontal)
    //    }
    }
}

struct ReviewsList_Previews: PreviewProvider {
    static var previews: some View {
        ReviewsListView(reviews: .init())
    }
}
