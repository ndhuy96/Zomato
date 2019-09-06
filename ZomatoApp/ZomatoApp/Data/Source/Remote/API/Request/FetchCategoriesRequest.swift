//
//  FetchCategoriesRequest.swift
//  ZomatoApp
//
//  Created by nguyen.duc.huyb on 9/4/19.
//  Copyright © 2019 nguyen.duc.huyb. All rights reserved.
//

import Alamofire

final class FetchCategoriesRequest: BaseRequest {
    required init() {
        super.init(url: Urls.basePath + "categories", requestType: .get, parameters: nil)
    }
}
