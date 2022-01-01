//
//  Created by Alexander Loshakov on 22.11.2021
//  Copyright © 2021 Ronas IT. All rights reserved.
//

import SwiftUI
import Lottie

struct AnimationViewComponent: UIViewRepresentable, Equatable {
    let view = UIView(frame: .zero)
    let animationView = AnimationView()

    func makeUIView(context: UIViewRepresentableContext<AnimationViewComponent>) -> UIView {
        animationView.animation = Animation.named("loading")
        animationView.contentMode = .scaleAspectFill
        animationView.loopMode = .loop
        animationView.animationSpeed = 1.0
        animationView.play()
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.backgroundBehavior = .pauseAndRestore

        view.addSubview(animationView)
        NSLayoutConstraint.activate(
            [
                animationView.widthAnchor.constraint(equalTo: view.widthAnchor),
                animationView.heightAnchor.constraint(equalTo: view.heightAnchor)
            ]
        )
        return view
    }

    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<AnimationViewComponent>) {}
}
