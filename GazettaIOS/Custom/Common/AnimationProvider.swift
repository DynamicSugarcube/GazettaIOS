//
//  AnimationProvider.swift
//  GazettaIOS
//
//  Created by Vsevolod Sharov on 02.02.2021.
//

import UIKit

class AnimationProvider {
    static let animationDuration = 0.25

    static func buildRotationAnimations(for view: UIView) -> (animation: () -> Void, completion: (Bool) -> Void) {
        let animation = {
            view.transform = CGAffineTransform(rotationAngle: .pi)
        }
        let completion: (Bool) -> Void = { _ in
            UIView.animate(withDuration: animationDuration) {
                view.transform = CGAffineTransform.identity
            }
        }
        return (animation, completion)
    }
}
