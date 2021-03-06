//
//  NavigationController.swift
//  AnimeTest
//
//  Created by takakura naohiro on 2017/10/02.
//  Copyright © 2017年 GeoMagnet. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        
        delegate = self
    }
    
}

extension NavigationController: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if toVC is DestinationViewController || fromVC is DestinationViewController {
            return CustomAnimatedTransitioning(operation: operation)
        } else {
            return nil
        }
    }
    
}
