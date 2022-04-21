//
//  Created by Alexander Loshakov on 16.12.2021
//  Copyright © 2021 Ronas IT. All rights reserved.
//

import Foundation
import SwiftUI

extension View {
    func placeholder<Content: View>(when shouldShow: Bool,
                                    alignment: Alignment = .center,
                                    @ViewBuilder placeholder: () -> Content) -> some View {
        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}
