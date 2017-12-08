//
//  CoreAnimationReplicationLayerController.swift
//  Animations
//
//  Created by Ilian Konchev on 24.11.17.
//  Copyright © 2017 Ilian Konchev. All rights reserved.
//

import UIKit

class CoreAnimationReplicationLayerController: UIViewController {

    lazy var replicator: CAReplicatorLayer = {
        let replicator = CAReplicatorLayer()
        replicator.bounds = CGRect(x: 0.0, y: 0.0, width: 60.0, height: 60.0)
        replicator.position = view.center
        return replicator
    }()

    lazy var bar: CALayer = {
        let bar = CALayer()
        bar.bounds = CGRect(x: 0.0, y: 0.0, width: 12.0, height: 40.0)
        bar.position = CGPoint(x: 10.0, y: 75.0)
        bar.cornerRadius = 2.0
        bar.backgroundColor = UIColor.red.cgColor
        return bar
    }()

    lazy var moveAnimation: CAAnimation = {
        let animation = CABasicAnimation(keyPath: "position.y")
        animation.toValue = bar.position.y - 35.0
        animation.duration = 0.4
        animation.autoreverses = true
        animation.repeatCount = Float.infinity
        return animation
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.layer.addSublayer(replicator)
        replicator.addSublayer(bar)

        bar.add(moveAnimation, forKey: nil)

        replicator.instanceCount = 3
        replicator.instanceTransform = CATransform3DMakeTranslation(20, 0, 0)
        replicator.instanceDelay = 0.33
        replicator.masksToBounds = true
    }

}
