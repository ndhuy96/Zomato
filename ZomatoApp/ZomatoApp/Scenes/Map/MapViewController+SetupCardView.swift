//
//  MapViewController+SetupCardView.swift
//  ZomatoApp
//
//  Created by nguyen.duc.huyb on 1/3/20.
//  Copyright © 2020 nguyen.duc.huyb. All rights reserved.
//

// Enum for card states
enum CardState {
    case collapsed
    case expanded
}

extension MapViewController {
    func setupCardView() {
        // Setup starting and ending card height
        endCardHeight = self.view.frame.height * 0.85
        startCardHeight = self.view.frame.height * 0.25
        
        // Add RestaurantsViewController xib to the bottom of the screen, clipping bounds so that the corners can be rounded
        self.addChild(restaurantsVC)
        self.view.addSubview(restaurantsVC.view)
        restaurantsVC.view.frame = CGRect(x: 0, y: self.view.frame.height - startCardHeight,
                               width: self.view.bounds.width, height: endCardHeight)
        restaurantsVC.view.clipsToBounds = true
        
        // Add tap and pan gesture recognizer
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handleCardPan))
        restaurantsVC.view.addGestureRecognizer(panGestureRecognizer)
    }
    
    @objc
    func dismissCardView(_ recognizer: UITapGestureRecognizer) {
        switch recognizer.state {
        // Animate card when tap finishes
        case .ended:
            if nextState == .collapsed {
                animateTransitionIfNeeded(state: .collapsed, duration: 0.5)
            }
        default:
            break
        }
    }
    
    // Handle pan gesture recognizer
    @objc
    private func handleCardPan(_ gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .began:
            // Start animation if pan begins
            startInteractiveTransition(state: nextState, duration: 0.5)
        case .changed:
            // Update the translation according to the percentage completed
            let translation = gesture.translation(in: restaurantsVC.view)
            var fractionComplete = translation.y / endCardHeight
            fractionComplete = cardVisible ? fractionComplete : -fractionComplete
            updateInteractiveTransition(fractionCompleted: fractionComplete)
        case .ended:
            // End animation when pan ends
            continueInteractiveTransition()
        default:
            break
        }
    }
    
    // Animate transistion function
    private func animateTransitionIfNeeded(state: CardState, duration: TimeInterval) {
        // Check if frame animator is empty
        if runningAnimations.isEmpty {
            // Create a UIViewPropertyAnimator depending on the state of the popover view
            // The damping ratio to apply to the initial acceleration and oscillation.
            let frameAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1) { [weak self] in
                guard let self = self else { return }
                switch state {
                case .expanded:
                    // If expanding set popover y to the ending height and blur background
                    self.restaurantsVC.view.frame.origin.y = self.view.frame.height - self.endCardHeight
                    
                case .collapsed:
                    // If collapsed set popover y to the starting height and remove background blur
                    self.restaurantsVC.view.frame.origin.y = self.view.frame.height - self.startCardHeight
                }
            }
            
            // Complete animation frame
            frameAnimator.addCompletion { _ in
                self.cardVisible = !self.cardVisible
                self.runningAnimations.removeAll()
            }
            
            // Start animation
            frameAnimator.startAnimation()
            
            // Append animation to running animations
            runningAnimations.append(frameAnimator)
            
            // Create UIViewPropertyAnimator to round the popover view corners depending on the state of the popover
            let cornerRadiusAnimator = UIViewPropertyAnimator(duration: duration, curve: .linear) { [weak self] in
                guard let self = self else { return }
                switch state {
                case .expanded:
                    // If the view is expanded set the corner radius to 12
                    self.restaurantsVC.view.layer.cornerRadius = 12
                    
                case .collapsed:
                    // If the view is collapsed set the corner radius to 0
                    self.restaurantsVC.view.layer.cornerRadius = 0
                }
            }
            
            // Start the corner radius animation
            cornerRadiusAnimator.startAnimation()
            
            // Append animation to running animations
            runningAnimations.append(cornerRadiusAnimator)
        }
    }
    
    // Function to start interactive animations when view is dragged
    private func startInteractiveTransition(state: CardState, duration: TimeInterval) {
        // If animation is empty start new animation
        if runningAnimations.isEmpty {
            animateTransitionIfNeeded(state: state, duration: duration)
        }
        
        // For each animation in runningAnimations
        for animator in runningAnimations {
            // Pause animation and update the progress to the fraction complete percentage
            animator.pauseAnimation()
            animationProgressWhenInterrupted = animator.fractionComplete
        }
    }
    
    // Funtion to update transition when view is dragged
    private func updateInteractiveTransition(fractionCompleted: CGFloat) {
        // For each animation in runningAnimations
        for animator in runningAnimations {
            // Update the fraction complete value to the current progress
            animator.fractionComplete = fractionCompleted + animationProgressWhenInterrupted
        }
    }
    
    // Function to continue an interactive transisiton
    private func continueInteractiveTransition() {
        // For each animation in runningAnimations
        for animator in runningAnimations {
            // Continue the animation forwards or backwards
            animator.continueAnimation(withTimingParameters: nil, durationFactor: 0)
        }
    }
}
