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
        tabBarController.tabBar.barTintColor = .white
        tabBarController.tabBar.tintColor = UIColor.primaryColor
        
        // MARK: Initial MainNavigationController and MainViewController
        let mainNavigationController = UINavigationController()
        let mainNavigator = MainNavigator(navigationController: mainNavigationController)
        let mainViewModel = MainViewModel(dependencies: MainViewModel.Dependencies(api: CommonRepositoryImpl(), navigator: mainNavigator))
        let mainViewController = UIStoryboard.main.mainViewController
        mainViewController.viewModel = mainViewModel
        
        mainNavigationController.tabBarItem = UITabBarItem(title: "Home", image: #imageLiteral(resourceName: "ic-home"), selectedImage: nil)
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
