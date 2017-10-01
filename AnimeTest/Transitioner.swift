//
//  Transitioner.swift
//  AnimeTest
//
//  Created by takakura naohiro on 2017/10/02.
//  Copyright © 2017年 GeoMagnet. All rights reserved.
//

import UIKit

enum TransitionStyle {
    case circularReveal(CGPoint), `default`
    
    var presentTransitioning: UIViewControllerAnimatedTransitioning? {
        switch self {
        case .circularReveal(let point): return Animator(center: point, isPresent: true)
        case .default: return nil
        }
    }
    
    var dismissTransitioning: UIViewControllerAnimatedTransitioning? {
        switch self {
        case .circularReveal(let point): return Animator(center: point, isPresent: false)
        case .default: return nil
        }
    }
}

class Transitioner: NSObject {
    fileprivate let style: TransitionStyle
    
    init(style: TransitionStyle, viewController: UIViewController) {
        self.style = style
        super.init()
        viewController.transitioningDelegate = self
    }
}

extension Transitioner: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return style.presentTransitioning
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return style.dismissTransitioning
    }
}
