//
//  UIViewAnimationsViewController.swift
//  Animations
//
//  Created by Ilian Konchev on 24.11.17.
//  Copyright © 2017 Ilian Konchev. All rights reserved.
//

import UIKit

class UIViewAnimationsController: UIViewController {

    @IBOutlet weak var square: UIView!
    var startColor: UIColor!

    @IBAction func triggerAnimation(_ sender: UIButton) {
        // 1. preparation so that we can properly restart the animation
        square.backgroundColor = startColor
        square.layer.cornerRadius = 0
        square.alpha = 1.0

        // 2. animation
        UIView.animate(withDuration: 1.0, animations: {
            self.square.backgroundColor = .red
            self.square.layer.cornerRadius = 50.0
        }, completion: { [weak self] completed in
            self?.square.alpha = 0.5
        })
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        startColor = square.backgroundColor
    }
}

