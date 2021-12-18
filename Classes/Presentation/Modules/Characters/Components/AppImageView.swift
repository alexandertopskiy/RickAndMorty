//
//  Created by Alexander Loshakov on 11.12.2021
//  Copyright © 2021 Ronas IT. All rights reserved.
//

import SwiftUI
import Nuke

struct AppImageView: View {
    let url: URL?
    @StateObject private var image = FetchImage()

    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.gray)
            if image.isLoading {
                AnimationViewComponent()
                    .frame(width: Layout.scaleFactorW * 50, height: Layout.scaleFactorW * 50)
            }
            image.view?
                .resizable()
                .clipped()
        }
        .onAppear {
            image.load(url)
            image.priority = .normal
            image.animation = .easeIn
        }
        .onChange(of: url) {
            image.load($0)
        }
        .onDisappear(
            perform: image.reset
        )
    }
}
