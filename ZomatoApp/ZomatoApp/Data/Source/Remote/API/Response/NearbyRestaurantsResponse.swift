//
//  NearbyRestaurantsResponse.swift
//  ZomatoApp
//
//  Created by nguyen.duc.huyb on 10/3/19.
//  Copyright © 2019 nguyen.duc.huyb. All rights reserved.
//


struct NearbyRestaurantsResponse: Codable {
    let location: Location?
    let popularity: Popularity?
    let link: String?
    let nearbyRestaurants: [NearbyRestaurants]?

    enum CodingKeys: String, CodingKey {
        case location = "location"
        case popularity = "popularity"
        case link = "link"
        case nearbyRestaurants = "nearby_restaurants"
    }
}
