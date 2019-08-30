//
//  ViewController.swift
//  ZomatoApp
//
//  Created by nguyen.duc.huyb on 8/30/19.
//  Copyright © 2019 nguyen.duc.huyb. All rights reserved.
//


final class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func handleLogoutButtonTapped(_ sender: Any) {
        UserDefaults.standard.set(false, forKey: "LOGGED_IN")
        App.shared.swipeBackToLogin()
    }
}

