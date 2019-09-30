//
//  LoginViewController.swift
//  ZomatoApp
//
//  Created by nguyen.duc.huyb on 8/30/19.
//  Copyright © 2019 nguyen.duc.huyb. All rights reserved.
//


final class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func handleLoginButtonTapped(_ sender: Any) {
//        UserDefaults.standard.set(true, forKey: "LOGGED_IN")
        App.shared.swipeLoginToTab()
    }
}

extension LoginViewController: StoryboardSceneBased {
    static var sceneStoryboard = UIStoryboard.main
}
