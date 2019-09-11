//
//  UIViewController+.swift
//  ZomatoApp
//
//  Created by nguyen.duc.huyb on 9/6/19.
//  Copyright © 2019 nguyen.duc.huyb. All rights reserved.
//

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc
    func dismissKeyboard() {
        view.endEditing(true)
    }
}
