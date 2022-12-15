//
//  PopularDestinationView.swift
//  TravelDiscovery
//
//  Created by Hakan Körhasan on 29.11.2022.
//

import SwiftUI
import MapKit

struct PopularDestinationView: View{
    
    let destinations: [Destination] = [
        .init(name: "Paris", country: "France", imageName: "eyfel", latitude: 48.855014, longitude: 2.341231),
        .init(name: "Tokyo", country: "Japan", imageName: "tokyo", latitude: 35.67988, longitude: 139.7695),
        .init(name: "New York", country: "US", imageName: "newyork", latitude: 40.71592, longitude: -74.0055)
    ]
    
    var body: some View{
        VStack{
            HStack{
                Text("Popular Destination")
                    .font(.system(size: 14, weight: .semibold))
                Spacer()
                Text("See all")
                    .font(.system(size: 12, weight: .semibold))
            }
            .padding(.horizontal)
            .padding(.top)
        
        
        ScrollView(.horizontal ,showsIndicators: false) {
            
            HStack(spacing: 8.0) {
                
                ForEach(destinations, id: \.self) { destination in
                    NavigationLink {
                        NavigationLazyView(PopularDestinationDetailsView(destination: destination))

                    } label: {
                        PopularDestinationTile(destination: destination)
                        .padding(.bottom)
                        .foregroundColor(.black)
                    }

                }
            }
            .padding(.horizontal)
        }
        }
    }
}

struct DestinationDetail: Decodable {
    let description: String
    let photos: [String]
}

class DestinationDetailsViewModels: ObservableObject {
    
    @Published var isLoading = true
    @Published var destinatinDetails: DestinationDetail?
    
    init(name: String){
        
        let fixedUrlString = "https://travel.letsbuildthatapp.com/travel_discovery/destination?name=\(name.lowercased())"
            .addingPercentEncoding(withAllowedCharacters:
                    .urlQueryAllowed) ?? ""
        
        guard let url = URL(string: fixedUrlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            DispatchQueue.main.async {
                guard let data = data else { return }
               
                do {
                    self.destinatinDetails = try JSONDecoder().decode(DestinationDetail.self, from: data)
                }catch {
                    print("Failed to Json: ", error)
                }
            }
            
        }.resume()
        
    }
    
}

struct PopularDestinationDetailsView: View{
    
    @ObservedObject var vm: DestinationDetailsViewModels
    
    let destination: Destination
    @State var region: MKCoordinateRegion
    @State var isShowAttractions = false
    
    init(destination: Destination) {
        print("hey")
        self.destination = destination
        self._region = State(initialValue: MKCoordinateRegion(center: .init(latitude: destination.latitude, longitude: destination.longitude), span: .init(latitudeDelta: 0.05, longitudeDelta: 0.05)))
        self.vm = .init(name: destination.name)
    }

    var body: some View{
        ScrollView{
            
            if let photos = vm.destinatinDetails?.photos {
                DestinationHeaderContainer(imageUrlStrings: photos)
                    .frame(height: 350)
            }
            VStack(alignment: .leading) {
                Text(destination.name)
                    .font(.system(size: 18, weight: .bold))
                Text(destination.country)
                HStack {
                    ForEach(0..<5, id: \.self) { num in
                        Image(systemName: "star.fill")
                            .foregroundColor(.orange)
                    }
                }
                .padding(.top, 2)
                
                HStack {
                    Text(vm.destinatinDetails?.description ?? "")
                        .padding(.top, 4)
                        .font(.system(size: 14))
                    Spacer()
                }
            }
            .padding(.horizontal)
            
            HStack{
                Text("Location")
                    .font(.system(size: 18, weight: .semibold))
                Spacer()
                Button(
                    action: {
                        isShowAttractions.toggle()
                    }) {
                        Text("\(isShowAttractions ? "Hide" : "Show") Attractions")
                        .font(.system(size: 12, weight: .semibold))
                }
                
               // UIKit : UISwitch
                Toggle("", isOn: $isShowAttractions)
                    .labelsHidden()
            }
            .padding(.horizontal)
            
          /*  Map(coordinateRegion: $region)
                .frame(height: 300)*/
            
            Map(coordinateRegion: $region, annotationItems:
                    isShowAttractions ? attractions : []) { (attraction) in
                MapAnnotation(coordinate: .init(latitude: //thread hatası bakılacak
                    attraction.latitude, longitude: attraction.longitude)) {
                    CustomMapAnnotation(attraction: attraction)
                }
            }
            .frame(height: 200)
            
        }
        .navigationBarTitle(destination.name, displayMode: .inline)
    }
    
    let attractions: [Attraction] = [
        .init(name: "Eiffel Tower", imageName: "eyfel", latitude: 48.858505, longitude: 2.2946),
        .init(name: "Champs-Elysees", imageName: "newyork", latitude: 48.866867, longitude: 2.311780),
        .init(name: "Louvre Museum", imageName: "tokyo",latitude: 48.860288,  longitude: 2.337789)
    ]
    
}

struct CustomMapAnnotation: View{
    
    let attraction: Attraction
    
    var body: some View{
        VStack{
            Image(attraction.imageName)
                .resizable()
                .frame(width: 80, height: 60)
                .cornerRadius(5)
                .overlay(
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(Color(.init(white: 0, alpha: 0.3)))
                )
            Text(attraction.name)
                .font(.system(size: 12, weight: .semibold))
                .padding(.vertical, 6)
                .padding(.horizontal, 4)
                .background(LinearGradient(gradient: Gradient(colors: [Color.red, Color.blue]), startPoint: .leading, endPoint: .trailing))
                .foregroundColor(.white)
                .cornerRadius(5)
                .overlay(
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(Color(.init(white: 0, alpha: 0.3)))
                )
        }
        .shadow(radius: 5)
    }
}



struct Attraction: Identifiable {
    let id = UUID().uuidString
    let name, imageName: String
    let latitude, longitude: Double
}

struct PopularDestinationTile: View{
    
    let destination: Destination
    
    var body: some View{
        VStack(alignment: .leading, spacing: 0) {
            
            Image(destination.imageName)
                .resizable()
                .scaledToFill()
                .frame(width: 125, height: 125)
                .cornerRadius(5)
                .padding(.horizontal, 6)
                .padding(.vertical, 6)
            
            
            Text(destination.name)
                .font(.system(size: 12, weight: .semibold))
                .padding(.horizontal, 12)
                .foregroundColor(Color(.label))
            
            Text(destination.country)
                .font(.system(size: 12, weight: .semibold))
                .padding(.horizontal, 12)
                .padding(.bottom, 8)
                .foregroundColor(.gray)
        }
        .asTile()
    }
}



struct PopularDestinationView_Previews: PreviewProvider {
    static var previews: some View {
        PopularDestinationView()
            .colorScheme(.dark)
        
        NavigationView {
            PopularDestinationDetailsView(destination: .init(name: "Paris", country: "France", imageName: "eyfel", latitude: 48.859565, longitude: 2.353235))
        
        }
        DiscoverView()
    }
}
