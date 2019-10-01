//
//  Popularity.swift
//  ZomatoApp
//
//  Created by nguyen.duc.huyb on 10/3/19.
//  Copyright © 2019 nguyen.duc.huyb. All rights reserved.
//

struct Popularity: Codable {
    let popularity: String?
    let nightlifeIndex: String?
    let nearbyRes: [String]?
    let topCuisines: [String]?
    let popularityRes: String?
    let nightlifeRes: String?
    let subzone: String?
    let subzoneId: Int?
    let city: String?

    enum CodingKeys: String, CodingKey {
        case popularity = "popularity"
        case nightlifeIndex = "nightlife_index"
        case nearbyRes = "nearby_res"
        case topCuisines = "top_cuisines"
        case popularityRes = "popularity_res"
        case nightlifeRes = "nightlife_res"
        case subzone = "subzone"
        case subzoneId = "subzone_id"
        case city = "city"
    }
}
