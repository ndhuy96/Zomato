//
//  CollectionCategories.swift
//  ZomatoApp
//
//  Created by nguyen.duc.huyb on 9/4/19.
//  Copyright © 2019 nguyen.duc.huyb. All rights reserved.
//



struct CollectionCategories: Codable {
    let categories: [Categories]?
    
    enum CodingKeys: String, CodingKey {
        case categories = "categories"
    }
}
