//
//  Created by Nikita Gavrikov on 12.12.2021
//  Copyright © 2021 Ronas IT. All rights reserved.
//

import SwiftUI

struct LocationDetailsInfoView: View {
    var location: Location

    var body: some View {
        VStack(spacing: 16) {
            HStack {
                Text(L10n.Details.Info.title)
                    .font(Font.appFontSemibold(ofSize: Layout.scaleFactorW * 17))
                    .foregroundColor(.white)
                    .frame(height: 22)
                Spacer()
            }
            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .foregroundColor(Color(Asset.Colors.blackCard.name))
                    .frame(width: Layout.scaleFactorW * 327, height: 96)
                VStack(spacing: 16) {
                    HStack {
                        Text(L10n.Details.Info.type)
                            .font(Font.appFontMedium(ofSize: Layout.scaleFactorW * 16))
                            .foregroundColor(Color(Asset.Colors.grayNormal.name))
                            .frame(height: 24)
                        Spacer()
                        Text(location.type.rawValue)
                            .font(Font.appFontMedium(ofSize: Layout.scaleFactorW * 16))
                            .foregroundColor(.white)
                            .frame(height: 24)
                    }
                    HStack {
                        Text(L10n.Details.Info.dimension)
                            .font(Font.appFontMedium(ofSize: Layout.scaleFactorW * 16))
                            .foregroundColor(Color(Asset.Colors.grayNormal.name))
                            .frame(height: 24)
                        Spacer()
                        Text(location.dimension.rawValue)
                            .font(Font.appFontMedium(ofSize: Layout.scaleFactorW * 16))
                            .foregroundColor(.white)
                            .frame(height: 24)
                    }
                }
                .padding(.horizontal, Layout.scaleFactorW * 16)
                .padding(.vertical, 16)
            }
        }
        .padding(.horizontal, Layout.scaleFactorW * 24)
    }
}
