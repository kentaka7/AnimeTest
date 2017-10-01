//
//  SecondViewController.swift
//  AnimeTest
//
//  Created by takakura naohiro on 2017/10/02.
//  Copyright © 2017年 GeoMagnet. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    fileprivate var transitioner: Transitioner?
    
    class func instantiate(_ point: CGPoint) -> SecondViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let viewController = storyboard.instantiateViewController(withIdentifier: "Second") as! SecondViewController
        viewController.transitioner = Transitioner(style: .circularReveal(point), viewController: viewController)
        return viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension SecondViewController {
    @IBAction func buttonTapped(_ sender: UIButton) {
        transitioner = Transitioner(style: .circularReveal(sender.center), viewController: self)
        dismiss(animated: true, completion: nil)
    }
}
