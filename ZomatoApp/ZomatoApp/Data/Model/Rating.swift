//
//  Rating.swift
//  ZomatoApp
//
//  Created by nguyen.duc.huyb on 10/3/19.
//  Copyright © 2019 nguyen.duc.huyb. All rights reserved.
//

struct Rating: Codable {
    let title: Title?
    let backgroundColor : BackgroundColor?

    enum CodingKeys: String, CodingKey {
        case title = "title"
        case backgroundColor = "bg_color"
    }
}
