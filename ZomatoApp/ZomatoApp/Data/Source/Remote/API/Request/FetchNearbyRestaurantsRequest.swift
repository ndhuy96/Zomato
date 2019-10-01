//
//  SearchLocationRequest.swift
//  ZomatoApp
//
//  Created by nguyen.duc.huyb on 10/3/19.
//  Copyright © 2019 nguyen.duc.huyb. All rights reserved.
//

import Alamofire

final class FetchNearbyRestaurantsRequest: BaseRequest {
    required init(lat: Double, long: Double) {
        let parameters: [String: Any] = [
            "lat": lat,
            "lon": long]
        super.init(url: Urls.basePath + "geocode", requestType: .get, parameters: parameters)
    }
}
