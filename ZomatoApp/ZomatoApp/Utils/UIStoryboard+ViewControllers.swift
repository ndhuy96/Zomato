//
//  UIStoryboard+ViewControllers.swift
//  ZomatoApp
//
//  Created by nguyen.duc.huyb on 8/30/19.
//  Copyright © 2019 nguyen.duc.huyb. All rights reserved.
//

extension UIStoryboard {
    static var main: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: nil)
    }
    
    static var map: UIStoryboard {
        return UIStoryboard(name: "Map", bundle: nil)
    }
}

extension UIStoryboard {
    var loginViewController: LoginViewController {
        let vc = LoginViewController.instantiate()
        return vc
    }
    
    var mainViewController: MainViewController {
        let vc = MainViewController.instantiate()
        return vc
    }
    
    var mapViewController: MapViewController {
        let vc = MapViewController.instantiate()
        return vc
    }
}
