//
//  AnimationProvider.swift
//  GazettaIOS
//
//  Created by Vsevolod Sharov on 02.02.2021.
//

import UIKit

class AnimationProvider {
    static let animationDuration = 0.6

    static func buildRotationAnimation(for view: UIView) -> () -> Void {
        return {
            view.transform = CGAffineTransform(rotationAngle: .pi)
            view.transform = CGAffineTransform.identity
        }
    }
}
