//
//  MapViewNavigator.swift
//  ZomatoApp
//
//  Created by nguyen.duc.huyb on 9/30/19.
//  Copyright © 2019 nguyen.duc.huyb. All rights reserved.
//


protocol MapViewNavigatable {
    func goBack()
}

final class MapViewNavigator: MapViewNavigatable {
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func goBack() {
        navigationController.popViewController(animated: true)
    }
}
