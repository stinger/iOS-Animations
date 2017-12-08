//
//  CoreAnimationKeyframeController.swift
//  Animations
//
//  Created by Ilian Konchev on 24.11.17.
//  Copyright © 2017 Ilian Konchev. All rights reserved.
//

import UIKit

extension UIView {
    func shake() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        animation.duration = 0.6
        animation.values = [-20, 20, -20, 20, -10, 10, -5, 5, 0]
        animation.isRemovedOnCompletion = true
        layer.add(animation, forKey: "shake")
    }
}

class CoreAnimationKeyframeController: UIViewController {

    @IBOutlet weak var square: UIView!

    @IBAction func doShake(_ sender: UIButton) {
        square.shake()
    }
}
