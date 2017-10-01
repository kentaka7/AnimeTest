//
//  ViewController.swift
//  AnimeTest
//
//  Created by takakura naohiro on 2017/10/02.
//  Copyright © 2017年 GeoMagnet. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        let viewController = SecondViewController.instantiate(sender.center)
        present(viewController, animated: true, completion: nil)
    }
    
    @IBAction func tesrTapped(_ sender: UIButton) {
        let viewController = SourceViewController()
        present(viewController, animated: true, completion: nil)

        
    }

}


