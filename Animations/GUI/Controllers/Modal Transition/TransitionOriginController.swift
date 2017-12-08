//
//  TransitionOriginController.swift
//  Animations
//
//  Created by Ilian Konchev on 25.11.17.
//  Copyright © 2017 Ilian Konchev. All rights reserved.
//

import UIKit

class TransitionOriginController: UIViewController {

    let modalTransitioningDelegate = ModalTransitioningDelegate(style: .bottom)

    @IBAction func showModal(_ sender: UIButton) {
        guard let controller = UIStoryboard(name: "Transition", bundle: nil).instantiateViewController(withIdentifier: "Destination") as? TransitionDestinationController else { return }
        controller.modalPresentationStyle = .custom
        controller.transitioningDelegate = modalTransitioningDelegate
        present(controller, animated: true)
    }

}
