//
//  CustomRequestAdapter.swift
//  ZomatoApp
//
//  Created by nguyen.duc.huyb on 9/4/19.
//  Copyright © 2019 nguyen.duc.huyb. All rights reserved.
//


import Alamofire

final class CustomRequestAdapter: RequestAdapter {
    private var headers = Alamofire.SessionManager.defaultHTTPHeaders
    
    func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        var urlRequest = urlRequest
        urlRequest.setValue(APIKey.apiKey, forHTTPHeaderField: "user-key")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
        return urlRequest
    }
}
