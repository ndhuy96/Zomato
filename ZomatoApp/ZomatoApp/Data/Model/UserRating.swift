//
//  UserRating.swift
//  ZomatoApp
//
//  Created by nguyen.duc.huyb on 10/3/19.
//  Copyright © 2019 nguyen.duc.huyb. All rights reserved.
//

struct UserRating: Codable {
    let aggregateRating: Int?
    let ratingText: String?
    let ratingColor: String?
    let rating: Rating?
    let votes: Int?

    enum CodingKeys: String, CodingKey {
        case aggregateRating = "aggregate_rating"
        case ratingText = "rating_text"
        case ratingColor = "rating_color"
        case rating = "rating_obj"
        case votes = "votes"
    }
}
