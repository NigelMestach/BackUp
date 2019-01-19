//
//  ViewController.swift
//  MarvelEssentials
//
//  Created by Nigel Mestach on 23/11/2018.
//  Copyright © 2018 Nigel Mestach. All rights reserved.
//

import UIKit
import RevealingSplashView

class ViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let revealingSplashView = RevealingSplashView(iconImage: UIImage(named: "logo")!,iconInitialSize: CGSize(width: 150, height: 150), backgroundColor: UIColor(red:1, green:0, blue:0, alpha:1.0))
        
        //Adds the revealing splash view as a sub view
        self.view.addSubview(revealingSplashView)
        
        //Starts animation
        revealingSplashView.startAnimation()
        
    }


}

