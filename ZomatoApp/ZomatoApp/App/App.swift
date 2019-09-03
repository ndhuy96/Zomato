//
//  App.swift
//  ZomatoApp
//
//  Created by nguyen.duc.huyb on 8/30/19.
//  Copyright © 2019 nguyen.duc.huyb. All rights reserved.
//


final class App {
    
    static var shared = App()
    
    var window: UIWindow!
    var tabBarController: UITabBarController!
    var loginViewController: UIViewController!
    
    func startInterface() {
        // MARK: Initial TabbarController
        tabBarController = UITabBarController()
        tabBarController.tabBar.barTintColor = UIColor(red: 18/255, green: 18/255, blue: 18/255, alpha: 1.0)
        tabBarController.tabBar.tintColor = .white
        
        // MARK: Initial MainNavigationController and MainViewController
        let mainNavigationController = UINavigationController()
        let mainViewController = UIStoryboard.main.mainViewController
        
        mainNavigationController.tabBarItem = UITabBarItem(title: "Main", image: nil, selectedImage: nil)
        mainNavigationController.viewControllers = [mainViewController]
        
        tabBarController.viewControllers = [
            mainNavigationController
        ]
        
        // MARK: Initial LoginViewController
        loginViewController = UIStoryboard.main.loginViewController
        
        if UserDefaults.standard.bool(forKey: "LOGGED_IN") {
            window.rootViewController = tabBarController
        } else {
            window.rootViewController = loginViewController
        }
        
        window.makeKeyAndVisible()
    }
    
    func swipeBackToLogin() {
        UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: {
            self.window.rootViewController = self.loginViewController
        }, completion: nil)
    }
    
    func swipeLoginToTab() {
        UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: {
            self.window.rootViewController = self.tabBarController
        }, completion: nil)
    }
}
