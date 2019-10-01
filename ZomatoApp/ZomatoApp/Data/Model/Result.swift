//
//  Result.swift
//  ZomatoApp
//
//  Created by nguyen.duc.huyb on 10/3/19.
//  Copyright © 2019 nguyen.duc.huyb. All rights reserved.
//

struct Result : Codable {
    let hasMenuStatus: HasMenuStatus?
    let resId: Int?

    enum CodingKeys: String, CodingKey {
        case hasMenuStatus = "has_menu_status"
        case resId = "res_id"
    }
}
