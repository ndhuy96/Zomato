//
//  UITabBarController+.swift
//  ZomatoApp
//
//  Created by nguyen.duc.huyb on 11/28/19.
//  Copyright © 2019 nguyen.duc.huyb. All rights reserved.
//

final class CustomTabBarController: UITabBarController {
    var isTabBarHidden: Bool = false
    
    var shouldTabBarBeSuppressed: Bool {
        guard let currentNavigationController = self.selectedViewController as? CustomNavigationController else {
            return false
        }
        return currentNavigationController.shouldTabBarBeHidden
    }
}

extension CustomTabBarController {

    /**
     Show or hide the tab bar.

     - Parameter hidden: `true` if the bar should be hidden.
     - Parameter animated: `true` if the action should be animated.
     - Parameter transitionCoordinator: An optional `UIViewControllerTransitionCoordinator` to perform the animation
        along side with. For example during a push on a `UINavigationController`.
     */
    func setTabBar(
        hidden: Bool,
        animated: Bool = true,
        alongside animator: UIViewPropertyAnimator? = nil
    ) {
        // We don't show the tab bar if the navigation state of the current tab disallows it.
        if !hidden, self.shouldTabBarBeSuppressed {
            return
        }
        
        guard isTabBarOffscreen != hidden else { return }
        self.isTabBarHidden = hidden
        
        let offsetY = hidden ? tabBar.frame.height : -tabBar.frame.height
        let endFrame = tabBar.frame.offsetBy(dx: 0, dy: offsetY)
        let vc = selectedViewController
        var newInsets: UIEdgeInsets? = vc?.additionalSafeAreaInsets
        let originalInsets = newInsets
        newInsets?.bottom -= offsetY
        
        /// Helper method for updating child view controller's safe area insets.
        func set(childViewController cvc: UIViewController?, additionalSafeArea: UIEdgeInsets) {
            cvc?.additionalSafeAreaInsets = additionalSafeArea
            cvc?.view.setNeedsLayout()
        }
        
        // Update safe area insets for the current view controller before the animation takes place when hiding the bar.
        if
            hidden,
            let insets = newInsets
        {
            set(childViewController: vc, additionalSafeArea: insets)
        }
        
        guard animated else {
            tabBar.frame = endFrame
            tabBar.isHidden = self.isTabBarHidden
            return
        }
        
        /// If the tab bar was previously hidden, we need to un-hide it.
        if self.tabBar.isHidden, !hidden {
            self.tabBar.isHidden = false
        }
        
        // Perform animation with coordination if one is given. Update safe area insets _after_ the animation is complete,
        // if we're showing the tab bar.
        weak var tabBarRef = self.tabBar
        if let animator = animator {
            animator.addAnimations {
                tabBarRef?.frame = endFrame
            }
            animator.addCompletion { (position) in
                let insets = (position == .end) ? newInsets : originalInsets
                if
                    !hidden,
                    let insets = insets
                {
                    set(childViewController: vc, additionalSafeArea: insets)
                }
                if (position == .end) {
                    tabBarRef?.isHidden = hidden
                }
            }
        } else {
            UIView.animate(withDuration: 0.3, animations: {
                tabBarRef?.frame = endFrame
            }) { didFinish in
                if !hidden, didFinish, let insets = newInsets {
                    set(childViewController: vc, additionalSafeArea: insets)
                }
                tabBarRef?.isHidden = hidden
            }
        }
    }
    
    /// `true` if the tab bar is currently hidden.
    fileprivate var isTabBarOffscreen: Bool {
        return !tabBar.frame.intersects(view.frame)
    }
}

extension UIViewController {
    var customNavigationController: CustomNavigationController? {
        return self.navigationController as? CustomNavigationController
    }

    var customTabBarController: CustomTabBarController? {
        return self.tabBarController as? CustomTabBarController
    }
}
