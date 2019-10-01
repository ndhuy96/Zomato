//
//  Title.swift
//  ZomatoApp
//
//  Created by nguyen.duc.huyb on 10/3/19.
//  Copyright © 2019 nguyen.duc.huyb. All rights reserved.
//

struct Title: Codable {
    let text: String?

    enum CodingKeys: String, CodingKey {
        case text = "text"
    }
}
