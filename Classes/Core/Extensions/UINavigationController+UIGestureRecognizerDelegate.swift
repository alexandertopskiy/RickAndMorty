//
//  Created by Alexander Loshakov on 31.12.2021
//  Copyright © 2021 Ronas IT. All rights reserved.
//

import UIKit

// MARK: -  Modifier for swipe gestures between details screens

extension UINavigationController: UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }

    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}
