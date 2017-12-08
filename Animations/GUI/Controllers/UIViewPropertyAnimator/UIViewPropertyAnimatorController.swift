//
//  UIViewPropertyAnimatorController.swift
//  Animations
//
//  Created by Ilian Konchev on 24.11.17.
//  Copyright © 2017 Ilian Konchev. All rights reserved.
//

import UIKit

class UIViewPropertyAnimatorController: UIViewController {

    let tapGR = UITapGestureRecognizer()
    var animator: UIViewPropertyAnimator?

    @IBOutlet weak var square: UIView!
    @IBOutlet weak var animationProgress: UISlider!
    @IBOutlet weak var reverse: UISwitch!

    @IBAction func pauseAnimator(_ sender: Any) {
        animator?.pauseAnimation()
        if let value = animator?.fractionComplete {
            animationProgress.value = Float(value)
        }
    }

    @IBAction func resumeAnimator(_ sender: Any) {
        let timing = UISpringTimingParameters(dampingRatio: 0.3, initialVelocity: CGVector.zero)
        animator?.continueAnimation(withTimingParameters: timing, durationFactor: 0)
    }

    @IBAction func stopAnimator(_ sender: Any) {
        animator?.stopAnimation(false)
        animator?.finishAnimation(at: .current)
    }

    @IBAction func progressChanged(_ sender: UISlider) {
        guard let animator = animator else { return }
        animator.fractionComplete = CGFloat(sender.value)
    }

    @IBAction func reverseTapped(_ sender: UISwitch) {
        animator?.isReversed = sender.isOn
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view, typically from a nib.
        tapGR.addTarget(self, action: #selector(self.viewTapped))
        square.addGestureRecognizer(tapGR)

        let animator = UIViewPropertyAnimator(duration: 3.0, curve: .easeInOut, animations: nil)

        animator.addCompletion { [weak self] position in
            self?.square.center.x += 20.0
        }
        animator.isUserInteractionEnabled = true

        reverse.isOn = false
        self.animator = animator
    }

    @objc func viewTapped(_ sender: UITapGestureRecognizer) {
        guard let animator = animator, animator.state != .stopped else { return }

        if animator.isRunning == false {
            let targetRadius: CGFloat = self.square.layer.cornerRadius == 0 ? 50.0 : 0
            self.square.alpha = 1.0
            animator.addAnimations {
                self.square.layer.cornerRadius = targetRadius
            }
            animator.addCompletion { [weak self] position in
                self?.square.alpha = 0.5
            }
            animator.startAnimation()
        } else {
            animator.isReversed = !animator.isReversed
            reverse.isOn = animator.isReversed
        }
    }

}
