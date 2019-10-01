//
//  BackgroundColor.swift
//  ZomatoApp
//
//  Created by nguyen.duc.huyb on 10/3/19.
//  Copyright © 2019 nguyen.duc.huyb. All rights reserved.
//

struct BackgroundColor : Codable {
    let type: String?
    let tint: String?

    enum CodingKeys: String, CodingKey {
        case type = "type"
        case tint = "tint"
    }
}
