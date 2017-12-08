//
//  ModalTransitioningDelegate.swift
//  Animations
//
//  Created by Ilian Konchev on 25.11.17.
//  Copyright © 2017 Ilian Konchev. All rights reserved.
//

import Foundation
import UIKit

final class ModalTransitioningDelegate: NSObject, UIViewControllerTransitioningDelegate {

    enum PresentationStyle {
        case center, bottom, full
    }
    weak var animationTransitioningDelegate: UIViewControllerAnimatedTransitioning?
    var style: PresentationStyle = .center

    init(style: PresentationStyle) {
        super.init()
        self.style = style
    }

    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        let presentationController = ModalPresentationController(presentedViewController: presented, presenting: source)
        presentationController.interactionController = PanInteractionController(viewController: presented)
        animationTransitioningDelegate = presentationController
        return presentationController
    }

    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if let delegate = animationTransitioningDelegate as? ModalPresentationController {
            delegate.dismissing = false
            delegate.style = self.style
        }
        return animationTransitioningDelegate
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if let delegate = animationTransitioningDelegate as? ModalPresentationController {
            delegate.dismissing = true
            delegate.style = self.style
        }
        return animationTransitioningDelegate
    }

    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        guard let animator = animator as? ModalPresentationController,
            let interactionController = animator.interactionController,
            interactionController.interactionInProgress
            else { return nil }
        return interactionController
    }
}


final class ModalPresentationController: UIPresentationController {
    lazy var dimmingView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        return view
    }()
    var dismissing = false
    var style: ModalTransitioningDelegate.PresentationStyle = .center

    private let containerPadding: CGFloat = 24.0
    var interactionController: PanInteractionController? = nil

    override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)

        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dimmingViewTapped(_:)))
        dimmingView.addGestureRecognizer(tapRecognizer)
    }

    @objc func dimmingViewTapped(_ tapRecognizer: UITapGestureRecognizer) {
        presentedViewController.view.endEditing(true)
        presentedViewController.dismiss(animated: true, completion: nil)
    }

    override func presentationTransitionWillBegin() {
        guard let containerView = containerView else { return }

        dimmingView.frame = containerView.bounds
        dimmingView.alpha = 0.0
        containerView.insertSubview(dimmingView, at: 0)
    }

    override func containerViewWillLayoutSubviews() {
        guard let containerView = containerView, let presentedView = presentedView else { return }

        dimmingView.frame = containerView.bounds
        presentedView.frame = frameOfPresentedViewInContainerView
    }

    override func size(forChildContentContainer container: UIContentContainer, withParentContainerSize parentSize: CGSize) -> CGSize {
        let size = CGSize(width: (parentSize.width - containerPadding), height: presentedViewController.preferredContentSize.height)
        return size
    }

    func origin(forChildContentContainer container: UIContentContainer, withParentContainerSize parentSize: CGSize) -> CGPoint {
        var origin = CGPoint.zero
        let size = CGSize(width: (parentSize.width - containerPadding), height: presentedViewController.preferredContentSize.height)

        switch style {
        case .center:
            origin.x = ((parentSize.width - size.width) / 2.0)
            origin.y = (parentSize.height - size.height) / 2.0
            break
        case .bottom:
            origin.x = (parentSize.width - size.width) / 2.0
            origin.y = (parentSize.height - size.height - (containerPadding / 2))
            break
        case .full:
            origin.x = (parentSize.width - size.width) / 2.0
            origin.y = (parentSize.height - size.height) / 2.0 - 30
            break
        }

        return origin
    }

    override var frameOfPresentedViewInContainerView : CGRect {
        var presentedViewFrame = CGRect.zero
        let containerBounds = containerView!.bounds
        let contentContainer = presentedViewController

        presentedViewFrame.size = size(forChildContentContainer: contentContainer, withParentContainerSize: containerBounds.size)
        presentedViewFrame.origin = origin(forChildContentContainer: contentContainer, withParentContainerSize: containerBounds.size)

        return presentedViewFrame
    }

}

extension ModalPresentationController: UIViewControllerAnimatedTransitioning {

    func interruptibleAnimator(using transitionContext: UIViewControllerContextTransitioning) -> UIViewImplicitlyAnimating {
        guard let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from),
            let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
            else { return UIViewPropertyAnimator(duration: 0, curve: .linear, animations: nil) }

        let translation = CGAffineTransform(translationX: 0, y: fromViewController.preferredContentSize.height + 20)
        let curve: UIViewAnimationCurve = dismissing ? .easeIn : .easeOut
        let animationDuration = transitionDuration(using: transitionContext)

        let animator = UIViewPropertyAnimator(duration: animationDuration, curve: curve, animations: {
            if self.dismissing {
                self.dimmingView.alpha = 0.0
                fromViewController.view.alpha = 0.0
                fromViewController.view.transform = CGAffineTransform.identity.concatenating(translation)
            } else {
                self.dimmingView.alpha = 1.0
                toViewController.view.alpha = 1.0
                toViewController.view.transform = CGAffineTransform.identity
            }
        })
        animator.isInterruptible = true
        animator.isUserInteractionEnabled = true
        animator.addCompletion{ position in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
        return animator
    }

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) else { return }

        let containerView = transitionContext.containerView
        let animator = interruptibleAnimator(using: transitionContext)
        if dismissing == false {
            toViewController.view.frame = frameOfPresentedViewInContainerView
            let translation = CGAffineTransform(translationX: 0, y: toViewController.preferredContentSize.height + 20)
            toViewController.view.transform = translation
            toViewController.view.alpha = 0
            containerView.addSubview(toViewController.view)
        }
        animator.startAnimation()
    }
}

class PanInteractionController: UIPercentDrivenInteractiveTransition {
    var interactionInProgress = false

    private var shouldCompleteTransition = false
    private weak var viewController: UIViewController!

    init(viewController: UIViewController) {
        super.init()
        self.viewController = viewController
        prepareGestureRecognizer(in: viewController.view)
    }

    private func prepareGestureRecognizer(in view: UIView) {
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(handleGesture(_:)))
        view.addGestureRecognizer(gesture)
    }

    @objc func handleGesture(_ gestureRecognizer: UIPanGestureRecognizer) {
        guard let hostView = gestureRecognizer.view?.superview else { return }

        let translation = gestureRecognizer.translation(in: hostView)
        var progress = (translation.y / 200)
        progress = CGFloat(fminf(fmaxf(Float(progress), 0.0), 1.0))

        switch gestureRecognizer.state {
        case .began:
            interactionInProgress = true
            viewController.dismiss(animated: true, completion: nil)
        case .changed:
            shouldCompleteTransition = progress > 0.5
            update(progress)
        case .cancelled:
            interactionInProgress = false
            cancel()
        case .ended:
            interactionInProgress = false
            completionSpeed = gestureRecognizer.velocity(in: gestureRecognizer.view).y
            completionCurve = .easeOut
            if shouldCompleteTransition {
                finish()
            } else {
                cancel()
            }
        default:
            break
        }
    }
}
