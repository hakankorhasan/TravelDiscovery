//
//  UserDetailsView.swift
//  TravelDiscovery
//
//  Created by Hakan Körhasan on 10.12.2022.
//

import SwiftUI
import Kingfisher

struct UserDetails: Decodable {
    let username, firstName, lastName, profileImage: String
    var followers, following: Int
    let posts: [Post]
}

struct Post: Decodable, Hashable {
    let title, imageUrl, views: String
    let hashtags: [String]
}

//https://travel.letsbuildthatapp.com/travel_discovery/user?id=1
class UserDetailsViewModal: ObservableObject {
    
    @Published var userDetails: UserDetails?
    
    init(id: Int) {
        
        guard let url = URL(string: "https://travel.letsbuildthatapp.com/travel_discovery/user?id=\(id)") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            DispatchQueue.main.async {
                guard let data = data else { return }
                
                do {
                    
                    self.userDetails = try JSONDecoder().decode(UserDetails.self, from: data)
                    
                }catch {
                    print("Failed error to json: \(error.localizedDescription)")
                }
                
                print(data)
            }
        
        }.resume()
        
    }
    
}

struct UserDetailsView: View {
    
    @ObservedObject var vm: UserDetailsViewModal
    
    let user: User
    
    init(user: User) {
        self.user = user
        self.vm = .init(id: user.id)
    }
    
    @State var isFollowing = false
    
    var body: some View {
        ScrollView {
            
            VStack(spacing: 12){
                Image(user.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60)
                    .clipShape(Circle())
                    .shadow(radius: 10)
                    .padding(.horizontal)
                    .padding(.top)
                
                Text("\(self.vm.userDetails?.firstName ?? "") \(self.vm.userDetails?.lastName ?? "")")
                    .font(.system(size: 14, weight: .semibold))
                
                HStack {
                    Text("@\(self.vm.userDetails?.username ?? "") · ")
                    Image(systemName: "hand.thumbsup.fill")
                        .font(.system(size: 10, weight: .semibold))
                    Text("2541")
                }
                .font(.system(size: 12, weight: .regular))
                
                Text(" Youtuber, Vlogger, Travel Creator")
                    .font(.system(size: 12, weight: .regular))
                    .foregroundColor(Color(.lightGray))
                
                HStack(spacing: 12) {
                    VStack {
                        Text("\(self.vm.userDetails?.followers ?? 0)")
                            .font(.system(size: 14, weight: .bold))
                        Text("Followers")
                            .font(.system(size: 9, weight: .regular))
                    }
                    
                    Spacer()
                        .frame(width: 0.5, height: 14)
                        .background(Color(.lightGray))
                    VStack {
                        Text("\(self.vm.userDetails?.following ?? 0)")
                            .font(.system(size: 14, weight: .bold))
                        Text("Following")
                            .font(.system(size: 9, weight: .regular))
                    }
                }
                
                HStack(spacing: 12) {
                    
                    Button {
                        if !isFollowing {
                            isFollowing.toggle()
                            self.vm.userDetails?.followers += 1
                        }else {
                            isFollowing.toggle()
                            self.vm.userDetails?.followers -= 1
                        }
                        
                    } label: {
                        HStack {
                            Spacer()
                            Text(!isFollowing ? "Follow" : "Unfollow")
                                .font(.system(size: 12, weight: .semibold))
                                .foregroundColor(.white)
                            Spacer()
                        }
                
                    }
                    .padding(.vertical, 8)
                    .background(!isFollowing ? .orange : .blue)
                    .cornerRadius(100)
                    .font(.system(size: 11, weight: .semibold))
                    
                    Button {
                        
                    } label: {
                        HStack {
                            Spacer()
                            Text("Contact")
                                .font(.system(size: 12, weight: .semibold))
                                .foregroundColor(.black)
                            Spacer()
                        }
                        
                    }
                    .padding(.vertical, 8)
                    .background(Color(white: 0.9))
                    .cornerRadius(100)
                    .font(.system(size: 11, weight: .semibold))
                    
                    
                }
                
                
                ForEach(vm.userDetails?.posts ?? [], id: \.self) { post in
                    VStack(alignment: .leading, spacing: 12) {
                        KFImage(URL(string: post.imageUrl))
                            .resizable()
                            .scaledToFill()
                            .frame(height: 200)
                            .clipped()
                        
                            HStack {
                                Image(user.imageName)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 34)
                                    .clipShape(Circle())
                                
                                VStack(alignment: .leading) {
                                    
                                    Text(post.title)
                                        .font(.system(size: 12, weight: .semibold))
                                    
                                    Text("\(post.views) views")
                                        .font(.system(size: 10, weight: .regular))
                                        .foregroundColor(Color(.lightGray))
                                }
                                
                            }
                            .padding(.horizontal, 12)
                           
                            HStack{
                                
                                ForEach(post.hashtags, id: \.self) { hashtag in
                                    Text("#\(hashtag)")
                                        .font(.system(size: 10, weight: .bold))
                                        .foregroundColor(.blue)
                                        .padding(.all, 5)
                                        .background(Color(white: 0.92))
                                        .cornerRadius(20)
                                }
                                
                            }
                            .padding(.bottom)
                            .padding(.horizontal, 12)
                    }
                    //.frame(height: 200)
                    .background(Color(white: 1))
                    .cornerRadius(12)
                    .shadow(color: Color(white: 0.6), radius: 5, x: 0, y: 4)
                
                }
            }.padding(.horizontal, 12)
            
            
        }
        .navigationBarTitle(user.name, displayMode: .inline)
    }
}

struct UserDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DiscoverView()
        NavigationView {
            UserDetailsView(user: .init(id: 0, name: "Amy Adams", imageName: "amy"))
        }
        
    }
}
