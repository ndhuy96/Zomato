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
}

extension UIStoryboard {
    var loginViewController: LoginViewController {
        guard let vc = UIStoryboard.main.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController else {
            fatalError("LoginViewController couldn't be found in Storyboard file")
        }
        return vc
    }
    
    var mainViewController: MainViewController {
        guard let vc = UIStoryboard.main.instantiateViewController(withIdentifier: "MainViewController") as? MainViewController else {
            fatalError("MainViewController couldn't be found in Storyboard file")
        }
        return vc
    }
}
