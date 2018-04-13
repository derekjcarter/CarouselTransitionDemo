//
//  DismissTransitionAnimator.swift
//  CarouselTransitionDemo
//
//  Created by Derek Carter on 4/13/18.
//  Copyright © 2018 Derek Carter. All rights reserved.
//
import UIKit

internal class DismissTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    internal var cellFrame: CGRect = .zero
    internal var cellCornerRadius: CGFloat = 0.0
    
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.50
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        guard let fromViewController = transitionContext.viewController(forKey: .from) as? DetailViewController,
            let toViewController = transitionContext.viewController(forKey: .to) as? ViewController else {
                return
        }
        
        fromViewController.view.backgroundColor = UIColor.white
        toViewController.view.alpha = 1.0
        containerView.insertSubview(toViewController.view, at: 0)
        
        let duration = transitionDuration(using: transitionContext)
        let secondDuration = 0.15
        UIView.animate(withDuration: duration-secondDuration,
                       animations: {
                        fromViewController.setPositionContainer(left: self.cellFrame.origin.x,
                                                                right: -self.cellFrame.origin.x,
                                                                top: self.cellFrame.origin.y,
                                                                bottom: 10.0)
                        fromViewController.setCornerRadius(radius: self.cellCornerRadius)
                        fromViewController.view.backgroundColor = UIColor.clear
        }) { (_) in
            UIView.animate(withDuration: secondDuration,
                           animations: {
                            fromViewController.view.alpha = 0.0
            }) { (_) in
                fromViewController.view.removeFromSuperview()
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            }
        }
    }
    
}
