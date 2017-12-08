//
//  TransitionDestinationController.swift
//  Animations
//
//  Created by Ilian Konchev on 25.11.17.
//  Copyright © 2017 Ilian Konchev. All rights reserved.
//

import UIKit

class TransitionDestinationController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        preferredContentSize = CGSize(width: UIScreen.main.bounds.width, height: 250)
        view.layer.cornerRadius = 8.0
    }

}
