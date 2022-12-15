//
//  RestaurantDetail.swift
//  TravelDiscovery
//
//  Created by Hakan Körhasan on 8.12.2022.
//

import Foundation

struct RestaurantDetail: Decodable {
    let popularDishes: [Dish]
    let reviews: [Review]
    let photos: [String]
    let description, thumbnail: String
}

struct Review: Decodable, Hashable {
    let user: ReviewUser
    let text: String
    let rating: Int
}

struct ReviewUser: Decodable, Hashable {
    let id: Int
    let username, firstName, lastName, profileImage: String
}

struct Dish: Decodable, Hashable {
    let name, price, photo: String
    let numPhotos: Int
}
