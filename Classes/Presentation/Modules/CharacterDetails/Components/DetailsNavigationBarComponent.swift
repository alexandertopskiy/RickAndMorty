//
//  Created by Nikita Gavrikov on 08.12.2021
//  Copyright © 2021 Ronas IT. All rights reserved.
//

import SwiftUI

struct DetailsNavigationBarComponent: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        ZStack {
            Color(Asset.Colors.blackBG.name)
            HStack(spacing: 0) {
                Button(
                    action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Image(Asset.Icons.icBack.name)
                            .resizable()
                            .scaledToFit()
                            .frame(width: Layout.scaleFactorW * 24, height: Layout.scaleFactorW * 24)
                    }
                )
                    .padding(.leading, Layout.scaleFactorW * 33)
                    .padding(.top, Layout.scaleFactorH * 66)
                    .padding(.bottom, 8)
                Spacer()
            }
        }
        .frame(height: Layout.scaleFactorH * 92)
        .frame(maxHeight: .infinity, alignment: .top)
    }
}
