//
//  RestaurantsViewController.swift
//  ZomatoApp
//
//  Created by nguyen.duc.huyb on 1/3/20.
//  Copyright © 2020 nguyen.duc.huyb. All rights reserved.
//


protocol CardViewDelegate {
    var cardViewController: UIViewController { get }
    var handleArea: UIView { get }
}

final class RestaurantsViewController: UIViewController {

    @IBOutlet fileprivate weak var handleAreaView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

extension RestaurantsViewController: CardViewDelegate {
    var cardViewController: UIViewController {
        return self
    }
    
    var handleArea: UIView {
        return self.handleAreaView
    }
}
