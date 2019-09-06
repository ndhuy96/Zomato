//
//  CollectionsRestaurants.swift
//  ZomatoApp
//
//  Created by nguyen.duc.huyb on 9/5/19.
//  Copyright © 2019 nguyen.duc.huyb. All rights reserved.
//

struct CollectionsRestaurants: Codable {
    let collections: [CollectionElement]
    let hasMore: Int
    let shareURL: String
    let displayText: String
    let hasTotal: Int
    
    enum CodingKeys: String, CodingKey {
        case collections
        case hasMore = "has_more"
        case shareURL = "share_url"
        case displayText = "display_text"
        case hasTotal = "has_total"
    }
}
