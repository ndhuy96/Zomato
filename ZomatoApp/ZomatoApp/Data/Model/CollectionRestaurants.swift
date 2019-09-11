//
//  CollectionRestaurants.swift
//  ZomatoApp
//
//  Created by nguyen.duc.huyb on 9/5/19.
//  Copyright © 2019 nguyen.duc.huyb. All rights reserved.
//


struct CollectionRestaurants: Codable {
    let collectionID, resCount: Int
    let imageURL: String
    let url: String
    let title, collectionDescription: String
    let shareURL: String
    
    enum CodingKeys: String, CodingKey {
        case collectionID = "collection_id"
        case resCount = "res_count"
        case imageURL = "image_url"
        case url, title
        case collectionDescription = "description"
        case shareURL = "share_url"
    }
}
