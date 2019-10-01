//
//  TransitionAnimationController.swift
//  ZomatoApp
//
//  Created by nguyen.duc.huyb on 12/25/19.
//  Copyright © 2019 nguyen.duc.huyb. All rights reserved.
//

protocol CustomTransitionOriginator {
    var fromAnimatedSubviews: [UIView] { get }
}

protocol CustomTransitionDestination {
    var toAnimatedSubviews: [UIView] { get }
}

final class TransitionAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    enum TransitionType {
        case present
        case dismiss
    }
    
    let type: TransitionType
    
    init(type: TransitionType) {
        self.type = type
        super.init()
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.4
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let fromVC = transitionContext.viewController(forKey: .from) as! CustomTransitionOriginator & UIViewController
        let toVC = transitionContext.viewController(forKey: .to) as! CustomTransitionDestination & UIViewController
        
        let container = transitionContext.containerView
        
        // add the "to" view to the hierarchy
        if type == .present {
            container.addSubview(toVC.view)
        } else {
            container.insertSubview(toVC.view, belowSubview: fromVC.view)
        }
        toVC.view.layoutIfNeeded()
        
        // Create snapshots of textfield being animated
        let fromSnapshots = fromVC.fromAnimatedSubviews.map { subview -> UIView in
            // Create snapshot
            let snapshot = subview.snapshotView(afterScreenUpdates: false)!
            
            // We're putting it in container, so convert original frame into container's coordinate space
            snapshot.frame = container.convert(subview.frame, from: subview.superview)
            return snapshot
        }
        
        let toSnapshots = toVC.toAnimatedSubviews.map { subview -> UIView in
            // Create snapshot
            let snapshot = subview.snapshotView()!
            
            // We're putting it in container, so convert original frame into container's coordinate space
            snapshot.frame = container.convert(subview.frame, from: subview.superview)
            return snapshot
        }

        // save the "to" and "from" frames
        let frames = zip(fromSnapshots, toSnapshots).map { ($0.frame, $1.frame) }
        
        // move the "to" snapshots to where where the "from" views were, but hide them for now

        zip(toSnapshots, frames).forEach { snapshot, frame in
            snapshot.frame = frame.0
            snapshot.alpha = 0
            container.addSubview(snapshot)
        }
        
        // add "from" snapshots, too, but hide the subviews that we just snapshotted
        // associated textfield so we only see animated snapshots; we'll unhide these
        // original views when the animation is done
        
        fromSnapshots.forEach { container.addSubview($0) }
        fromVC.fromAnimatedSubviews.forEach { $0.alpha = 0 }
        toVC.toAnimatedSubviews.forEach { $0.alpha = 0 }
        
        if type == .present {
            toVC.view.alpha = 0.0
        } else {
            toVC.view.alpha = 0.5
        }
        
        // do the animation
        UIView.animateKeyframes(withDuration: transitionDuration(using: transitionContext),
                                delay: 0,
                                options: .calculationModePaced,
                                animations: {
            UIView.addKeyframe(withRelativeStartTime: 0.0,
                               relativeDuration: 1.0,
                               animations: {
                    // I'm now animating the "to" view into place, but you'd do whatever you want here
                    if self.type == .present {
                        toVC.view.alpha = 1.0
                        fromVC.view.alpha = 0.5
                        // hide tab bar
                        fromVC.customTabBarController?.setTabBar(hidden: true, animated: true)
                    } else {
                        fromVC.view.alpha = 0.0
                        toVC.view.alpha = 1.0
                        // show tab bar
                        fromVC.customTabBarController?.setTabBar(hidden: false, animated: true)
                    }
            })
                                    
            UIView.addKeyframe(withRelativeStartTime: 0.5,
                               relativeDuration: 0.5,
                               animations: {
                    if self.type == .present {
                        // animate the snapshots of the textfield
                        zip(toSnapshots, frames).forEach { snapshot, frame in
                            snapshot.frame = frame.1
                            snapshot.alpha = 1.0
                        }
                        
                        zip(fromSnapshots, frames).forEach { snapshot, frame in
                            snapshot.frame = frame.1
                            snapshot.alpha = 0.0
                        }
                    }
            })
                                    
            UIView.addKeyframe(withRelativeStartTime: 0.0,
                               relativeDuration: 0.5,
                               animations: {
                    if self.type == .dismiss {
                        // animate the snapshots of the textfield
                        zip(toSnapshots, frames).forEach { snapshot, frame in
                            snapshot.frame = frame.1
                            snapshot.alpha = 1.0
                        }
                        
                       zip(fromSnapshots, frames).forEach { snapshot, frame in
                            snapshot.frame = frame.1
                            snapshot.alpha = 0.0
                       }
                    }
            })
        }, completion: { _ in
            // get rid of snapshots and re-show the original textfield
            fromSnapshots.forEach { $0.removeFromSuperview() }
            toSnapshots.forEach   { $0.removeFromSuperview() }
            fromVC.fromAnimatedSubviews.forEach { $0.alpha = 1 }
            toVC.toAnimatedSubviews.forEach { $0.alpha = 1 }
            
            // clean up "to" and "from" views as necessary, in my case, just restore "from" view's alpha
            fromVC.view.alpha = 1
            
            // complete the transition
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
}
