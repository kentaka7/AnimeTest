//
//  Animator.swift
//  AnimeTest
//
//  Created by takakura naohiro on 2017/10/02.
//  Copyright © 2017年 GeoMagnet. All rights reserved.
//

import UIKit

class Animator : NSObject,CAAnimationDelegate {
    fileprivate let center: CGPoint
    fileprivate let duration: TimeInterval
    fileprivate let isPresent: Bool
    fileprivate var completionHandler: (() -> Void)?
    
    init(center: CGPoint, duration: TimeInterval = 0.5, isPresent: Bool) {
        self.center = center
        self.duration = duration
        self.isPresent = isPresent
    }
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        completionHandler?()
    }
    //dynamic override func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
    //    completionHandler?()
    //}
}

extension Animator : UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        let source = transitionContext.view(forKey: UITransitionContextViewKey.from)
        let target = transitionContext.view(forKey: UITransitionContextViewKey.to)
        
        completionHandler = { _ in
            transitionContext.completeTransition(true)
        }
        
        let radius = { () -> CGFloat in
            let x = max(center.x, containerView.frame.width - center.x)
            let y = max(center.y, containerView.frame.height - center.y)
            return sqrt(x * x + y * y)
        }()
        
        let rectAroundCircle = { (radius: CGFloat) -> CGRect in
            return CGRect(origin: self.center, size: CGSize.zero).insetBy(dx: -radius, dy: -radius)
        }
        
        let zeroPath = CGPath(ellipseIn: rectAroundCircle(0), transform: nil)
        let fullPath = CGPath(ellipseIn: rectAroundCircle(radius), transform: nil)
        
        if isPresent {
            containerView.insertSubview(target!, aboveSubview: source!)
            addAnimation(target!, fromValue: zeroPath, toValue: fullPath)
        } else {
            containerView.insertSubview(target!, belowSubview: source!)
            addAnimation(source!, fromValue: fullPath, toValue: zeroPath)
        }
    }
}

extension Animator {
    fileprivate func addAnimation(_ viewController: UIView, fromValue: CGPath, toValue: CGPath) {
        let animation = CABasicAnimation(keyPath: "path")
        animation.fromValue = fromValue
        animation.toValue = toValue
        animation.duration = duration
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        animation.delegate = self as? CAAnimationDelegate
        animation.isRemovedOnCompletion = false
        animation.fillMode = kCAFillModeForwards
        
        viewController.layer.mask = CAShapeLayer()
        viewController.layer.mask?.add(animation, forKey: nil)
    }
}
