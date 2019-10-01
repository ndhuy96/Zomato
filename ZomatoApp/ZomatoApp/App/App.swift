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
        tabBarController = CustomTabBarController()
        tabBarController.tabBar.barTintColor = .white
        tabBarController.tabBar.tintColor = UIColor.primaryColor
        
        // MARK: Initial MainNavigationController and MainViewController
        let mainNavigationController = CustomNavigationController()
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
        let snapShot = window.snapshotView(afterScreenUpdates: true)
        if let snapShot = snapShot {
            loginViewController.view.addSubview(snapShot)
        }
        window.rootViewController = loginViewController
        
        UIView.animate(withDuration: 0.3, animations: {
            snapShot?.layer.opacity = 0
            snapShot?.layer.transform = CATransform3DMakeScale(1, 1, 1)
        }) { finished in
            snapShot?.removeFromSuperview()
        }
    }
    
    func swipeLoginToTab() {
        let snapShot = window.snapshotView(afterScreenUpdates: true)
        if let snapShot = snapShot {
            tabBarController.view.addSubview(snapShot)
        }
        window.rootViewController = tabBarController
        
        UIView.animate(withDuration: 0.3, animations: {
            snapShot?.layer.opacity = 0
            snapShot?.layer.transform = CATransform3DMakeScale(1, 1, 1)
        }) { finished in
            snapShot?.removeFromSuperview()
        }
    }
}
