//
//  GoogleMapService.swift
//  ZomatoApp
//
//  Created by nguyen.duc.huyb on 9/30/19.
//  Copyright © 2019 nguyen.duc.huyb. All rights reserved.
//

import GoogleMaps

final class GoogleMapService: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        GMSServices.provideAPIKey(APIKey.googleApiKey)
        return true
    }
}
