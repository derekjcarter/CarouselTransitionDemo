//
//  PresentTransitionAnimator.swift
//  CarouselTransitionDemo
//
//  Created by Derek Carter on 4/13/18.
//  Copyright © 2018 Derek Carter. All rights reserved.
//

import UIKit

internal class PresentTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    internal var cellFrame: CGRect = .zero
    internal var cellCornerRadius: CGFloat = 0.0
    
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        guard let toViewController = transitionContext.viewController(forKey: .to) as? DetailViewController else {
            return
        }
        
        containerView.addSubview(toViewController.view)
        toViewController.setPositionContainer(left: cellFrame.origin.x,
                                              right: -cellFrame.origin.x,
                                              top: cellFrame.origin.y,
                                              bottom: 10.0)
        toViewController.setCornerRadius(radius: cellCornerRadius)
        
        let duration = transitionDuration(using: transitionContext)
        UIView.animate(withDuration: duration,
                       animations: {
                        toViewController.setPositionContainer(left: 0.0, right: 0.0, top: 0.0, bottom: 0.0)
                        toViewController.setCornerRadius(radius: 0.0)
                        toViewController.view.backgroundColor = UIColor.white
        }) { (_) in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
    
}
