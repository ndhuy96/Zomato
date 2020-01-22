//
//  CustomNavigationController.swift
//  ZomatoApp
//
//  Created by nguyen.duc.huyb on 11/28/19.
//  Copyright © 2019 nguyen.duc.huyb. All rights reserved.
//


class CustomNavigationController: UINavigationController {
    fileprivate var currentAnimationTransition: UIViewControllerAnimatedTransitioning? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    }
    
    var shouldTabBarBeHidden: Bool {
        let mapViewInNavStack = self.viewControllers.contains(where: { vc -> Bool in
            return vc.isKind(of: MapViewController.self)
        })
        
        let isPoppingFromMapView = (self.currentAnimationTransition?.isKind(of: TransitionAnimationController.self) ?? false)
        
        if isPoppingFromMapView {
            return false
        } else {
            return mapViewInNavStack
        }
    }
}

extension CustomNavigationController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController,
                              animationControllerFor operation: UINavigationController.Operation,
                              from fromVC: UIViewController,
                              to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        let result: UIViewControllerAnimatedTransitioning?
        
        if operation == .push && toVC.isKind(of: MapViewController.self) {
            result = TransitionAnimationController(type: .present)
        } else if operation == .pop && toVC.isKind(of: MainViewController.self) {
            result = TransitionAnimationController(type: .dismiss)
        } else {
            result = nil
        }
        self.currentAnimationTransition = result
        return result
    }
}
