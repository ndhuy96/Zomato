//
//  Categories.swift
//  ZomatoApp
//
//  Created by nguyen.duc.huyb on 9/4/19.
//  Copyright © 2019 nguyen.duc.huyb. All rights reserved.
//

struct Categories: Codable {
    let category: Category?
    
    enum CodingKeys: String, CodingKey {
        case category = "categories"
    }
}
