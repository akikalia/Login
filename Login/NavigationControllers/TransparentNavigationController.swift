//
//  TransparentNavigationController.swift
//  Dial Pad
//
//  Created by Alexsandre kikalia on 11/22/20.
//

import UIKit

class TransparentNavigationController: UINavigationController{
    override func viewDidLoad() {
        super.viewDidLoad()
        let navbarAppearance = UINavigationBarAppearance()
        navbarAppearance.configureWithTransparentBackground()
        navbarAppearance.backgroundImage = UIImage()
        navbarAppearance.shadowImage = UIImage()
        
        navigationBar.compactAppearance = navbarAppearance
        navigationBar.standardAppearance = navbarAppearance
        navigationBar.scrollEdgeAppearance = navbarAppearance
        
    }
}
