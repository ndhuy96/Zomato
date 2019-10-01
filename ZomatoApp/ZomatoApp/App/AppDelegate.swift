//
//  AppDelegate.swift
//  ZomatoApp
//
//  Created by nguyen.duc.huyb on 8/30/19.
//  Copyright © 2019 nguyen.duc.huyb. All rights reserved.
//


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    var services: [UIApplicationDelegate] = [
        GoogleMapService()
    ]
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        if let window = window {
            App.shared.window = window
            App.shared.startInterface()
        }
        
        for service in services {
            let _ = service.application?(application, didFinishLaunchingWithOptions: launchOptions)
        }
        
        return true
    }
}
