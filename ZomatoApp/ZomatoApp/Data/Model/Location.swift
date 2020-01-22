//
//  Location.swift
//  ZomatoApp
//
//  Created by nguyen.duc.huyb on 10/3/19.
//  Copyright © 2019 nguyen.duc.huyb. All rights reserved.
//

struct Location: Codable {
    let address: String?
    let locality: String?
    let city: String?
    let cityId: Int?
    let latitude: String?
    let longitude: String?
    let zipcode: String?
    let countryId: Int?
    let localityVerbose: String?

    enum CodingKeys: String, CodingKey {
        case address = "address"
        case locality = "locality"
        case city = "city"
        case cityId = "city_id"
        case latitude = "latitude"
        case longitude = "longitude"
        case zipcode = "zipcode"
        case countryId = "country_id"
        case localityVerbose = "locality_verbose"
    }
}
