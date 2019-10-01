//
//  NearbyRestaurants.swift
//  ZomatoApp
//
//  Created by nguyen.duc.huyb on 10/3/19.
//  Copyright © 2019 nguyen.duc.huyb. All rights reserved.
//

struct NearbyRestaurants: Codable {
    let restaurant: Restaurant?

    enum CodingKeys: String, CodingKey {
        case restaurant = "restaurant"
    }
}
