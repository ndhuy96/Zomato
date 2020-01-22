//
//  HasMenuStatus.swift
//  ZomatoApp
//
//  Created by nguyen.duc.huyb on 10/3/19.
//  Copyright © 2019 nguyen.duc.huyb. All rights reserved.
//

struct HasMenuStatus: Codable {
    let delivery: Int?
    let takeaway: Int?

    enum CodingKeys: String, CodingKey {
        case delivery = "delivery"
        case takeaway = "takeaway"
    }
}
