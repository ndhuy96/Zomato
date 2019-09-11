//
//  FetchCollectionsRestaurantsRequest.swift
//  ZomatoApp
//
//  Created by nguyen.duc.huyb on 9/5/19.
//  Copyright © 2019 nguyen.duc.huyb. All rights reserved.
//

import Alamofire

final class FetchCollectionsRestaurantsRequest: BaseRequest {
    required init(cityId: Int) {
        super.init(url: Urls.basePath + "collections" + "?city_id=\(cityId)", requestType: .get, parameters: nil)
    }
}
